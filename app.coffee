
winston = require 'winston'
nconf = require 'nconf'

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

winston.error 'test error'
winston.warn 'test warn'
winston.info 'Test info'
winston.verbose 'test verbose'
winston.debug 'test debug'
winston.silly 'test silly'

