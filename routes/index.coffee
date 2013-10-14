#
# Copyright 2013 Kenichi Sato
#

TITLE = "Beavtron"
account = null

sc_client = null
sc_redirect_uri = process.env.SC_REDIRECT_URI

exports.index = (req, res)->
  console.log req.session
  res.render "index",
    title: TITLE

exports.signin = (req, res)->
  otogumo = require 'otogumo/lib/otogumo'
  sc_client = new otogumo.Client process.env.SC_CLIENT_ID, process.env.SC_SOUNDCLOUD_CSEC
  res.redirect client.authorize_url sc_redirect_uri

  #account =
  #  name: 'Ken Sato'
  #res.redirect "/"

exports.signout = (req, res)->
  account = null
  res.redirect "/"

exports.authorized = (req, res)->
  code = req.query.code
  signed_up = req.query.signed_up
  client.exchange_token code, sc_redirect_uri, (err)->
    if err
      res.send 500, {error: err}
    else
      client.get_me (err, body)->
        if err
          res.send 500, {error: err}
        else
          account = body
          res.redirect '/'
