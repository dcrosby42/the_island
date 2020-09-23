class Drop < Command
  verb :drop, :put, :d
  help_text %{Drops an item from your inventory and leaves it at this location.\nEg:\n  "drop driftwood" will let go of your driftwood.\n  "drop 2" drops the second item in your inventory.}

  include MapHelper
  include ItemHelper

  def run(world, action)
    subject = action[1]
    if !subject
      # Show inventory
      msg = "Drop what?\n"
      _, fx = Inventory.new.run(world, [])
      msg += fx.first.text
      return world, [SideEffect::Message.new(msg)]
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
