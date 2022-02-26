require "yaml"

alias OptionType = String | Int32 | Array(Int32) | Array(String)

struct Domotics::Config
  YAML.mapping(
    drivers: Hash(String, Driver),
    rooms: Hash(String, Room)
  )

  def self.load
    self.from_yaml File.read File.expand_path OPTS[:config]
  rescue ex
    fail(:config_fail, "#{"config".colorize.white}")
  end

  struct Driver
    YAML.mapping(
      kind: String,
      options: Hash(String, OptionType)?,
    )
  end

  struct Room
    YAML.mapping(
      kind: String,
      driver: String?,
      units: Hash(String, Unit),
      options: Hash(String, OptionType)?,
    )
  end

  struct Unit
    YAML.mapping(
      kind: String,
      driver: String?,
      driver_id: DriverID,
      options: Hash(String, OptionType)?,
    )
  end
end
