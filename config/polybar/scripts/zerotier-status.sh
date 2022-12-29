#!/bin/sh

#networkname=Depeche-ZeroTier
#ztInterface=zt0

connectionStatus() {
 ztInterface=zt0
 connection=$(zerotier-cli listnetworks | grep "$ztInterface" | awk '{print $6}')
 
 case "$connection" in
    OK) 
	echo "1"
	;;
    *)
	echo "2"
	;;
    esac
}

case "$1" in
    --toggle)
	/usr/bin/zerotier-gui &
        ;;
    *)
	if [ "$(connectionStatus)" = "1" ];then
	    echo " ZeroTier"
	else
	    echo " ZeroTier"
	fi
esac

