class Inventory < Handler
  verb :inventory

  def handle(world, action)
    items = world.player.inventory.items
    invtext = "(empty)"
    if items and !items.empty?
      invtext = "\n#{Item.format_list(items)}"
    end
    msg = "Inventory: #{invtext}"
    return world, [SideEffect::Message.new(msg)]
  end
end
