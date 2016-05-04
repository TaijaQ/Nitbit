# Nitbit

**Nitbit**, the nitpicking nitwit, is my personal assistant and chat bot. It's built on the Hubot framework and deployed on a dedicated `Rasperry Pi Model B+`. The protype's main interface is Slack and it will have audio output and a small LCD screen.

See the [Wiki](https://github.com/TaijaQ/Nitbit/wiki) for further documentation on development and below for [deployment instructions](#Hubot setup).

## Features

- Responsive AI
    + Changes tone based on your short- and long-term behaviour
    + Different states, such as annoyance
- Expandable vocabularity
    + Learns new words and phrases
    + Creative cursing
- Information management
    + Categorization of concepts
    + Project and task management
    + Logging

#### Architecture

- Raspberry Pi Model B+
    + Raspbian
    + Hubot framework
- Web interfaces
    + Slack
        * Sublime
        * IFTTT
        * Trello
        * Evernote
        * Other integrations
    + Speech-to-text
- Output
    +  LCD screen
    +  Toy dog
        * Text-to-speech audio
        * Movement


## Hubot setup

To create your own Hubot instance, you need node.js and npm. You also need to install the listed [dependencies](#Dependencies) below.

Install the Hubot generator and create your instance:

    npm install -g yo generator-hubot
    yo hubot

Set the [environment variables](#Configuration) and run:

    ./bin/hubot --adapter=slack

#### Dependencies

- hubot-slack
- hubot-scripts
- Vital external scripts (see package.json for full list):
    + hubot-sentimental
    + hubot-plusplus
    + hubot-redis-brain
    + hubot-trello
    + hubot-google-translate
    + hubot-google-images


#### Configuration

Necessary environment variables:

| Variable          | Description                 |
| ----------------- | --------------------------- |
| HUBOT_SLACK_TOKEN | The bot's Slack API token   |
| YOUR_SLACK_TOKEN  | Your Slack API token        |


## Functions

For more information about the scripts, see the [Scripts](https://github.com/TaijaQ/Nitbit/wiki/Scripts)-wikipage.

**List Slack files**

Counts all files and snippets uploaded to Slack and lists them in a neat form. Also adds up the total line count.

    hubot List files

**Annoyance**

Nitbit can get annoyed if memes are repeated. When annoyed, Nitbit will stop responding to most things until you apologise.

    hubot Hey, the cake is a lie
    hubot I'm sorry

To query annoyance state (repeated queries also rack up warnings):

    hubot annoyed|annoyance

**Cursing**

While in curse mode, calling Nitbit names causes it to memorize them.

    hubot curseout|curseoff|cursebattle on|off
    hubot you are (a|an) <insult>

You can list the insults or query a word's count, or the amount of sifferent words if no word is specified.

    hubot list insults
    hubot insult (<insult>) count

**Names**

Responds to names it knows or doesn't know.

    hubot My name is <name>
