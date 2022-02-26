class Domotics::Arduino::Nano < Domotics::Arduino::Board
  Domotics::Driver::REGISTRY["arduino/nano"] = self

  def initialize(name = "nano", options = {} of String => OptionType)
    # GPIO pins count: 22
    # PWM pins: 3, 5, 6, 9, 10, and 11
    options = {} of String => OptionType unless options
    options["path"] ||= "/dev/ttyNano"
    options["gpio_count"] = 22
    options["pwm_pins"] = [3, 5, 6, 9, 10, 11]
    super(name, options)
  end
end
