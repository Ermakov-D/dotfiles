#!/bin/sh

ip_connection=$(nmcli -g ip4.address connection show $1)
if [ -z "$(nmcli -g ip4.address connection show $1)" ]; then
        echo " $1"
    else
        echo " $1"
fi
