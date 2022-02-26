class Domotics::Room::Living < Domotics::Room
  Domotics::Room::REGISTRY["living"] = self

  def handler(event = Event.new)
    p event
  end
end
