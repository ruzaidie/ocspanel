Auto-Install Script :-

1. apt-get update && apt-get -y install mysql-server

2. mysql_secure_installation

  -----------------------------------------------------------------------
  Change the root password? [Y/n]: n
  Remove anonymous users? [Y/n]: y
  Disallow root login remotely? [Y/n]: y
  Remove test database and access to it? [Y/n]: y
  Reload privilege tables now? [Y/n]: y
  -----------------------------------------------------------------------
  
3. apt-get install wget && wget https://raw.github.com/blazevpn/ocspanel/master/ocsdebian7.sh && ./ocsdebian7.sh
