assert = require 'power-assert'
{CLI} = require './cli'

describe 'CLI', ->
  describe '#run', ->
    cli = new CLI()
    assert typeof cli.run is 'function'
