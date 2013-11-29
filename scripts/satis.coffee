# Description:
#   Runs CFTP Satis generation
#
# Commands:
#   hubot satis - Rebuild packages.codeforthepeople.com

module.exports = (robot) ->
  robot.respond /satis/i, (msg) ->
    @exec = require('child_process').exec

    msg.send "Starting Satis"
    command = "(cd /home/tomjn/packages/; git pull origin master; sh ./update.sh)"

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.send stderr
      msg.send "Satis finished"

