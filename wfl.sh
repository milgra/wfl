#!/usr/bin/env bash

PIPE_IN="/tmp/wfl"

rm -f $PIPE_IN
mkfifo $PIPE_IN
exec 3<>$PIPE_IN

kuid -v <&3 | while IFS= read -r line; do
    echo $line
    words=($line)
    if [ ${words[0]} = "event" ]
    then
	# init events
	if [ ${words[1]} = "init" ]
	then
	    # init layer
	    echo "create layer width 300 height 295 anchor rt margin 10" >&3
	    echo "load html src ~/.config/wfl/res/main.html" >&3

	    echo "set text div item0label value Terminal" >&3
	    echo "set text div item0number value 0" >&3
	    echo "set text div item1label value Nautilus" >&3
	    echo "set text div item1number value 1" >&3
	    echo "set text div item2label value Chromium" >&3
	    echo "set text div item2number value 2" >&3
	    echo "set text div item3label value LibreOffice" >&3
	    echo "set text div item3number value 3" >&3
	    echo "set text div item4label value MMFM" >&3
	    echo "set text div item4number value 4" >&3
	    echo "set text div item5label value VMP" >&3
	    echo "set text div item5number value 5" >&3

	# button events
	elif [ ${words[1]} == "state" ]
	then
	    if [ ${words[3]} == "item0labelback" ]
	    then
		swaymsg exec foot
		echo "toggle visibility" >&3
	    elif [ ${words[3]} == "item1labelback" ]
	    then
		swaymsg exec "nautilus --new-window"
		echo "toggle visibility" >&3
	    elif [ ${words[3]} == "item2labelback" ]
	    then
		swaymsg exec chromium
		echo "toggle visibility" >&3
	    elif [ ${words[3]} == "item3labelback" ]
	    then
		swaymsg exec libreoffice
		echo "toggle visibility" >&3
	    elif [ ${words[3]} == "item4labelback" ]
	    then
		swaymsg exec mmfm
		echo "toggle visibility" >&3
	    elif [ ${words[3]} == "item5labelback" ]
	    then
		swaymsg exec vmp
		echo "toggle visibility" >&3
	    fi
	fi
    fi

done
