#!/bin/bash
# Установить xkb-switch
# https://github.com/grwlf/xkb-switch.git

xkb-switch -s us

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#ff00ffcc'  # default
T='#ee00eeee'  # text
W='#880000bb'  # wrong
V='#c5c2c2'              # '#bb00bbbb'  # verifying

if [ -x "$(command -v safeeyes)" ]; then
    safeeyesStatus=false
    safeeyesCurrentStatus=$(safeeyes --status)
    if [[ "$safeeyesCurrentStatus" == *"Следующий перерыв"* ]];then
        safeeyesStatus=true
    fi
fi

if [ -x "$(command -v betterlockscreen)" ]; then
    if $safeeyesStatus ; then
        safeeyes --disable
        betterlockscreen -l dimblur --display 1 --span
        safeeyes --enable
    else
        betterlockscreen -l dimblur --display 1 --span
    fi

elif [ -x "$(command -v multilockscreen)" ]; then
    multilockscreen -l dimblur --display 1 --span
else
# --keyhlcolor 880088cc \
    i3lock \
        --blur 5 \
        --bar-indicator \
        --bar-pos h \
        --bar-direction 1 \
        --bar-max-height 50 \
        --bar-base-width 50 \
        --bar-color 000000cc \
        --keyhl-color 002F329F \
        --bar-periodic-step 50 \
        --bar-step 50 \
        --redraw-thread \
        \
        --clock \
        --force-clock \
        --date-align 1 \
        --time-align 1 \
        --ringver-color 8800ff88 \
        --ringwrong-color ff008888 \
        --status-pos 5:h-16 \
        --verif-align 1 \
        --wrong-align 1 \
        --modif-pos -50:-50 \
        \
        --screen 1
fi
