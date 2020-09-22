class Take < Command
  include MapHelper

  verb :take, :get

  def run(world, action)
    subject = action[1]
    if !subject
      return world, [SideEffect::Message.new("Take what?")]
    end

    # Figure out which item we're talking about...
    local_items = current_location(world).items
    idx = nil
    case subject
    when /^\d+$/
      # Find by numeric index (1-based)
      idx = subject.to_i - 1
    else
      # match on name
      idx = (local_items.find_index { |li, i| li.type.to_s == subject })
      # fallback: partial string match (starts-with)
      idx ||= (local_items.find_index { |li| li.type.to_s.start_with?(subject) })
    end

    if idx
      # Remove the item from locality
      if item = local_items.delete_at(idx)
        # Put it in our inv
        world.player.inventory.items.push(item)
        msg = "OK. #{item.look} added to inventory."
      end
    end

    msg ||= "Couldn't get #{subject}"

    return world, [SideEffect::Message.new(msg)]
  end
end
