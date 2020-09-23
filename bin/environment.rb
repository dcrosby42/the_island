$PROJECT_ROOT = File.expand_path(File.join(__dir__, ".."))
$LOAD_PATH << File.join($PROJECT_ROOT, "lib")

require "time"
require "attr_extras"
require "pry"
require "active_support/core_ext/numeric/time"
