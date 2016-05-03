# Description:
#   Fetches a list of Slack files with character and line counts
#
# Dependencies:
#   hubot-slack
#
# Configuration:
#   YOUR_SLACK_TOKEN 	Your own Slack API token, NOT the bot's API token
#
# Commands:
#	Hubot List [files]
#
# Author:
#   TaijaQ

module.exports = (robot) ->

	robot.respond /List (files)/i, (msg) ->

		# query = The API method
		# Here used for files.list
		# but could also work with users.list, channels.list etc

		query = msg.match[1] + ".list"

		base = "https://slack.com/api/"
		token = "?token=" + process.env.YOUR_SLACK_TOKEN
		pretty = "&pretty=1"

		# Creates the url for the HTTP call with the right method and token

		url = base + query + token + pretty

		# Posts the url for easy debugging

		msg.send "Url: " + url

		# Basic HTTP request

		msg.http(url)
		.get() (err, res, body) ->

	    	# Res is node.js's http.ServerResponse
	    	# Methods:
	    	# 		res.statusCode
	    	# 		res.getHeader

	    	if res.statusCode isnt 200
	    		msg.send "Something went wrong"

	    	# Parse the JSON
	    	data = JSON.parse body
	    	amount = data.paging.total
	    	files = data.files

	    	msg.send "There are #{amount} files"
	    	msg.send "Listing files.."

	    	for i of files
	    		if count?
	    			count = count + 1
	    		else count = 1
	    		title = files[i].title
	    		fileName = files[i].name
	    		size = files[i].size
	    		lines = files[i].lines + files[i].lines_more
	    		mode = files[i].mode

	    		msg.send "#{count} - #{title}   (#{fileName})  [#{size} characters, #{lines} lines]"
	    		if totalLines?
	    			totalLines = totalLines + lines
	    		else
	    			totalLines = lines

	    	msg.send "Total lines: #{totalLines}"
