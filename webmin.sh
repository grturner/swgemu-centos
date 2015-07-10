#!/bin/bash
#####################################
#
#    Webmin install script
#    Written by grturner at
#	    http://www.github.com/grturner
#
####################################

if [ -f /etc/yum.repos.d/webmin.repo ]; then
	echo "It looks like you already have Webmin installed"
else
	sudo touch /etc/yum.repos.d/webmin.repo
	sudo echo "[Webmin]
	name=Webmin Distribution Neutral
	#baseurl=http://download.webmin.com/download/yum
	mirrorlist=http://download.webmin.com/download/yum/mirrorlist" >> /etc/yum.repos.d/webmin.repo
	cd /tmp
	wget http://www.webmin.com/jcameron-key.asc
	sudo rpm --import jcameron-key.asc
	sudo yum update
	sudo yum -y install webmin
	sudo chkconfig webmin on
	rm /tmp/jcameron-key.asc
	exit 1
fi