# Error messages and exit codes
module Domotics
  CLASS_NOT_FOUND = "class/handler not found"
  NOT_FOUND       = "not found (not configured or misspelled)"
  ERRORS          = {
    :config_fail            => {"Failed to load/parse config file", 2},
    :board_serial_fail      => {"Failed to open board serial connection", 3},
    :board_disconnected     => {"Board has been disconnected", 4},
    :driver_class_not_found => {"Driver #{CLASS_NOT_FOUND}", 5},
    :room_class_not_found   => {"Room #{CLASS_NOT_FOUND}", 5},
    :unit_class_not_found   => {"Unit #{CLASS_NOT_FOUND}", 5},
    :driver_not_found       => {"Driver #{NOT_FOUND}", 6},
    :room_not_found         => {"Room #{NOT_FOUND}", 6},
    :unit_not_found         => {"Unit #{NOT_FOUND}", 6},
  }
end
