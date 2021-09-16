# Command: Go to a new location
class Go < Command
  include MapHelper
  include TimeHelper

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
      world, fx = passage_of_time world, add: 9.minutes
      # Look at the new surroundings
      world, fx2 = Look.new.run(world, ['go-look'])
      return world, fx + fx2
    else
      # No exitk
      return world, [SideEffect::Message.new("Cannot go '#{dir}' from here.")]
    end
  end
end
