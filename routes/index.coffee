#
# Copyright 2013 Kenichi Sato
#
otogumo = require 'otogumo/lib/otogumo'

TITLE = "Beavtron"
account = null

client_id = process.env.SC_CLIENT_ID
client_secret = process.env.SC_CLIENT_SECRET
redirect_uri = process.env.SC_REDIRECT_URI

client = new otogumo.Client client_id, client_secret

exports.index = (req, res)->
  console.log account
  res.render "index",
    title: TITLE
    account: account

exports.signin = (req, res)->
  res.redirect client.authorize_url redirect_uri

  #account =
  #  name: 'Ken Sato'
  #res.redirect "/"

exports.signout = (req, res)->
  account = null
  res.redirect "/"

exports.authorized = (req, res)->
  code = req.query.code
  signed_up = req.query.signed_up
  client.exchange_token code, redirect_uri, (err)->
    if err
      res.send 500, {error: err}
    else
      client.get_me (err, body)->
        if err
          res.send 500, {error: err}
        else
          account = body
          res.redirect '/'
