class Domotics::Unit::Sensor < Domotics::Unit
  Domotics::Unit::REGISTRY["sensor"] = self

  not_implemented up
  not_implemented down

  def to_hls(ll_state)
    case ll_state
    when State::Low  then :closed
    when State::High then :open
    else                  :unknown
    end
  end
end
