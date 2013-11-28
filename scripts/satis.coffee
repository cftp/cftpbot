# Description:
#   Runs CFTP Satis generation
#
# Commands:
#   hubot satis - Run the stuff


module.exports = (robot) ->
  robot.respond /satis/i, (msg) ->
    @exec = require('child_process').exec
    msg.send "starting satis rebuild"
    command = ". /home/tomjn/packages/update.sh"

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
    msg.send "process finished"
