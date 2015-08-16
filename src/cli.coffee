bHtml = require 'b-html'
commander = require 'commander-b'
fs = require 'fs-extra'
html2bhtml = require 'html2bhtml'
path = require 'path'

class CLI
  constructor: ->

  run: ->
    command = commander 'b-html <file>'
    command.version @_getVersion()
    command
    .option '-m, --mode <mode>', 'the compile mode. "b2h" or "h2b" (default b2h).'
    .option '-o, --output <dir>', 'the output directory for (de)compiled HTML'
    .option '-s, --sgml-line-break', 'ignore line break following a start tag and before an end tag. (for h2b mode)'
    .action (file, { mode, output, sgmlLineBreak } = {}) =>
      mode ?= 'b2h'
      sgmlLineBreak ?= false
      throw new Error('invalid mode') if mode isnt 'b2h' and mode isnt 'h2b'
      try
        if mode is 'b2h'
          @_compileRecursive file, dir: output
        else # mode is 'h2b'
          @_decompileRecursive file,
            dir: output
            removeWhiteSpace: sgmlLineBreak
      catch e
        console.error e.message
        throw e
    command.execute()

  _compile: (srcFile, { dir } = {}) ->
    ext = path.extname srcFile
    return if ext isnt '.bhtml'
    data = fs.readFileSync srcFile, encoding: 'utf-8'
    try
      html = bHtml data
    catch e
      throw new Error [
        path.resolve srcFile
        e.lineNumber
        e.columnNumber
        ' error: ' + e.message
      ].join ':'
    dir ?= path.dirname srcFile
    base = path.basename srcFile, ext
    dstFile = path.join dir, base + '.html'
    fs.outputFileSync dstFile, html, encoding: 'utf-8'

  _compileRecursive: (srcFile, options) ->
    if fs.statSync(srcFile).isDirectory()
      files = fs.readdirSync srcFile
      files.forEach (f) =>
        @_compileRecursive path.join(srcFile, f), options
    else
      @_compile srcFile, options

  _decompile: (srcFile, { dir, removeWhiteSpace } = {}) ->
    ext = path.extname srcFile
    return if ext isnt '.html'
    data = fs.readFileSync srcFile, encoding: 'utf-8'
    bhtml = html2bhtml data, { removeWhiteSpace }
    dir ?= path.dirname srcFile
    base = path.basename srcFile, ext
    dstFile = path.join dir, base + '.bhtml'
    fs.outputFileSync dstFile, bhtml, encoding: 'utf-8'

  _decompileRecursive: (srcFile, options) ->
    if fs.statSync(srcFile).isDirectory()
      files = fs.readdirSync srcFile
      files.forEach (f) =>
        @_decompileRecursive path.join(srcFile, f), options
    else
      @_decompile srcFile, options

  _getVersion: ->
    packageJsonFile = path.join __dirname, '/../package.json'
    packageJsonData = fs.readFileSync packageJsonFile, encoding: 'utf-8'
    packageJson = JSON.parse packageJsonData
    packageJson.version

module.exports.CLI = CLI
