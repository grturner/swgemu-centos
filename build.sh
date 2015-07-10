#!/bin/bash
#############################################
#
#     SWGEmu Build Script
#     Modified from Scurby at
#     http://www.github.com/scurby
#     Modified by grturner at
#     http://www.github.com/grturner
#
#############################################

cd ~/git/Core3/MMOCoreORB
export CLASSPATH=/home/swgemu/git/Core3/MMOEngine/bin/idlc.jar

EXTRA=$1


if [ ! -f build/unix/config.log ]; then
	EXTRA='config'
fi

case $EXTRA
	config ) make config; make clean ;;
	clean ) make clean ;;
esac

if make -k build; then
	echo "** BUILD SUCCESS IN $SECONDS SECOND(S) **"
	exit 0
fi

echo "** BUILD FAILED **"
exit 1
