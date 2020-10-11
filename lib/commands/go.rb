# Command: Go to a new location
class Go < Command
  include MapHelper

  verb :go, :north, :east, :south, :west, :n, :e, :s, :w

  help_text %{Go to a new location by following an available exit.\nEg:\n  "go north"\n  "go e" (means "go east")\n  "s" (means "go south")}

  def run(world, action)
    # Some versions of this command omit the "go" word at the front. (Eg, "w")
    if action.first =~ /^go?/i
      action.shift
    end

    # Which direction?
    dir = action.first
    if dir.nil?
      return world, [SideEffect::Message.new('Go where?')]
    end

    # Where are we now?
    loc = current_location(world)

    # Find the exit
    ex = loc.exits.find do |e| e[:dir] == dir end
    if not ex
      # allow partial dir name matching
      ex = loc.exits.find do |e| e[:dir].start_with? dir end
    end
    if ex
      # Move to new location
      world.state.location_id = ex[:location_id]
      # Time passes...
      world.state.time += 9.minutes
      # Look at the new surroundings
      return Look.new.run(world, nil)
    else
      # No exit
      return world, [SideEffect::Message.new("Cannot go '#{dir}' from here.")]
    end
  end
end
