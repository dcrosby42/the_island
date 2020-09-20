class ExitAction
  def type
    :exit
  end
end

class Driver
  def initialize(game_module:, ui:)
    @module = game_module
    @ui = ui
  end

  def run
    setup
    display
    loop do
      action = interpret prompt()
      if action
        if action.type == :exit
          if ok_to_exit?
            exit_message
            break
          end
        end
        apply action
        display
      end
    end
  end

  private

  def prompt(pr = @view.prompt)
    @ui.prompt pr
  end

  def apply(action)
    if action
      @state = @module.update(@state, action)
    end
    @state
  end

  def interpret(input)
    # input line is nil when EOF (eg, from Ctrl-D) or user says to quit.
    if input.nil? or input =~ /^quit/i
      return ExitAction.new
    end
  end

  def display
    @view = @module.render(@state)
    @ui.line @view.text
  end

  def setup
    @state = @module.create
  end

  def ok_to_exit?
    true
  end

  def exit_message
    @ui.line
    @ui.line "Leaving the game..."
  end
end
