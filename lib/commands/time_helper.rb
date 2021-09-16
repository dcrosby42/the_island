module TimeHelper
  def time_str(t)
    t.strftime('%l:%M %p').strip
  end

  def look_time(t)
    "It's #{time_str t}"
  end

  # TODO: this method ought to be something more clearly demarcated as a (world,fx) Action or something
  def passage_of_time(world, opts = {})
    if opts[:add]
      # before_time = world.state.time
      world.state.time += opts[:add]
      # after_time = world.state.time
    end
    return world, []
  end
end
