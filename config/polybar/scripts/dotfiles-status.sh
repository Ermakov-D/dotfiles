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
LOCAL=$(cd ${dotfiles_dir}; git rev-parse @)
REMOTE=$(cd ${dotfiles_dir}; git rev-parse "$UPSTREAM")
BASE=$(cd ${dotfiles_dir}; git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo -n "%{F#6bff49}: Ok%{F-}"
    #echo -n "%{F#6bff49}: Ok%{F-}"
    #echo -n " :Ok"
elif [ $LOCAL = $BASE ]; then
    echo -n "%{F#ff3205}: Pull%{F-}"
    #echo -n " :Pull"
elif [ $REMOTE = $BASE ]; then
    echo -n "%{F#ff3205}: Push%{F-}"
    #echo -n " :Push"
else
    echo -n " :"
fi


if [ $(git -C ${dotfiles_dir} status --porcelain | wc -l) -eq "0" ]; then
  echo
else
	change_file=$(git -C ${dotfiles_dir} status --porcelain | wc -l)
	echo "  :${change_file}"
    #echo "  :${change_file}"
fi



#case $repo_status in
#
#    "local_ok")
#			echo
#	    ;;
#    "local_change")
#	    change_file=$(git status --porcelain | wc -l)
#	    echo " : ${change_file}"
#	    ;;
#    *)
#	    echo " o%{F#ef02db}: Push%{F-}"
#	    ;;
#esac
