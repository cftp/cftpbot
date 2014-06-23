# Description:
#   Provide WP Trac information when trac tickets are mentioned.
#   Mentioning trac tickets prompts the bot to tell you about them
#
# Dependencies:
#   "xml2js": "0.1.14"
#   "jsdom"
#
# Configuration:
#   None
#

jsdom = require 'jsdom'
#fs = require 'fs'  #todo: load jquery from filesystem
jquery = 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'

module.exports = (robot) ->

	# scrape a URL
	# selectors: an array of jquery selectors
	# callback: function that takes (error,response)
	scrapeHttp = (msg, url, selectors, callback) ->
		msg.http(url).
			get() (err, res, body) ->
				# http errors
				if err
					callback err, body
					return
				msg.send "GOT ticket "
				jsdom.env body, [jquery], (errors, window) ->
					# use jquery to run selector and return the elements
					results = (window.$(selector).text().trim() for selector in selectors)
					callback null, results

	# fetch a ticket using http scraping
	ticketScrape = (msg, ticket_number) ->
		ticket_url = 'https://core.trac.wordpress.org/ticket/'+ticket_number
		scrapeHttp  msg, ticket_url,
			['#trac-ticket-title', 'td[headers=h_reporter]', 'td[headers=h_owner]', '#ticket h2 .trac-status', 'td[headers=h_milestone] .milestone']
			(err, response) ->
				if err
					msg.emote "Error retrieving Trac ticket #"+ticket_number
				else
					trac_title     = response[0]
					trac_reporter  = response[1]
					trac_owner     = response[2]
					trac_status    = response[3]
					trac_milestone = response[4]
					if !trac_owner
						trac_owner = "(no owner)"
					msg.send "WP Trac #{ticket_url} #{trac_milestone}, #{trac_reporter}=>#{trac_owner}, #{trac_status}, #{trac_title} "


  	# listen for ticket links
	robot.hear /core\.trac\.wordpress\.org\/ticket\/([0-9]+)/i, (msg) ->
		# fetch ticket information using scraping or jsonrpc

		ticket_number = msg.match[1]
		msg.send "Processing ticket #" + ticket_number
		ticketScrape msg, ticket_number
