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
            kill $(pidof xray)
            if [[ $HOSTNAME == "depeche-host" ]]; then
                kill $(pgrep autossh)            
            fi
        else
            # Orig: /usr/bin/xray -c /home/depeche/Nextcloud/VPNKeys/xray-xhttp.json >/dev/null 2>&1 &
            # Out to journalctl
            if [[ $HOSTNAME == "depeche-host" ]]; then
                autossh -M 0 -f -N 03-tunnel
                systemd-cat -t xray-client -p info /usr/bin/xray -c /home/depeche/Nextcloud/VPNKeys/xray-xhttp-via-localhost.json &
            else
                systemd-cat -t xray-client -p info /usr/bin/xray -c /home/depeche/Nextcloud/VPNKeys/xray-xhttp.json &
            fi
        fi
        ;;
    *)
        case "$(runningStatus)" in
            xray)
                proxyIP=$(timeout 5 curl -x socks5h://127.0.0.1:2082 -s ifconfig.io/ip)
                echo " [s2082: $proxyIP]"
                ;;
            *)
                echo " xray"
	    esac

esac

