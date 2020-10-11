$PROJECT_ROOT = File.expand_path(File.join(__dir__, '..'))
$LOAD_PATH << File.join($PROJECT_ROOT, 'lib')

require 'bundler'
Bundler.setup

require 'time'
require 'yaml'
require 'attr_extras'
require 'pry'
require 'active_support/core_ext/numeric/time'
require 'require_pattern'
