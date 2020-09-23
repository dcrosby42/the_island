class Go < Command
  include MapHelper
  verb :go, :north, :east, :south, :west, :n, :e, :s, :w

  def run(world, action)
    if action.first =~ /^go?/i
      action.shift
    end

    dir = action.first
    if dir.nil?
      return world, [SideEffect::Message.new('Go where?')]
    end

    loc = current_location(world)

    ex = loc.exits.find do |e| e[:dir] == dir end
    if not ex
      # allow partial dir name matching
      ex = loc.exits.find do |e| e[:dir].start_with? dir end
    end
    if ex
      world.state[:location_id] = ex[:location_id]
      world.state[:time] += 9.minutes

      return Look.new.run(world, nil)
    else
      return world, [SideEffect::Message.new("Cannot go '#{dir}' from here.")]
    end
  end
end
