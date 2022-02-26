require "./room"
require "./driver"

abstract class Domotics::Unit
  registry unit

  @name : String
  @room : Domotics::Room
  @driver : Domotics::Driver

  def initialize(@name, @room, @driver, @driver_id : DriverID, options = {} of String => OptionType)
    @fqdn = "#{@room.name}/#{@name}"
    @progname = "#{@room.progname}/#{@name.colorize.green}"
    @driver.register_unit(@driver_id, self)
    @room.register_unit(@name, self)
    ENTITIES[@fqdn] = self
    LOG.debug(@@progname) { "Registering unit: #{@progname} (driver: #{@driver.progname})" }
  end

  def on_state_change(state)
    @room.send({@name, to_hls state})
  end

  # abstract def up
  # abstract def down
  # abstract def to_hls
end

require "./unit/*"
