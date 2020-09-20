#!/usr/bin/env ruby
require_relative "environment"
require "driver"
require "modules/island"
require "console_ui"

driver = Driver.new(game_module: Island, ui: ConsoleUI.new)
driver.run
