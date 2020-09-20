require "readline"
require "game_view"

class ConsoleUI
  def line(str = "")
    puts str
  end

  def prompt(pr = nil)
    pr ||= Prompt.new(term: ">")
    Readline.readline("#{pr.label}#{pr.term} ", true)
  end
end
