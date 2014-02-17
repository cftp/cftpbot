# Description:
#   Runs CFTP Satis generation
#
# Commands:
#   hubot satis - Rebuild packages.codeforthepeople.com

module.exports = (robot) ->
  msg.send "Requesting Satis rebuild"
  http = require 'http'

  args =
    host: 'http://packages.codeforthepeople.com'
    path: '/?requestbuild=true'

  http.get args, (res) ->
    msg.send res.statusCode
    message = "A rebuild should occur within 2 minutes, and every 30 minutes."
    message += "Check http://packages.codeforthepeople.com/ for status"
    msg.send message
