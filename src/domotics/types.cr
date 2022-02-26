module Domotics
  alias UnitEvent = Hash(Symbol, Int32 | String | Array(Int32) | Array(String) | State)
  alias RoomEvent = Hash(Symbol, Symbol)
  enum State
    Low
    High
    None
  end
end
