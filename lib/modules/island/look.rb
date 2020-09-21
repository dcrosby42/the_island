class Look < Handler
  verb :look

  def handle(world, action = nil)
    loc = world.map[world.state[:location_id]]
    text = "You are at #{loc.name}.\n#{loc.text}"
    return world, [SideEffect::Message.new(text)]
  end
end
