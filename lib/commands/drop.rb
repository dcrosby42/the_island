class Drop < Command
  verb :drop, :put

  include MapHelper
  include ItemHelper

  def run(world, action)
    subject = action[1]
    if !subject
      return world, [SideEffect::Message.new("Drop what?")]
    end

    # Figure out which inventory item we're talking about...
    if item = take_item(world.player.inventory.items, subject)
      current_location(world).items.push(item)
      msg = "OK. #{item.look} dropped."
    end

    msg ||= "Can't drop #{subject}, not sure it's in your inventory..."

    return world, [SideEffect::Message.new(msg)]
  end
end
