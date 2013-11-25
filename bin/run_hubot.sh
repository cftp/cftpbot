#!/bin/bash

# Hubot settings

export HUBOT_HIPCHAT_JID="69572_555910@chat.hipchat.com"
export HUBOT_HIPCHAT_PASSWORD="N7C3C21ucMycp0KjK5uycMpwNAh0ZS"
export HUBOT_HIPCHAT_ROOMS="All"
export HUBOT_AUTH_ADMIN="@simonw"

export HUBOT_WEATHER_CELSIUS=1
export HUBOT_FORECAST_API_KEY="8beaa617c09584ac71c4f4f70c5fd09a"

export HUBOT_GITHUB_TOKEN=c3b373a19d24a0aadd33ac06b3959ffd1e982ed3
export HUBOT_GITHUB_USER=cftpdeploy

bin/hubot --adapter hipchat
