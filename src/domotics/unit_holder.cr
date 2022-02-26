module Domotics::UnitHolder
  def register_unit(id, unit)
    @units[id] = unit
  end

  def unit(id)
    @units[id]
  rescue ex : KeyError
    fail(:unit_not_found)
  end

  def [](id)
    unit id
  end

  macro method_missing(call)
    self.unit {{ call.name.stringify }}
  end
end
