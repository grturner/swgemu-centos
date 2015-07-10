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
echo "We will now install some packages."
sudo yum -y install gcc-c++ make gdb automake git lua lua-devel mysql-server mysql-devel java-1.8.0-openjdk boost-devel
sudo chkconfig mysqld on
#### Fix this ######################################
#
#sudo mysqld_secure_installation
#
####################################################

#### Install Berkeley DB ####
cd /tmp
wget http://download.oracle.com/berkeley-db/db-5.0.32.NC.tar.gz
tar xzf db-5.0.32.NC.tar.gz && cd ./db-5.0.32.NC/build_unix/
../dist/configure
make
sudo make install
cd
rm -rf /tmp/db-5.0.32.NC


#### Anonymous git pull ####
cd ~
mkdir ./git
cd git
git clone http://gerrit.swgemu.com/Core3
git clone http://gerrit.swgemu.com/PublicEngine


#### Generate necessary symlinks ####
ln -s ~/git/PublicEngine/MMOEngine ~/git/Core3/MMOEngine
sudo ln -s ~/git/PublicEngine/MMOEngine/bin/idlc /usr/local/bin/idlc
chmod 755 ~/git/PublicEngine/MMOEngine/bin/idlc

echo "Your system is now be configured to build SWGEmu"
exit 1