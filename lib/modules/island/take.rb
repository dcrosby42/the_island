class Take < Command
  include MapHelper
  include ItemHelper

  verb :take, :get

  def run(world, action)
    subject = action[1]

    local_items = current_location(world).items

    if !subject
      if local_items.empty?
        return world, [SideEffect::Message.new("Take what?")]
      end
      subject = "1"
    end

    item = take_item(local_items, subject)
    if item
      world.player.inventory.items.push(item)
      msg = "OK. #{item.look} added to inventory."
    end

    msg ||= "Couldn't get #{subject}"

    return world, [SideEffect::Message.new(msg)]
  end
end
