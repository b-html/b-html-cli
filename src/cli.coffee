fs = require 'fs'
bHtml = require 'b-html'
commander = require 'commander-b'

class CLI
  constructor: ->

  run: ->
    command = commander('b-html <file>')
    command.action (file) ->
      data = fs.readFileSync file, encoding: 'utf-8'
      html = bHtml data
      console.log html
    command.execute()
    .catch (e) ->
      console.error e

module.exports.CLI = CLI
