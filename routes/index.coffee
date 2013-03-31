#
# Copyright 2013 Kenichi Sato
#
TITLE = "Beavtron"
account = null

exports.index = (req, res)->
  console.log account
  res.render "index",
    title: TITLE
    account: account

exports.signin = (req, res)->
  account =
    name: 'Ken Sato'
  res.redirect "/"

exports.signout = (req, res)->
  account = null
  res.redirect "/"
