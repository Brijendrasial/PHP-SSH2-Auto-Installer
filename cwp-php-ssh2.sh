#!/bin/bash

# PHP-SSH2 Installer in Centos Web Panel

# Simple Bash script by Bullten Web Hosting Solutions [http://www.bullten.com]

CDIR='/usr/local/ssh2'
PATHPHP='/usr/local/php/php.ini'
SOURCE_URL_1='http://www.libssh2.org/download/libssh2-1.5.0.tar.gz'
SOURCE_URL_2='https://pecl.php.net/get/ssh2-0.12.tgz'
packagelibssh="libssh2-1.5.0.tar.gz"
packagessh="ssh2-0.12.tgz"
RED='\033[01;31m'
RESET='\033[0m'
GREEN='\033[01;32m'


clear

echo -e "$GREEN******************************************************************************$RESET"
echo -e "   PHP-SSH2 Installation in CentOS Web Panel [http://centos-webpanel.com] $RESET"
echo -e "       Bullten Web Hosting Solutions http://www.bullten.com/"
echo -e "   Web Hosting Company Specialized in Providing Managed VPS and Dedicated Server   "
echo -e "$GREEN******************************************************************************$RESET"
echo " "
echo " "
echo -e $RED"This script will install PHP-SSH2 on your system"$RESET
echo -e $RED""
echo -n  "Press ENTER to start the installation  ...."
read option

clear

echo ""
echo -e $RED"Installing libssh2 on your system"$RESET
sleep 5

rm -rf $CDIR; mkdir $CDIR

cd $CDIR
wget $SOURCE_URL_1
tar zxvf $packagelibssh
cd libssh2-1.5.0
./configure --enable-shared --with-gnu-ld
make && make install

echo ""
echo -e $RED"libssh2 installed on your system"$RESET
sleep 5

clear

echo ""
echo -e $RED"Installing ssh2 on your system"$RESET
sleep 5

cd $CDIR
wget $SOURCE_URL_2
tar zxvf $packagessh
cd ssh2-0.12
phpize
./configure --with-ssh2
make && make install

echo ""
echo -e $RED"ssh2 installed on your system"$RESET
sleep 5

clear

echo ""
echo -e $RED"Enabling php extension for ssh2"$RESET
sleep 5

if [ -e "/usr/local/php/php.ini" ];then

sed -i '/extension=ssh2.so/d' $PATHPHP
echo "extension=ssh2.so" >> $PATHPHP
echo -e $RED"PHP-SSH2 installation completed."$RESET

else

echo ""
echo -e $RED"php.ini doesnt exist / Installation failed."$RESET

fi

echo ""
echo -e $RED"Restarting Apache"$RESET

service httpd restart

sleep 2

echo ""
echo -e $RED"Checking installation"$RESET
php -i | grep ssh2