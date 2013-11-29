# Description:
#   Runs CFTP Satis generation
#
# Commands:
#   hubot satis - Rebuild packages.codeforthepeople.com

module.exports = (robot) ->
  escape = (s) -> (''+s).replace(/&/g, '&amp;').replace(/</g, '&lt;')
        .replace(/>/g, '&gt;').replace(/"/g, '&quot;')
        .replace(/'/g, '&#x27;').replace(/\//g,'&#x2F;')
  robot.respond /satis/i, (msg) ->
    @exec = require('child_process').exec

    msg.send "Starting Satis"
    command = "(cd /home/tomjn/packages/; git pull origin master; sh ./update.sh)"

    
    try
      @exec command, (error, stdout, stderr) ->
        err = escape error
        out = escape stdout
        stde = escape stderr
        msg.send err
        msg.send out
        msg.send stde
        msg.send "Satis finished"
    catch e
      ex = escape e
      msg.send "I tried so hard, but the satis script wouldn't listen =("
      msg.send ex
      msg.emote "pulls itself back together"
