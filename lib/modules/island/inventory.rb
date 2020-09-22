class Inventory < Command
  verb :inventory

  def run(world, action)
    items = world.player.inventory.items
    invtext = " nothing"
    if items and !items.empty?
      invtext = ":\n#{Item.format_list(items)}"
    end
    msg = "You're carrying#{invtext}"
    return world, [SideEffect::Message.new(msg)]
  end
end
