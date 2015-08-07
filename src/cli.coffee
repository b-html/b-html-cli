bHtml = require 'b-html'
commander = require 'commander-b'
fs = require 'fs'
path = require 'path'

class CLI
  constructor: ->

  run: ->
    command = commander('b-html <file>')
    command.version @_getVersion()
    command.action (file) ->
      data = fs.readFileSync file, encoding: 'utf-8'
      html = bHtml data
      console.log html
    command.execute()
    .catch (e) ->
      console.error e

  _getVersion: ->
    packageJsonFile = path.join __dirname, '/../package.json'
    packageJsonData = fs.readFileSync packageJsonFile, encoding: 'utf-8'
    packageJson = JSON.parse packageJsonData
    packageJson.version

module.exports.CLI = CLI
