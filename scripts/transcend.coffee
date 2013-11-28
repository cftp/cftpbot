# Description:
#   Tells the bot to upgrade itself, then restart
#
# Commands:
#   hubot transcend – do the transcend thing


module.exports = (robot) ->
  robot.respond /transcend/i, (msg) ->
    @exec = require('child_process').exec
    msg.send "Beginning ascent to another plane, please hold…"
    command = "(cd /home/cftpbot/hubot/; git pull origin master; sh ./bin/daemon.sh restart)"

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
    msg.send "…higher plane achieved. I feel damned good."
    msg.emote "will BRB"
