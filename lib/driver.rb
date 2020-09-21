require "side_effects"

class Driver
  def initialize(game_module:, ui:)
    @module = game_module
    @ui = ui
  end

  def run
    @state, side_effects = @module.create
    handle side_effects

    looping = true
    while looping
      action = prompt()
      case action.first
      when nil
        # nothing
      when "quit"
        looping = false
      else
        @state, side_effects = @module.update(@state, action)
        handle side_effects
      end
    end
    @ui.line "Exiting!"
  end

  private

  def prompt
    pr = @module.get_prompt(@state)
    input_str = @ui.prompt(pr) || "quit"
    (input_str or "").split(/\s+/).map do |s| s.strip end
  end

  def handle(side_effects)
    return unless side_effects
    side_effects.each do |e|
      case e
      when SideEffect::Message
        @ui.line e.text
      end
    end
  end
end
