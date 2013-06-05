request = require 'request'

baseAPI = "https://api.heroku.com/apps"

routes = 
  scale   : {url: "/formation", method: 'PATCH'}
  stop    : {url: "/formation", method: 'PATCH'}
  list    : {url: "/formation", method: 'GET'}

class Komodo

  constructor: (@key, @app) ->

  auth: (key, app) ->
    @key = key
    @app = app

  scale: (opts, cb) ->
    herokuOpts = resource: opts.type, data: {quantity: opts.quantity, size: opts.size or 1}
    @heroku routes.scale, herokuOpts, (err, data) ->
      cb err, data if cb

  stop: (opts, cb) ->
    herokuOpts = resource: opts.type, data: {quantity: 0, size: opts.size or 1}
    @heroku routes.scale, herokuOpts, (err, data) ->
      cb err, data if cb

  list: (cb) ->
    @heroku routes.list, {}, (err, data) ->
      cb err, data

  heroku: (route, opts, cb) =>
    reqOpts = 
      method: route.method
      json: opts.data
      auth: {username: "#{@key}", password: "#{@key}"}
      headers:
        accept : "application/vnd.heroku+json; version=3"

    reqOpts.url = "#{baseAPI}/#{@app}#{route.url}"
    reqOpts.url += "/#{opts.resource}" if opts.resource?

    request reqOpts, (err, req, body) ->
      cb err, body 

module.exports = (key, app) ->
  new Komodo(key, app)
