# Look around
class Look < Command
  verb :look

  include TimeHelper

  def run(world, action = nil)
    text = ''

    # Location
    loc = world.map[world.state[:location_id]]
    text += "You are at #{loc.name}.\n#{loc.text}\n"

    # Items
    if loc.items and !loc.items.empty?
      list = Item.format_list(loc.items)
      text += "Here you can see:\n#{list}\n"
    end

    # Time
    if world.state[:time]
      text += "It's #{time_str world.state[:time]}"
    end

    return world, [SideEffect::Message.new(text)]
  end
end
