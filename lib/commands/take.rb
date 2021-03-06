class Take < Command
  verb :take, :get, :t
  help_text %{Picks up an item from this location and puts it into your inventory.\nEg:\n  "take sea" (takes a seashell)\n  "take 2" (takes the second item at this location)\n  "take" (takes the first item at this location)}

  include MapHelper
  include ItemHelper

  def run(world, action)
    subject = action[1]

    local_items = current_location(world).items

    if !subject
      if local_items.empty?
        return world, [SideEffect::Message.new('Take what?')]
      end
      subject = 1
    end

    if String === subject and subject.downcase == 'all'
      fx = []
      local_items.length.times do
        msg = acquire(world, local_items, 1)
        fx << SideEffect::Message.new(msg)
      end
      return world, fx
    end

    msg = acquire(world, local_items, subject)

    return world, [SideEffect::Message.new(msg)]
  end

  private

  def acquire(world, items, subject)
    item = take_item(items, subject)
    if item
      world.player.inventory.items.push(item)
      return "OK. #{item.look} added to inventory."
    else
      return "Couldn't get #{subject}"
    end
  end
end
