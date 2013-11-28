# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo <text> - Reply back with <text>
#   hubot time - Reply with current time
#   hubot die - End hubot process

module.exports = (robot) ->
  var child_process = require('child_process');
  child_process.exec('. /home/tomn/packages/update.sh', function(error, stdout, stderr){
      console.log(stdout);
  });
  robot.respond /satis$/i, (msg) ->
    @exec = require('child_process').exec
    msg.send "starting satis rebuild"
    command = ". /home/tomn/packages/update.sh"

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.send stderr
    msg.send "process finished"
