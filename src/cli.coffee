bHtml = require 'b-html'
commander = require 'commander-b'
fs = require 'fs-extra'
path = require 'path'

class CLI
  constructor: ->

  run: ->
    command = commander('b-html <file>')
    command.version @_getVersion()
    command.action (file) =>
      @_compile file
    command.execute()
    .catch (e) ->
      console.error e

  _compile: (srcFile, { dir } = {}) ->
    ext = path.extname srcFile
    return if ext isnt '.bhtml'
    data = fs.readFileSync srcFile, encoding: 'utf-8'
    html = bHtml data
    dir ?= path.dirname srcFile
    base = path.basename srcFile, ext
    dstFile = path.join dir, base + '.html'
    fs.outputFileSync dstFile, html, encoding: 'utf-8'

  _getVersion: ->
    packageJsonFile = path.join __dirname, '/../package.json'
    packageJsonData = fs.readFileSync packageJsonFile, encoding: 'utf-8'
    packageJson = JSON.parse packageJsonData
    packageJson.version

module.exports.CLI = CLI
