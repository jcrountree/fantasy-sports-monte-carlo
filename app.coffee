express = require 'express'
winston = require 'winston'
nconf = require 'nconf'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
path = require 'path'

###
  Initialize nfconf using hierarchy
    1. Explicit overrides
    2. Arguments
    3. Environment variables
    4. Defaults
###
nconf.overrides
  'always': 'be this value'
nconf.argv()
nconf.env()
nconf.defaults(require './config/default')

###
  Initialize logging
###
winston.remove winston.transports.Console
winston.add winston.transports.Console,
  level : nconf.get 'LOG_LEVEL'
  colorize : true
  timestamp : true
  prettyPrint : true
  humanReadableUnhandledException : true
  stderrLevels : []

winston.emitErrs = true

###
  Configure winston to be logger for morgan, which will be the http logger
  for the express app.
    1. Set up the logger options we want
    2. Add a logger.stream.write method, because that's the function called by
        morgan.
###
logger = new winston.Logger
  transports: [
    new winston.transports.Console
      level: 'debug'
      handleExceptions: true
      json: false
      colorize: true
  ],
  exitOnError: false

logger.stream =
  write: (message)->
    logger.info message

###
  Create express app. Set the standard libraries.
###
app = express()
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'pug')
app.use(require('morgan')('combined', { stream : logger.stream }))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded( extended: false ))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))
