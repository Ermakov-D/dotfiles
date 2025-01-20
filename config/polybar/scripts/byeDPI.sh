#!/bin/sh
# v 0.2 for two proxy

runningStatus() {
    if pgrep -x "ciadpi" >/dev/null; then
        if pgrep -x "spoof-dpi" >/dev/null; then
            echo "ciaDPI-spoofDPI"
        else
            echo "ciaDPI"
        fi
    elif pgrep -x "spoof-dpi" >/dev/null; then
        if pgrep -x "ciadpi"; then
            echo "ciaDPI-spoofDPI"
        else
            echo "spoofDPI"
        fi
    else
        echo "2"
    fi
}

case "$1" in
    --ciadpi)
        if [ $(runningStatus) = "ciaDPI" ] || [ $(runningStatus) = "ciaDPI-spoofDPI" ]; then
            kill $(pgrep ciadpi)
        else
            #~/bin/ciadpi --ip 127.0.0.1 -p 3080 --disorder 1 --auto=torst --tlsrec 1+s &
            # см. https://github.com/hufrea/byedpi/discussions/184
            ~/bin/ciadpi --ip 127.0.0.1 -p 3080 --oob 1 --split 2 --mod-http h,d --auto torst --fake -1 --tlsrec 3+s --md5sig --auto none
        fi
        ;;
    --spoofdpi)
        if  [ $(runningStatus) = "spoofDPI" ] || [ $(runningStatus) = "ciaDPI-spoofDPI" ]; then
            kill $(pgrep spoof-dpi)
        else
            ~/bin/spoof-dpi -addr 127.0.0.1 -dns-addr 9.9.9.9 -port 3081 -window-size 0 &
        fi
        ;;
    *)
        case "$(runningStatus)" in
            ciaDPI-spoofDPI)
                echo " [ciaDPI|SpoofDPI]"
                ;;
            ciaDPI)
                echo " [ciaDPI]"
                ;;
            spoofDPI)
                echo " [SpoofDPI]"
                ;;
            *)
                echo " AntiDPI"
	    esac

esac

