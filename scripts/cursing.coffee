# Description:
#   Hubot learns to curse
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#	hubot curseout|curseoff|cursebattle on 			Starts counting curse words
#	hubot curseout|curseoff|cursebattle off			Stops counting curse words
#	hubot you are (a|an) <insult>					Adds the word to memory and counts the times it has been said
#	hubot list insults|curses|curse words 			Lists all known insults and their counts
#	hubot insult|curse (<insult>) count 			Returns the total or a specific word's count
#
# Author:
#   TaijaQ

class curseMode
	constructor: (@robot) ->
		@cache =
			insults: {}
			sessions: {}
			insultCount: 0
			on: false
		@robot.brain.on 'loaded', =>
			@robot.brain.data.cursing ||= {}
			@robot.brain.data.curseouts ||= {}

			@cache.insults = @robot.brain.data.cursing
			@cache.sessions = @robot.brain.data.curseouts
	start: (start) ->
		if start and @cache.on is false
			date = new Date()
			console.log date + ": Starting curse mode.."
			@cache.on = true
		return @cache.on
	curse: (insult) ->
		curseWords = []
		for word, count of @cache.insults
			unless insult is word
				curseWords.push word
		if curseWords.length is 0
			console.log "No cursewords"
			starters = ['fuck', 'dammit', 'damn']
			for i of starters
				unless insult is starters[i]
					curseWords.push starters[i]
		console.log curseWords
		return curseWords
	findInsult: (insult) ->
		console.log "Finding an insult.."
		found = false
		for name, count of @cache.insults
			if name is insult
				found = true
				return found
			else
				found = false
		return found
	addInsult: (insult, newWord) ->
		if newWord is true
			@cache.insults[insult] = 1
		else
			@cache.insults[insult]++
		@cache.insultCount = @cache.insultCount + 1
	listInsults: () ->
		list = "Insults:\n"
		for name, count of @cache.insults
			list = list + "#{name} (#{count} times)\n"
		return list
	insultCount: (word) ->
		if word is 'total'
			count = 0
			for name, amount of @cache.insults
				count++
			console.log "Insult count: " + count
			return count
		else
			found = @findInsult(word)
			if found is true
				count = @cache.insults[word]
				return count
			else
				return null
	stop: () ->
		date = new Date()
		sessionCount = @cache.insultCount
		@cache.sessions[date] = sessionCount
		@robot.brain.data.cursing = @cache.insults
		@robot.brain.data.curseouts = @cache.sessions
		console.log date + ": Stopping curse mode.."
		@cache.insultCount = 0
		@cache.on = false
		session = "#{date}: #{sessionCount} seperate insults were thrown"
		return session

module.exports = (robot) ->

	curseMode = new curseMode robot

	robot.hear /(curseout|curseoff|cursebattle) on/i, (msg) ->
		unless curseMode.start() is true
			curseMode.start('start')
			curses = msg.random curseMode.curse()
			msg.send curses + "! It's on"


	robot.hear /((curseout|curseoff|cursebattle) off|I surrender)/i, (msg) ->
		unless curseMode.start() is false
			curse = msg.random curseMode.curse()
			session = curseMode.stop()
			msg.send "Fine, #{curse}."
			msg.send session

	robot.hear /you are( a| an)? (.*)/i, (msg) ->
		unless curseMode.start() is false
			if msg.match[1]?
				prefix = msg.match[1]
				prefix = prefix.replace /a/g, "A"
			insult = msg.match[2]
			console.log "Insult: " + insult
			found = curseMode.findInsult(insult)
			console.log "Found? " + found
			if found is false
				curseMode.addInsult(insult, true)
				if prefix
					msg.send "#{prefix} #{insult}?"
				else
					msg.send "#{insult}?"
			else if found is true
				curseMode.addInsult(insult, false)
				#curseMode.curse(insult)
				msg.send "That's original.."
		else
			msg.send "That's not very nice"

	robot.hear /list (insults|curses|curse words)/i, (msg) ->
		list = curseMode.listInsults()
		msg.send list

	robot.hear /(insult|curse) (.*)?count/i, (msg) ->
		if msg.match[2]?
			word = msg.match[2].trim()
			count = curseMode.insultCount(word)
			if count is null
				msg.send "That word hasnt been used"
			else
				msg.send "The insult '#{word}' has been used #{count} times"
		else
			count = curseMode.insultCount('total')
			msg.send "A total of #{count} different curse words have been flinged"