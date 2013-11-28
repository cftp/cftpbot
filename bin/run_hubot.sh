#!/bin/bash

# Hubot settings

# Reset all variables that might be set
ADAPTER="hipchat"

while [ $# -gt 0 ]
do
	case "$1" in
		--adapter)
			ADAPTER=$2
			echo "Using $ADAPTER adapter"
			shift
			shift
			;;
		--) # End of all options
				shift
				break
				;;
		*)
			echo "WARN: Unknown option (ignored): $1" >&2
			shift
			;;
		*)  # no more options. Stop while loop
				break
				;;
	esac
done

USER_HOME="/home/$USER"
HUBOT_ROOT="$USER_HOME/hubot"
. $HUBOT_ROOT/bin/.hubotrc
. $HUBOT_ROOT/bin/.hubotpass

export HUBOT_ADAPTER=$ADAPTER

bin/hubot
