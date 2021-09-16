class TimeCmd < Command
  verb :time
  help_text %{Tells the current time}

  include TimeHelper

  def run(world, action)
    return world, [SideEffect::Message.new(look_time world.state.time)]
  end
end
