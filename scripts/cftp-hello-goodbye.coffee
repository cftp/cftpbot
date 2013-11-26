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

	greeting_respects = [
		"always likes to see someone who's been brought up properly",
		"glances up, looks pleased",
		"likes it when someone follows protocol"
	]

	greeting_grumbles = [
		"mutters about manners costing nothing",
		"thinks people these days need to slow down and say good morning",
		"wishes people would say good morning, like they're expected to",
		"thinks manners cost nothing",
		"remembers the good old days, when people followed the proper protocols",
		"grumbles about people not greeting the channel properly"
	]

	MINUTE        = 1000 * 60
	HOUR          = MINUTE * 60
	DAY           = HOUR * 24
	NOW           = new Date()
	NEW_DAY       = new Date()
	# New days start at 05:00
	NEW_DAY.setHours(5,0,0,0)

	getAmbiguousUserText = (users) ->
		"Be more specific, I know #{users.length} people named like that: #{(user.name for user in users).join(", ")}"

	# Listen for someone saying "good night" (or similar)
	robot.hear /(good night|bye|nighty night)/i, (msg) ->
		send_off = msg.random send_offs
		msg.send send_off.replace "%s", msg.message.user.name
  
	# Log whenever someone says something, anything, and
	# what they say.
	robot.hear /^(.*)$/i, (msg) ->
		user = robot.brain.userForId( msg.message.user.id )
		# Work out if an initial message of "Morning" is expected,
		# as per proper CFTP channel protocol
		morning_due = false
		# Unknown users are expected to say "Morning"
		if ! user.last
			morning_due = true
		else
			# Users who've not spoken since NEW_DAY are expected to say "Morning"
			last_seen = new Date( user.last.seen )
			if NEW_DAY.getTime() > last_seen.getTime()
				morning_due = true
		# Now check if they said "Morning", as per protocol
		if morning_due && msg.message.text.match( /(^morning)/i )
			# YES. Good on them. Sometimes we will express our pleasure
			if Math.random() > 0.9
				msg.emote msg.random greeting_respects
		else if morning_due
			# NO. Frowny face. Sometimes we will express our displeasure at the lack of protocol
			if Math.random() > 0.3
				msg.emote msg.random greeting_grumbles
		# Now store the last time we heard from the person
		user.last = user.last || {}
		user.last.words = msg.message.text
		user.last.seen = new Date()

	# Track the ins
	robot.enter (msg) ->
		user = robot.brain.userForId( msg.message.user.id )
		user.last = user.last || {}
		user.in = true

	# Track the outs
	robot.leave (msg) ->
		user = robot.brain.userForId( msg.message.user.id )
		user.last.left = new Date()
		user.in = false
		msg.send "#{user.name} just left at #{user.last.left}"

	# Listen for the "seen [user]" command
	robot.respond /seen \@?([^\?]+)\??/i, (msg) ->
		name = msg.match[1].trim()
		users = robot.brain.usersForFuzzyName(name)
		if users.length is 1
			user = users[0]
			if user.id == msg.message.user.id
				msg.send "You are #{user.name}, silly."
			else if user.in
				msg.send "I think #{user.name} is here."
			else if user.last
				last = new Date( user.last.seen )
				now = new Date()
				days_passed = Math.round((last.getTime() - now.getTime()) / DAY)
				hours = last.getHours()
				minutes = last.getMinutes()
				if ! days_passed
					last_seen = "at " + hours + ":" + minutes
				else if 1 == days_passed
					last_seen = "a day ago, at " + hours + ":" + minutes
				else
					last_seen = days_passed + " days ago, at " + hours + ":" + minutes
				msg.send "I last saw #{user.name} " + last_seen + ", when they said \"" + user.last.words + "\""
			else
				msg.send "I have no idea when #{user.name} was last seen"
		else if users.length > 1
			msg.send getAmbiguousUserText users
		else
			msg.send "I'm sorry, I don't know anyone called #{name}."

