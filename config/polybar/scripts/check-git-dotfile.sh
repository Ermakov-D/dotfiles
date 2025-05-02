#!/bin/bash

cd /home/depeche/.dotfile

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo " : %{F#3cb703}Ok"
elif [ $LOCAL = $BASE ]; then
    echo " : %{F#f9dd04} "
elif [ $REMOTE = $BASE ]; then
    echo " : %{F#f9dd04} "
else
    echo " : %{F#d60606} "
fi

