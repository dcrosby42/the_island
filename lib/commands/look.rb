# Look around
class Look < Command
  verb :look, :l
  help_text %{Describes your surroundings, including time and available items.}

  include TimeHelper

  def run(world, action = nil)
    text = ''
    time = ''

    # Time
    if world.state.time
      time = " It's #{time_str world.state.time}"
    end

    # Location
    loc = world.map[world.state.location_id]
    text += "You are at #{loc.name}.#{time}\n#{loc.text}\n"

    # Items
    if loc.items and !loc.items.empty?
      list = Item.format_list(loc.items)
      text += "Here you can see:\n#{list}\n"
    end

    return world, [SideEffect::Message.new(text)]
  end
end
