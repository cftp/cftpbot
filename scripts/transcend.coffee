# Description:
#   Tells the bot to upgrade itself, then restart
#
# Commands:
#   hubot transcend – do the transcend thing


module.exports = (robot) ->
  escape = (s) -> (''+s).replace(/&/g, '&amp;').replace(/</g, '&lt;')
        .replace(/>/g, '&gt;').replace(/"/g, '&quot;')
        .replace(/'/g, '&#x27;').replace(/\//g,'&#x2F;')
  robot.respond /transcend/i, (msg) ->
    @exec = require('child_process').exec
    msg.send "Beginning ascent to another plane, please hold…"
    command = "(cd /home/cftpbot/hubot/; git pull origin master; sh ./bin/daemon.sh restart)"

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.emote "will BRB"

    try
      @exec command, (error, stdout, stderr) ->
        err = escape error
        out = escape stdout
        stde = escape stderr
        msg.send err
        msg.send out
        msg.send stde
        msg.emote "will BRB"
    catch e
      msg.emote "failed to ascend, wings burnt, hurtling to the ground, deploying safety nets, crash report:"
      ex = escape e
      msg.send ex
      msg.emote "needs a cup of tea"
