# Description:
#   Manners cost nothing. Say hello and goodbye.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Morning makes hubot say morning to you back
#   Hello or Good Day make hubot say hello to you back
send_offs = [
  "Good night, baby. %s",
  "Night hot stuff. %s",
  "Like I'm going to let you get any sleep %s",
  "LOOK...the moon is calling you, SEE...the stars are shining for you, HEAR... my heart saying good night. %s",
  "Sleep tight, don't let the bed bugs bite %s",
  "May you never urinate the sweet sweet sounds of 70's disco funk %s",
  "So long, and thanks for all the fish. %s",
  "Finally %s",
  "À voir! %s",
  "Don't let the back door hit ya where the good Lord split ya %s",
  "May your feet never fall off and grow back as cactuses %s",
  "TTYL %s",
  "C U L8R %s",
  "Fine, then go! %s",
  "Cheers %s",
  "Uh, I can hear the voices calling me...see ya %s",
  "In a while, crocodile %s",
  "SHOO! SHOO! %s",
  "No more of you. %s",
  "Avada Kedavra, %s"
]

module.exports = (robot) ->
	robot.hear /(hello|good( [d'])?ay(e)?)/i, (msg) ->
		hello = msg.random hellos
		msg.send hello.replace "% %s", msg.message.user.name

	robot.hear /(^m(a|o)rnin(g)?)/i, (msg) ->
		msg.send "Morning, %s".replace "% %s", msg.message.user.name

	robot.hear /(good night|bye|nighty night)/i, (msg) ->
		send_off = msg.random send_offs
		msg.send send_off.replace "%s", msg.message.user.name
