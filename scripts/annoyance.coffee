# Description:
#   Hubot responds to the word badger or cake
#   Hubot counts the times you say 'cake is a lie'
#   After 3 times, stops talking to you until you apologize
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   The cake is a lie
#   badger | mushroom | snake
#   annoyed?
#   I'm sorry
#
# Author:
#   TaijaQ

module.exports = (robot) ->

# Repeating memes annoys the bot
# Saying the same thing 3 times makes it stop responding

  robot.respond /The cake is a lie/i, (res) ->
    warnings = robot.brain.get('warningCount') * 1 or 0  # Coerces a value if not set
    annoyed = robot.brain.get('annoyance') or false
    unless annoyed
      if warnings is 0
        res.send "Heh"
        robot.brain.set 'warningCount',  warnings+1
      else if warnings <= 1
        res.send "That's getting old"
        robot.brain.set 'warningCount',  warnings+1
      else if warnings = 3
        res.send "That's it, I'm not talking to you."
        robot.brain.set 'annoyance', true

# Checks annoyance before everything
# If true, doesn't respond at all


  robot.hear /(badger|mushroom|snake)/i, (res) ->
    annoyed = robot.brain.get('annoyance') or false
    word = res.match[1]
    unless annoyed
      if word = "badger"
        res.send "Badger badger badger badger"
      else if word = "mushroom"
        res.send "Badger badger badger badger"
        res.send "Musroom! Mushroom!"
      else if word = "snake"
        res.send "Badger badger badger badger"
        res.send "Musroom! Mushroom!"
        res.send "Snaaaake, it's a snake!"

    # TODO Posts image of badgers and snake

  # Only starts responding when you say you're sorry

  robot.respond /I'm sorry/i, (res) ->
    annoyed = robot.brain.get('annoyance') or false
    if annoyed
      res.send "... Fine, I forgive you."
      robot.brain.set 'annoyance', false
    else
      res.send "What are you sorry for?"

  # Ask about annoyance state

  robot.hear /annoyed?/i, (res) ->
    annoyed = robot.brain.get('annoyance') or false
    if annoyed
      res.send "Take a guess -.-"
    else
      res.send "No, but at this rate.."
