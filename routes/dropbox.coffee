#
# Copyright 2013 Kenichi Sato
#

db_client = null
driver = null

exports.signin = (req, res)->
  dropbox = require 'dropbox'
  db_client = new dropbox.Client
    key: process.env.DROPBOX_API_KEY
    secret: process.env.DROPBOX_API_SECRET

  if not driver
    driver = db_client.authDriver new dropbox.AuthDriver.NodeServer 8192

  db_client.authenticate (err, client)->
    if err
      res.send 403, {error: err}
    else
      console.log 'authenticated!!'
      client.getAccountInfo (err, account_info)->
        if err
          res.send 400, {error: err}
        else
          req.session.account = account_info
          res.redirect '/'


