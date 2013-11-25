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
#   hubot seen [name] makes hubot tell you when they were last seen

module.exports = (robot) ->
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

	getAmbiguousUserText = (users) ->
		"Be more specific, I know #{users.length} people named like that: #{(user.name for user in users).join(", ")}"

	# Listen for someone saying "Morning", as per
	# the proper CFTP protocol.
	robot.hear /(^morning)/i, (msg) ->
		msg.send "Morning, %s".replace "%s", msg.message.user.name

	# Listen for someone saying "good night" (or similar)
	robot.hear /(good night|bye|nighty night)/i, (msg) ->
		send_off = msg.random send_offs
		msg.send send_off.replace "%s", msg.message.user.name
  
	# Log whenever someone says something and
	# what they say.
	robot.hear /^(.*)$/i, (msg) ->
		user = robot.brain.userForId( msg.message.user.id )
		user.last = user.last || {}
		user.last.words = msg.message.text
		user.last.seen = new Date()

	# Track the ins
	robot.enter (msg) ->
		user = robot.brain.userForId( msg.message.user.id )
		user.last = user.last || {}
		user.last.left = new Date()
		user.in = true

	# Track the outs
	robot.leave (msg) ->
		user = robot.brain.userForId( msg.message.user.id )
		user.in = false

	# Listen for the "seen [user]" command
	robot.respond /seen \@?([^\?]+)\??/i, (msg) ->
		name = msg.match[1].trim()
		users = robot.brain.usersForFuzzyName(name)
		if users.length is 1
			user = users[0]
			if user.id == msg.message.user.id
				msg.send "You are #{name}, silly."
			else if user.in
				msg.send "I think #{name} is here."
			else if user.last
				msg.send "I last saw #{name} on " + user.last.seen + ", they last said \"" + user.last.words + "\""
			else
				msg.send "I have no idea when #{name} was last seen"
		else if users.length > 1
			msg.send getAmbiguousUserText users
		else
			msg.send "I'm sorry, I don't know anyone called %s.".replace "%s", name

