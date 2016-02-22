# Description:
#   Fetches a list of Slack files with character and line counts
#
# Dependencies:
#   hubot-slack
#
# Configuration:
#   YOUR_SLACK_TOKEN
#
# Commands:
#	Hubot List [files]
#
# Author:
#   TaijaQ

module.exports = (robot) ->

	robot.respond /List (.*)/i, (msg) ->

		# query = The API method

		query = msg.match[1] + ".list"

		base = "https://slack.com/api/"
		token = "?token=" + process.env.YOUR_SLACK_TOKEN
		pretty = "&pretty=1"

		# Create the url for the HTTP call with the right method and token
		# Post the url so it can be debugged

		url = base + query + token + pretty
		msg.send "Url: " + url

		# Basic HTTP Request for a list of the files

		msg.http(url)
		.get() (err, res, body) ->
	    	# Error checking code

	    	# Res is node.js's http.ServerResponse
	    	# Methods:
	    	# 		res.statusCode
	    	# 		res.getHeader

	    	if res.statusCode isnt 200
	    		res.send "Something went wrong"

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
