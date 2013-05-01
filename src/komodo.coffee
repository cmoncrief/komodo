request = require 'request'

baseAPI = "https://api.heroku.com/apps"

routes = 
  scale   : {url: "/ps/scale", method: 'POST'}
  stop    : {url: "/ps/stop", method: 'POST'}
  restart : {url: "/ps/restart", method: 'POST'}
  list    : {url: "/ps", method: 'GET'}

class Komodo

  constructor: (@key, @app) ->

  auth: (key, app) ->
    @key = key
    @app = app

  scale: (opts, cb) ->
    @heroku routes.scale, {type: opts.type, qty: opts.qty}, (err, data) ->
      cb err, data if cb

  stop: (opts, cb) ->
    @heroku routes.stop, {ps: opts.ps, type: opts.type}, (err, data) ->
      cb err, data if cb

  restart: (opts, cb) ->
    @heroku routes.restart, {ps: opts.ps, type: opts.type}, (err, data) ->
      cb err, data if cb

  list: (cb) ->
    @heroku routes.list, {}, (err, data) ->
      cb err, data

  heroku: (route, data, cb) =>
    options = 
      url: "#{baseAPI}/#{@app}#{route.url}"
      method: route.method
      json: data
      auth: {username: "#{@key}", password: "#{@key}"}

    request options, (err, req, body) ->
      cb err, body 

module.exports = (key, app) ->
  new Komodo(key, app)