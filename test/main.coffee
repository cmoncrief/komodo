assert = require 'assert'
komodo = require('../lib/komodo')()
config = require('../heroku_config')

komodo.auth config.key, config.app

describe 'Processes', ->

  it 'should scales processes to two', (done) ->
    komodo.scale {type: 'web', quantity: 2}, (err, data) ->
      assert.ifError err
      dyno = i for i in data when i.type is 'web'
      assert dyno
      assert.equal dyno.quantity, 2
      done()

  it 'should scale processes to one', (done) ->
    komodo.scale {type: 'web', quantity: 1}, (err, data) ->
      assert.ifError err
      dyno = i for i in data when i.type is 'web'
      assert dyno
      assert.equal dyno.quantity, 1
      done()

  it 'should list all processes', (done) ->
    komodo.list (err, data) ->
      assert.ifError err
      assert data
      done()

  it 'should stop a process', (done) ->
    komodo.stop {type: 'web'}, (err, data) ->
      assert.ifError err
      dyno = i for i in data when i.type is 'web'
      assert dyno
      assert.equal dyno.quantity, 0
      done()

  it 'should allow optional callbacks', ->
    komodo.scale {type: 'web', quantity: '1'}

  after ->
    komodo.scale {type: 'web', quantity: 1}
