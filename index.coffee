fs = require 'fs'

config = fs.readFileSync 'config.json'
config = JSON.parse config

app = require('express')()

app.get '/', (req, res) ->
  {user, password} = req.query
  if user? and config.users[user]?
    if config.users[user].password is password
      res.send "Hello World"
  res.send "Are you kidding?"
app.listen 26080
