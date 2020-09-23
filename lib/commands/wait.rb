class Wait < Command
  verb :wait

  include TimeHelper

  Default = 2.hours

  def run(world, action = nil)
    d = Default
    incr = :hours

    _, num, label = (action || [])

    if num and num =~ /^\d+$/
      incr = case label
        when /^h/
          incr = :hours
        when /^s/
          incr = :seconds
        else
          incr = :minutes
        end
      d = num.to_i.send(incr)
    end
    world.state[:time] += d

    return world, [
             SideEffect::Message.new("You sit, and wait patiently for a couple #{incr.to_s}.\n#{look_time world.state[:time]}"),
           ]
  end
end
