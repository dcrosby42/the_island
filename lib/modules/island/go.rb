class Go < Command
  verb :go

  def run(world, action)
    dir = action[1]
    if dir.nil?
      return world, [SideEffect::Message.new("Go where?")]
    end

    loc = world.map[world.state[:location_id]]

    ex = loc.exits.find do |e| e[:dir] == dir end
    if not ex
      # allow partial dir name matching
      ex = loc.exits.find do |e| e[:dir].start_with? dir end
    end
    if ex
      world.state[:location_id] = ex[:location_id]
      return Look.new.run(world, nil)
    else
      return world, [SideEffect::Message.new("Cannot go '#{dir}' from here.")]
    end
  end
end
