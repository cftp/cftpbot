#!/bin/bash

# Hubot settings

USER_HOME="/home/$USER"
HUBOT_ROOT="$USER_HOME/hubot"
. $HUBOT_ROOT/bin/.hubotrc

bin/hubot --adapter hipchat
