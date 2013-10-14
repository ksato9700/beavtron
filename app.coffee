#
# Copyright 2013 Kenichi Sato
#
express = require "express"
routes = require "./routes"
dropbox = require "./routes/dropbox"
path = require "path"

app = express()

app.configure ->
  app.set "port", process.env.PORT or 5000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger "dev"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser '1F058A72-B655-4321-9B34-9BF6E1544816'
  app.use express.session()

  app.use (req, res, next) ->
    res.locals.session = req.session
    next()

  app.use app.router
  app.use express.static path.join __dirname, "public"

app.configure "development", ->
  app.use express.errorHandler()
  app.locals.pretty = true

app.get "/", routes.index
app.get "/dropbox/signin", dropbox.signin
#app.get "/signin", routes.signin
#app.get "/signout", routes.signout
#app.get "/authorized", routes.authorized

port = app.get "port"
app.listen port, ->
  console.log "Express server listening on port #{port}"

