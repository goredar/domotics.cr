# Arduino board is general arduino driver
class Domotics::Arduino::Board < Domotics::Driver
  @@progname = "#{"arduino".colorize.white}"

  def initialize(@name = "arduino", options = {} of String => OptionType)
    super
    @path = (options || Hash(String, OptionType).new).fetch("path", "/dev/ttyUSB0").as(String)
    @gpio_count = (options || Hash(String, OptionType).new).fetch("gpio_count", 22).as(Int32)
    @pwm_pins = (options || Hash(String, OptionType).new).fetch("pwm_pins", [] of Int32).as(Array(Int32))
    # Serial port connection
    begin
      sp = File.open(@path, "w+")
      sp.blocking = false
      sp.sync = true
    rescue ex
      fail(:board_serial_fail)
    end
    @sp = sp.as(File)
    # Channels
    @listener = Channel(Reply).new
    @commander = Channel({Command, Pin, State | Mode}).new
    # Spawn listener and commander
    self.up
  end

  private def up
    # Event Listener (command replies or watch alarms)
    spawn {
      LOG.info(@progname) { "#{"(spawn)".colorize.white} Listening for events/replies" }
      loop {
        event = @sp.gets
        if event
          event = event.split(" ")
          case event.size
          when 1
            # It's a reply from executed command
            reply = Reply.from_value event[0].to_i
            LOG.debug(@progname) { "Received reply from board: #{reply.colorize(reply.success? ? :green : :red)}" }
            @listener.send reply
          when 3
            # It's a watch alarm in format (Reply::Watch, Pin, State)
            next if event[0].to_i != Reply::Watch.value
            @units[event[1].to_i].on_state_change(State.from_value event[2].to_i)
            # TODO: send new state to unit
          else
            LOG.warn(@progname) { "Invalid event/reply from board" }
          end
        else
          # It seems like end of stream, i.e. board is disconnected
          ex = IO::Error.new("End of stream")
          fail(:board_disconnected)
        end
      }
    }
    # Commander (loking using channel)
    spawn {
      LOG.info(@progname) { "#{"(spawn)".colorize.white} Listening for commands" }
      loop {
        begin
          @sp.puts(
            @commander
              .receive
              .map { |x| x.is_a?(Enum) ? x.value : x }
              .join(" ")
          )
        rescue ex
          fail(:board_disconnected)
        end
      }
    }
  end

  def down
  end

  # Sends command to arduino board, gets and returns reply
  def command(command = Command::SetPinMode, pin = 0, state = State::Low)
    LOG.debug(@progname) { "Sending board command: #{command.to_s.colorize.magenta}(#{pin}, #{state})" }
    @commander.send({command, pin, state})
    @listener.receive
  end

  # Writes HIGH value to a digital pin
  def high(pin = 0)
    command(Command::DigitalWrite, pin.as(Int32), State::High)
  end

  # Writes LOW value to a digital pin
  def low(pin = 0)
    command(Command::DigitalWrite, pin, State::Low)
  end

  # :nodoc:
  def to_s
    @progname
  end
end
