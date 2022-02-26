require "option_parser"

Domotics::OPTS = {
  :port   => "7007",
  :config => "./etc/domotics.yaml",
}

OptionParser.parse! do |parser|
  parser.banner = "Usage: domotics [options]"
  parser.on("-c PATH", "--config=PATH", "Config file path (defaults to ./domotics.yaml)") { |path|
    Domotics::OPTS[:config] = path
  }
  parser.on("-p PORT", "--port=PORT", "HTTP API port (defaults to 7007") { |port|
    Domotics::OPTS[:port] = port
  }
  parser.on("-d", "--debug", "Print debug messages") { Domotics::OPTS[:debug] = "true" }
  parser.on("-h", "--help", "Show this message") { puts parser; exit 0 }
  parser.missing_option do |opt_name|
    puts "Required parameter for #{opt_name} option is missing."
    exit 1
  end
  parser.invalid_option do |opt_name|
    puts "Option #{opt_name} is not supported yet."
    exit 1
  end
end
