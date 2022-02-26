require "./arduino/board"
require "./arduino/*"

module Domotics::Arduino
  # Define arduino board commands
  enum Command
    PinMode
    DigitalRead
    DigitalWrite
    AnalogRead
    AnalogWrite
    WatchRead
    WatchWrite
    EchoReply
    ResetDefaults
    SetPWMFrequency
  end
  # Define arduino boards replies
  enum Reply
    Success
    Fail
    Watch
  end
  # Define arduino board pin modes
  enum Mode
    Input
    Output
    InputPullup
  end
end

alias Pin = Int32
