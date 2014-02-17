# Description:
#   Runs CFTP Satis generation
#
# Commands:
#   hubot satis - Rebuild packages.codeforthepeople.com

module.exports = (robot) ->
  escape = (s) ->(''+s).replace(/&/g, '&amp;').replace(/</g, '&lt;')
        .replace(/>/g, '&gt;').replace(/"/g, '&quot;')
        .replace(/'/g, '&#x27;').replace(/\//g,'&#x2F;')
  robot.respond /satis/i, (msg) ->
    @exec = require('child_process').exec

    msg.send "Requesting Satis rebuild"
    command = "touch /srv/packages.codeforthepeople.com/tmp/requestrun"
    try
      @exec command, (error, stdout, stderr) ->
        if error?
          err = escape error
          msg.send err
        if stdout?
          out = escape stdout
          msg.send out
        if stderr?
          stde = escape stderr
          msg.send stde

        msg.send "A rebuild should occur within 2 minutes"
    catch e
      e = escape e
      msg.send "I tried so hard, but the satis script wouldn't listen =("
      msg.send e
      msg.emote "pulls itself back together"
