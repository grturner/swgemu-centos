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


#### Begin a bunch of lazy hackery ####
rm -rf ~/git/PublicEngine/MMOEngine/lib/unix &> /dev/null
mkdir ~/git/PublicEngine/MMOEngine/lib/unix
cp ~/git/PublicEngine/MMOEngine/lib/linux64/libengine3.a ~/git/PublicEngine/MMOEngine/lib/unix
sed -i '61s/usr\/local\/include/usr\/include/' ~/git/Core3/MMOCoreORB/configure.ac
sed -i '62s/lib/lib64/' ~/git/Core3/MMOCoreORB/configure.ac
sed -i '62s/lib6464/lib64/' ~/git/Core3/MMOCoreORB/configure.ac
#### End a bunch of lazy hackery ####

#### Start quality scurby code.... mmmm scurby code ####
cd ~/git/Core3/MMOCoreORB
export CLASSPATH=/home/`whoami`/git/Core3/MMOEngine/bin/idlc.jar

EXTRA=$1


if [ ! -f build/unix/config.log ]; then
	EXTRA='config'
fi

case $EXTRA in
	config ) make config && make clean 
	;;
	clean ) make clean 
	;;
esac

if make -k build; then
	echo "** BUILD SUCCESS IN $SECONDS SECOND(S) **"
	exit 0
fi

echo "** BUILD FAILED **"
exit 1
