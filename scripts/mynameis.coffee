# Description:
#   Respond to different names
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot My name is X
#
# Author:
#   TaijaQ

module.exports = (robot) ->
  robot.respond /My name is (.*)/i, (res) ->
    nameMatch = res.match[1]
    if nameMatch is "Taija"
      res.reply "Welcome back, master."
    else if nameMatch is "Timo"
      res.send "#{nameMatch} is not welcome here."
    else
      res.send "Nice to meet you, #{nameMatch}."