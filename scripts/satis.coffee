# Description:
#   Runs CFTP Satis generation
#
# Commands:
#   hubot satis - Rebuild packages.codeforthepeople.com

module.exports = (robot) ->
    msg.send "Requesting Satis rebuild"
    http = require 'http'

    http.get { host: 'http://packages.codeforthepeople.com', path: '/?requestbuild=true' }, (res) ->
        msg.send res.statusCode
        msg.send "A rebuild should occur within 2 minutes, and every 30 minutes. Check http://packages.codeforthepeople.com/ for status"
