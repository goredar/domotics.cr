require "logger"

module Domotics::Logger
  alias Formatter = ::Logger::Severity, Time, String, String, IO ->

  SEVERITY_STRINGS = [
    "DEBUG".colorize.light_gray,
    "INFO ".colorize.blue,
    "WARN ".colorize.yellow,
    "ERROR".colorize.red,
    "FATAL".colorize.red.bright,
    "UNKNO".colorize.yellow,
  ]

  def self.new
    log = ::Logger.new(STDOUT)
    log.level = OPTS[:debug]? ? ::Logger::DEBUG : ::Logger::INFO
    log.formatter = Formatter.new do |severity, datetime, progname, message, io|
      io << "#{datetime.to_s("%FT%T")} " << SEVERITY_STRINGS[severity.value]
      io << " [#{progname}] " << message
    end
    log
  end
end
