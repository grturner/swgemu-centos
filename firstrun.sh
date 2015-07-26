#!/bin/bash
############################################################
#
#    SWGEmu CentOS 6 Setup & Install
#    Based on information posted by Aso @
#	    http://www.swgemu.com/forums/showthread.php?t=161787
#    Modified by grturner at
#    http://www.github.com/grturner
#
############################################################

echo "SWGEmu CentOS 6 Setup and Install"

#### Install required pkgs
echo "Installing required packages."
read -p "Press any key to continue or ctl-c to abort."
sudo yum -y install gcc-c++ make gdb automake git lua lua-devel mysql-server mysql-devel java-1.8.0-openjdk boost-devel wget
sudo chkconfig mysqld on
sudo service mysqld start
sudo mysql_secure_installation

#### Install Berkeley DB ####
echo 'Now installing Berkeley DB 5'
read -p 'Press any key to continue or press ctl-c to abort.'
cd /tmp
wget http://download.oracle.com/berkeley-db/db-5.0.32.NC.tar.gz
tar xzf db-5.0.32.NC.tar.gz && cd ./db-5.0.32.NC/build_unix/
../dist/configure
make
sudo make install
cd
rm -rf /tmp/db-5.0.32.NC


#### Anonymous git pull ####
echo 'We will now setup your local code repository for anonymous pulls from SWGEmu'
read -p 'Press any key to continue or ctl-c to abort'
cd ~
if [ -d ~/git ]; then
	cd ~/git
else
	mkdir ~/git
	cd ~/git
fi
git clone -b unstable http://gerrit.swgemu.com/Core3
git clone -b master http://gerrit.swgemu.com/PublicEngine


#### Generate necessary symlinks and copying files ####
echo 'We are now going to generate some symlinks.'
read -p 'Press any key to continue or ctl-c to exit'
sudo ln -s /usr/local/BerkeleyDB.5.0/lib/libdb-5.0.so /usr/lib64/libdb-5.0.so
sudo ln -s /usr/lib64/mysql/libmysqlclient.so /usr/lib64/libmysqlclient.so
sudo ln -s /usr/lib64/mysql/libmysqlclient.so.16 /usr/lib64/libmysqlclient.so.16
sudo ldconfig
ln -s ~/git/PublicEngine/MMOEngine ~/git/Core3/MMOEngine
sudo ln -s ~/git/PublicEngine/MMOEngine/bin/idlc /usr/local/bin/idlc
chmod 755 ~/git/PublicEngine/MMOEngine/bin/idlc
echo "Your system is now configured to build SWGEmu"
echo "Please use the build script."
exit 1
