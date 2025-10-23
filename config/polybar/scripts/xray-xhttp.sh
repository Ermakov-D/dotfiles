#!/bin/sh

runningStatus() {
    if pgrep -x "xray" >/dev/null; then
        echo "xray"
    else
        echo "no-xray"
    fi
}

case "$1" in
    --xray)
        if [ $(runningStatus) = "xray" ] ; then
            kill $(pgrep xray)
        else
            /usr/bin/xray -c /home/depeche/Nextcloud/VPNKeys/xray-xhttp.json
        fi
        ;;
    *)
        case "$(runningStatus)" in
            xray)
                proxyIP=$(curl -x socks5h://127.0.0.1:2082 -s ifconfig.io/ip)
                echo " [xray: $proxyIP]"
                ;;
            *)
                echo " xray"
	    esac

esac

