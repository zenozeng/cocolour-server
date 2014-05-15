fs = require 'fs'

log4js = require 'log4js'
log4js.configure
  appenders: [
    { type: 'console' },
    { type: 'file', filename: 'logs/first.log', category: 'first' }
  ]
logger = log4js.getLogger 'first'
logger.setLevel 'INFO'

logger.debug 'start'

config = fs.readFileSync 'config.json'
config = JSON.parse config

app = require('express')()

app.options "*", (req, res) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Credentials', true
  # try: 'POST, GET, PUT, DELETE, OPTIONS'
  res.header 'Access-Control-Allow-Methods', 'GET, OPTIONS'
  # try: 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept'
  res.header 'Access-Control-Allow-Headers', 'Content-Type'

app.get '/', (req, res) ->

  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Credentials', true
  res.header 'Access-Control-Allow-Methods', 'POST, GET, PUT, DELETE, OPTIONS'
  res.header 'Access-Control-Allow-Headers', 'Content-Type'

  {user, password} = req.query
  if user? and config.users[user]?
    if config.users[user].password is password
      delete req.query.user
      delete req.query.password
      logger.info JSON.stringify(req.query)
      res.send "Hello World"
      return
  res.send "Are you kidding?"
app.listen 26080
