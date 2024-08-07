#!/bin/sh


runningStatus() {
    if pgrep -x "ciadpi" >/dev/null
    then
        echo "1"
    else
        echo "2"
    fi
}

case "$1" in
    --toggle)
        if [ $(runningStatus) = "1" ]; then
            kill $(pgrep ciadpi)
        else
            ~/bin/ciadpi --ip 127.0.0.1 -p 3080 --disorder 1 --auto=torst --tlsrec 1+s &
        fi
        ;;
    *)
	    if [ $(runningStatus) = "1" ];then
            echo " AntiDPI"
	    else
	        echo " AntiDPI"
	    fi
esac

