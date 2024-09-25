#!/bin/sh

hostname=$(uname -n)

case $hostname in
    Ser5)
	    dotfiles_dir="/home/depeche/.dotfiles/"
	    ;;
    depeche-host)
        dotfiles_dir="/home/depeche/.dotfile/"
        ;;
    *)
	dotfiles_dir="/home/depeche/.dotfile/"
esac


if [ $(git -C ${dotfiles_dir} status --porcelain | wc -l) -eq "0" ]; then
  repo_status="local_ok"
else
  repo_status="local_change"
fi

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git -C ${dotfiles_dir} rev-parse @)
REMOTE=$(git -C ${dotfiles_dir} rev-parse "$UPSTREAM")
BASE=$(git -C ${dotfiles_dir} merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo -n "%{F#6bff49}: Ok%{F-}"
elif [ $LOCAL = $BASE ]; then
    echo -n "%{F#ff3205}: Pull%{F-}"
elif [ $REMOTE = $BASE ]; then
    echo -n "%{F#ff3205}: Push%{F-}"
else
    echo -n " :"
fi


if [ $(git -C ${dotfiles_dir} status --porcelain | wc -l) -eq "0" ]; then
  echo
else
	change_file=$(git -C ${dotfiles_dir} status --porcelain | wc -l)
	echo "  :${change_file}"
fi

