class Look < Handler
  verb :look

  def handle(world, action = nil)
    loc = world.map[world.state[:location_id]]
    text = "You are at #{loc.name}.\n#{loc.text}"

    if loc.items
      list = Item.format_list(loc.items)
      text += "\n\nHere you can see:\n#{list}"
    end

    return world, [SideEffect::Message.new(text)]
  end
end
