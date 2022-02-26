require "colorize"

require "./domotics/macros"
require "./domotics/*"

Domotics::LOG = Domotics::Logger.new
Domotics::CONF = Domotics::Config.load
Domotics::Driver.up
Domotics::Room.up

puts living.long_side_light.up
