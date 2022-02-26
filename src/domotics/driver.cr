require "./unit_holder"

alias DriverID = Int32 | String

# Base driver class (interface)
abstract class Domotics::Driver
  registry :driver
  include UnitHolder

  def self.up
    LOG.debug(@@progname) { "Initialising drivers..." }
    CONF.drivers.each do |name, driver|
      registry(driver.kind).new(name, driver.options)
    end
  end

  def initialize(@name = "arduino", options = {} of String => OptionType)
    @units = {} of DriverID => Domotics::Unit
    @progname = "#{@@progname}:#{@name.colorize.light_green}"
    # Register board as driver instance
    ENTITIES[@name] = self
    LOG.debug(@@progname) { "Registering driver: #{@progname}" }
  end

  abstract def high
  abstract def low
end

require "./driver/*"
