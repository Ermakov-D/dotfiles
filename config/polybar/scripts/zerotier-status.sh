#!/bin/sh

networkname=Depeche-ZeroTier
ztInterface=zt0

connectionStatus=$(zerotier-cli listnetworks | grep "$ztInterface" | awk '{print $6}')

case "$connectionStatus" in
OK)
    #echo "  ZeroTier   "
    echo " ZeroTier"
    ;;
*)
    echo " ZeroTier"
    ;;
esac

