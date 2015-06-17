exec{ 'update':
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'yum update -y',
logoutput => true,
}
exec{ 'gcc':
require => Exec['update'], 
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'yum -y install gcc-c++',
logoutput => true,
}
exec{ 'openssl':
require => Exec['gcc'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'yum -y install openssl-devel',
logoutput => true,
}
exec{ 'nginx':
require => Exec['openssl'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'yum -y install nginx',
logoutput => true,
}
exec{ 'nginxstart':
require => Exec['nginx'],
path => ["/usr/bin/","/usr/sbin/","/bin","/sbin"],
command =>'service nginx start',
logoutput => true,
 }
exec{ 'nodeandnpm':
require => Exec['nginx'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'yum -y install node npm --enablerepo=epel',
logoutput => true,
}
exec{ 'express':
require => Exec['nodeandnpm'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'npm install express@2.5.10',
logoutput => true,
}
exec{ 'socketio':
require => Exec['nodeandnpm'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'npm install socket.io@0.9.6',
logoutput => true,
}
exec{ 'ejs':
require => Exec['nodeandnpm'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'npm install ejs@0.7',
logoutput => true,
}
exec{'retrieve_nginxconf':
require => Exec['nodeandnpm'],  
command => "/usr/bin/wget -q https://raw.githubusercontent.com/saileshkotha/One-step-chat-application-on-your-Linux-server/master/nginx.conf -O /etc/nginx/nginx.conf",
logoutput => true,
}
exec{'nginxrestart':
require => Exec['retrieve_nginxconf'],
path => ["/usr/bin/","/usr/sbin/","/bin","/sbin"],
command =>'service nginx restart',
logoutput => true,
}
exec{'client.ejs':
require => Exec['nginxrestart'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'wget https://github.com/kishorenc/NodeSocks/raw/master/client.ejs',
logoutput => true,
}
exec{'server.js':
require => Exec['client.ejs'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'wget https://github.com/kishorenc/NodeSocks/raw/master/server.js',
logoutput => true,
}
#forever is an application by which you can run the chat application in background.
exec{ 'forever':
require => Exec['server.js'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'npm install forever -g',
logoutput => true,
}
exec{ 'startnodesocks':
require => Exec['forever'],
path => ["/usr/bin/","/usr/sbin/","/bin"],
command =>'forever start server.js',
logoutput => true,
}
