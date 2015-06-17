# One-step-chat-application-on-your-Linux-server

Make your linux server act as an instant chat application.

I have written a puppet script which after applied, if you directly open the ipaddress of linux machine, you are into the chat application.

1. Install puppet
  
  ```  sudo yum -y install puppet ```
  
2. Apply install.pp file [This step takes about 2-3 minutes]

  ```  sudo puppet apply install.pp ```

3. If you are done, open these two links in two tabs in your browser, you can edit the usernames[usr1, usr2]

  ``` http://[ipaddress]/user/usr1 ```

  ``` http://[ipaddress]/user/usr2 ```

  Try to chat between the two users.

4. To stop the chat application 

  ``` sudo forever stop server.js ```

5. To start the chat application again

  ``` sudo forever start server.js ```


install.pp installs all these packages

gcc-c+, openssl-devel, nginx, node, npm, express, socket.io, ejs, forever.

Raw chat application taken from https://github.com/kishorenc/NodeSocks
