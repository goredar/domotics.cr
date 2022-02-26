class Domotics::Unit::Relay < Domotics::Unit
  Domotics::Unit::REGISTRY["relay"] = self

  def up
    @driver.high @driver_id
  end

  def down
    @driver.low @driver_id
  end

  def to_hls(*args)
    :unknown
  end

  not_implemented on_event
end
