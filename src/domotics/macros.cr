macro fail(reason)
  LOG.error(@progname) { "#{ERRORS[{{ reason }}][0]} (#{ex.to_s.colorize.red})" }
  exit ERRORS[{{ reason }}][1]
end

macro fail(reason, progname)
  LOG.error({{ progname }}) { "#{ERRORS[{{ reason }}][0]} (#{ex.to_s.colorize.red})" }
  exit ERRORS[{{ reason }}][1]
end

macro registry(name)
  REGISTRY = {} of String => self.class
  ENTITIES = {} of String => self
  @@progname = "#{{{ name.id.stringify }}.colorize.white}"

  getter name
  getter progname

  def self.[](name)
    ENTITIES[name]
  rescue ex : KeyError
    fail(:{{ name.id }}_not_found, @@progname)
  end

  def self.registry(name)
    REGISTRY[name]
  rescue ex : KeyError
    fail(:{{ name.id }}_class_not_found, @@progname)
  end
end

macro not_implemented(name)
  def {{ name }}(*args)
    LOG.warn(@progname) { "Method #{"{{ name.id }}".colorize.red} is not implemented" }
    return nil
  end
end

macro method_missing(call)
  Domotics::Room[{{ call.name.stringify }}]
end
