#!/bin/sh

networkname=Depeche-ZeroTier

connectionStatus=$(zerotier-cli listnetworks | grep "$networkname" | awk '{print $6}')

case "$connectionStatus" in
OK)
    #echo " i ZeroTier        "
    echo " ZeroTier"
    ;;
*)
    echo " ZeroTier"
    ;;
esac

