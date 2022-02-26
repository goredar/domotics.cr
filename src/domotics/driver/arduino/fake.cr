# Fake arduino board for test purpose
class Domotics::Arduino::Fake < Domotics::Arduino::Board
  Domotics::Driver::REGISTRY["arduino/fake"] = self

  def initialize(@name = "fake", options = {} of String => OptionType)
    @units = {} of DriverID => Domotics::Unit
    @progname = "#{"arduino".colorize.white}:#{@name.colorize.light_green}"
    @path = "/tmp/ttyFake"
    @gpio_count = 99
    @pwm_pins = [] of Int32
    @sp = File.new(@path, "w")
    @listener = Channel(Reply).new
    @commander = Channel({Command, Pin, State | Mode}).new
    ENTITIES[@name] = self
  end

  # Sends command to arduino board, gets and returns reply
  def command(command = Command::SetPinMode, pin = 0, state = State::Low)
    LOG.debug(@progname) { "Sending board command: #{command.to_s.colorize.magenta}(#{pin}, #{state})" }
    Reply::Success
  end
end
