assert = require 'assert'
komodo = require('../lib/komodo')()
config = require('../heroku_config')

komodo.auth config.key, config.app

describe 'Processes', ->

  it 'should scales processes to two', (done) ->
    komodo.scale {type: 'web', qty: 2}, (err, data) ->
      assert.ifError err
      assert.equal data, '2'
      done()

  it 'should scale processes to one', (done) ->
    komodo.scale {type: 'web', qty: 1}, (err, data) ->
      assert.ifError err
      assert.equal data, '1'
      done()

  it 'should list all processes', (done) ->
    komodo.list (err, data) ->
      assert.ifError err
      assert data
      done()

  it 'should stop a process', (done) ->
    komodo.stop {type: 'web'}, (err, data) ->
      assert.ifError err
      assert.equal data, 'ok'
      done()

  it 'should resrtart a process', (done) ->
    komodo.restart {type: 'web'}, (err, data) ->
      assert.ifError err
      assert.equal data, 'ok'
      done()

  after ->
    komodo.scale {type: 'web', qty: 1}
