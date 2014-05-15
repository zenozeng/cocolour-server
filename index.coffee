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

app.get '/', (req, res) ->
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
