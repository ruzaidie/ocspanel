#!/bin/bash
#
# Script by Aiman Amir
# Telegram : @NamiaKai
# ==================================================
# 

#configure MySql server
chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/
apt-get -y install nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt
rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
mv /etc/nginx/conf.d/vps.conf /etc/nginx/conf.d/vps.conf.backup
wget -O /etc/nginx/nginx.conf "https://raw.github.com/blazevpn/ocspanel/master/nginx.conf"
wget -O /etc/nginx/conf.d/vps.conf "https://raw.github.com/blazevpn/ocspanel/master/vps.conf"
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf

# membuat user untuk nginx
useradd -m vps
mkdir -p /home/vps/public_html
rm /home/vps/public_html/index.html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
service php5-fpm restart
service nginx restart

#menginstall OCS Panel
cd
mysql -u root -p
CREATE DATABASE IF NOT EXISTS OCSPANEL
EXIT

#install aplikasi git
apt-get -y install git

#install OCS Panel
cd /home/vps/public_html
git init
git remote add origin https://github.com/stevenindarto/OCSPanel.git
git pull origin master
chmod 777 /home/vps/public_html/config
chmod 777 /home/vps/public_html/config/config.ini
chmod 777 /home/vps/public_html/config/route.ini

#hapus folder instalation 
rm -R /home/vps/public_html/installation

#info
clear
echo "===========================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Buka browser, lalu masukkan tulisan di bawah pada browser anda"  | tee -a log-install.txt
echo "http://ip-vps:85"  | tee -a log-install.txt
echo "(ganti ip-vps menjadi IP server milik anda, contoh: http://49.213.17.122:85)"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Setting seperti berikut:"  | tee -a log-install.txt
echo "DATABASE"  | tee -a log-install.txt
echo "Database Host: localhost"  | tee -a log-install.txt
echo "Database Name: OCSPANEL"  | tee -a log-install.txt
echo "Database User: root"  | tee -a log-install.txt
echo "Database Pass: Password MySQL yang telah dibuat tadi"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "ADMIN LOGIN"  | tee -a log-install.txt
echo "Username: Isikan dengan username OCS yang anda inginkan"  | tee -a log-install.txt
echo "Password Baru: Isikan dengan password OCS yang anda inginkan"  | tee -a log-install.txt
echo "Masukkan Ulang Password: Input ulang password"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "===========================================" | tee -a log-install.txt
cd
