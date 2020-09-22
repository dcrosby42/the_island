require "prompt"
require "commands"
require "modules/island/location"
require "modules/island/items"

class Inventory
  vattr_initialize [:items]
end

class Player
  vattr_initialize [:inventory]
end

class IslandWorld
  attr_accessor :state, :map, :log, :bag, :player

  def initialize
    @map = {}
    @state = {}
    @player = Player.new(inventory: Inventory.new(items: []))
    # @log = GameLog.new
    # @bag = GameInventory.new
    # puts "huh?"
  end
end

module Island
  extend self

  def create
    world = IslandWorld.new

    beach = SimpleLocation.new(
      id: 1,
      name: "Cove Shores",
      text: "You stand alone on the beach. It's sunny, slightly breezey and fairly calm.\nGulls can be heard in the distance.",
      exits: [
        { dir: "west", location_id: 2 },
        { dir: "north", location_id: 3 },
      ],
      items: [
        DriftWood.new,
        SeaShell.new,
      ],
    )
    shallows = SimpleLocation.new(
      id: 2,
      name: "Cove Shallows",
      text: "You're waste deep in glittering blue water. Briney waves lap at your waste, and you're concerned your possesions may be getting drenched.",
      exits: [
        { dir: "east", location_id: 1 },
        { dir: "north", location_id: 3 },
      ],
      items: [
        SeaShell.new,
      ],
    )
    point = SimpleLocation.new(
      id: 3,
      name: "North Pointe",
      text: "You're at the northern extent of this tiny island.\nHere, the eastward beach ends amidst tumbled rocks and reeds.",
      exits: [
        { dir: "south", location_id: 1 },
      ],
      items: [
        Flint.new,
      ],
    )

    world.map[1] = beach
    world.map[2] = shallows
    world.map[3] = point
    world.state[:location_id] = 1

    return Look.new.run(world, nil)
  end

  def update(world, action)
    command = Command.find action
    if command
      return command.run(world, action)
    else
      # For convenience, let's see if the user was using a "go" abbreviation.
      action.unshift "go"
      command = Command.find action
      if command
        # yup.
        return command.run(world, action)
      end
    end
    return world, []
  end

  def get_prompt(world)
    Prompt.new(label: "", term: ">")
  end
end
