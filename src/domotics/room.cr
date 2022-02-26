require "./unit_holder"

abstract class Domotics::Room
  registry :room
  include UnitHolder

  def self.up
    LOG.debug(@@progname) { "Initialising rooms..." }
    CONF.rooms.each do |name, room|
      room_instance = registry(room.kind).new(name)
      room.units.each do |name, unit|
        driver = Driver[unit.driver || room.driver]
        Unit
          .registry(unit.kind)
          .new(name, room_instance, driver, unit.driver_id, unit.options)
      end
    end
  end

  def initialize(@name = "room")
    @units = {} of String => Domotics::Unit
    @events = Channel({String, Symbol}).new
    @progname = "#{@@progname}:#{@name.colorize.yellow}"
    ENTITIES[@name] = self
    up
    LOG.debug(@@progname) { "Registering room: #{@progname}" }
  end

  def up
    spawn { loop { handler @events.receive } }
  end

  def send(event)
    @events.send event
  end

  abstract def handler
end

require "./room/*"
