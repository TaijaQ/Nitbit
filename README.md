# Nitbit

*Nitbit*, the nitpicking nitwit bot, is my personal assistant based on the Hubot framework. It runs on a dedicated Rasperry Pi Model B+ and is used with a Slack adapter.

## Hubot setup

To create your own Hubot instance, you need node.js and npm. You also need to install the listed [dependencies](#Dependencies) below.

Install the Hubot generator:

    npm install -g yo generator-hubot

Set the [environment variables](#Configuration) and run:

    ./bin/hubot --adapter=slack

### Dependencies

- hubot-slack
- hubot-sentimental
- hubot-plusplus
- hubot-scripts
- hubot-google-translate
- hubot-google-images
- hubot-help
- hubot-redis-brain
- hubot-shipit
- hubot-pugme

### Configuration

Environment variables:

| Variable          | Description                 |
| ----------------- | --------------------------- |
| HUBOT_SLACK_TOKEN | The bot's Slack API token   |
| YOUR_SLACK_TOKEN  | Your Slack API token        |


## Architecture

### Hardware

* Raspberry Pi Model B+
* Output
    + Old Nokia LCD screen
    + Toy dog (audio)


## Functions

### My scripts

**Annoyance.coffee**

    hubot The cake is a lie

Annoyance is a state where the bot will stop responding to certain things or behave differently. It keeps count of the times you repeat certain old memes and tells you when it gets annoyed.

Query the state of annoyance:

    hubot annoyed?

Ask for forgiveness:

    hubot I'm sorry

If annoyed, forgives you. If not, removes any warnings.

**Listfiles.coffee**

    hubot List files

Makes an API request using the files.list method and lists all the files that have been uploaded to slack in a neat form, with titles, filenames and character and line count. Also tells you the file count and total code line count.

**mynameis.coffee**

    hubot My name is [name]


### Other scripts

- coinflip.coffee
- xkcd.coffee
- dayssince.coffee


## TODO

[ ] Basic responses
[ ] Cursing
[ ] Points system
[ ] Automatic audio output
