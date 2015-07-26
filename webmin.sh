#!/bin/bash
#####################################
#
#    Webmin install script
#    Written by grturner at
#    http://www.github.com/grturner
#
####################################

if [ -f /etc/yum.repos.d/webmin.repo ]; then
	echo "It looks like you already have Webmin installed"
else
	sudo touch /etc/yum.repos.d/webmin.repo
	sudo bash -c 'echo "[Webmin]" > /etc/yum.repos.d/webmin.repo'
	sudo bash -c 'echo "name=Webmin Distribution Neutral" >> /etc/yum.repos.d/webmin.repo'
	sudo bash -c 'echo "#baseurl=http://download.webmin.com/download/yum" >> /etc/yum.repos.d/webmin.repo'
	sudo bash -c 'echo "mirrorlist=http://download.webmin.com/download/yum/mirrorlist" >> /etc/yum.repos.d/webmin.repo'
	sudo bash -c 'echo "Enabled=1" >> /etc/yum.repos.d/webmin.repo'
	cd /tmp
	wget http://www.webmin.com/jcameron-key.asc
	sudo rpm --import jcameron-key.asc
	rm /tmp/jcameron-key.asc
fi
sudo yum update
sudo yum -y install webmin
sudo chkconfig webmin on
sudo service webmin start
