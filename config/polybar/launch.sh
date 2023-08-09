#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki

# Install the following applications for polybar and icons in polybar if you are on ArcoLinuxD
# awesome-terminal-fonts
# Tip : There are other interesting fonts that provide icons like nerd-fonts-complete

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)


case $desktop in

    i3)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-i3 -c ~/.config/polybar/config &
      done
    else
    polybar --reload mainbar-i3 -c config &
    fi
    # second polybar at bottom
    if type "xrandr" > /dev/null; then
       for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
                if [[ "$m" == "HDMI3" ]]; then
                    #echo "1-> $m"
                    #MONITOR=$m polybar --reload mainbar-i3-extra-hdmi -c ~/.config/polybar/config &
                    MONITOR=$m polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                fi
                if [[ "$m" == "eDP-1" ]]; then
            	    #echo "2-> $m"
                    MONITOR=$m polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                    # polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                fi
		if [[ "$m" == "VGA-1" ]]; then
                    MONITOR=$m polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                    # polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                fi
       done
    else
     polybar --reload mainbar-i3-extra -c config &
    fi
    ;;

    openbox)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-openbox -c ~/.config/polybar/config &
      done
    else
    polybar --reload mainbar-openbox -c ~/.config/polybar/config &
    fi
    # second polybar at bottom
    # if type "xrandr" > /dev/null; then
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-openbox-extra -c ~/.config/polybar/config &
    #   done
    # else
    # polybar --reload mainbar-openbox-extra -c ~/.config/polybar/config &
    # fi
    ;;

    bspwm)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
      done
    else
    polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
    fi
    # second polybar at bottom
    # if type "xrandr" > /dev/null; then
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config &
    #   done
    # else
    # polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config &
    # fi
    ;;

    herbstluftwm)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-herbstluftwm -c ~/.config/polybar/config &
      done
    else
    polybar --reload mainbar-herbstluftwm -c ~/.config/polybar/config &
    fi
    # second polybar at bottom
    # if type "xrandr" > /dev/null; then
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-herbstluftwm-extra -c ~/.config/polybar/config &
    #   done
    # else
    # polybar --reload mainbar-herbstluftwm-extra -c ~/.config/polybar/config &
    # fi
    ;;

    xmonad)
    if [ $count = 1 ]; then
      m=$(xrandr --query | grep " connected" | cut -d" " -f1)
      MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
    else
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
      done
    fi
    # second polybar at bottom
    # if [ $count = 1 ]; then
    #   m=$(xrandr --query | grep " connected" | cut -d" " -f1)
    #   MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
    # else
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
    #   done
    # fi
    ;;

    i3-with-shmlog)
	if type "xrandr" > /dev/null; then
    	    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    		MONITOR=$m polybar --reload mainbar-i3 -c ~/.config/polybar/config &
    	    done
	else
	    polybar --reload mainbar-i3 -c config &
	fi
	# second polybar at bottom
	if type "xrandr" > /dev/null; then
    	    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
                if [[ "$m" == "HDMI3" ]]; then
                    echo "1-> $m"
                    MONITOR=$m polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                fi
                if [[ "$m" == "LVDS1" ]]; then
            	    echo "2-> $m"
                    MONITOR=$m polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                    # polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
                fi
    	    done
	else
    	    polybar --reload mainbar-i3-extra -c config &
	fi
	;;
esac
