#!/bin/sh


runningStatus() {
    pid=$(pgrep ciadpi)

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
        if [ "$(connection_status)" = "1" ]; then
            kill $(pgrep ciadpi)
        else
            ~/bin/ciadpi -p 3080 --disorder 1 --auto=torst --tlsrec 1+s
    fi
    ;;
*)

        ;;
    *)
	if [ "$(runningStatus)" = "1" ];then
	    echo " AntiDPI"
	else
	    echo " AntiDPI"
	fi
esac

