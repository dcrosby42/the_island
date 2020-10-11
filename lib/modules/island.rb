require 'prompt'
require 'commands'
require 'modules/island/location'
require 'modules/island/items'

class Inventory
  vattr_initialize [:items]
end

class Player
  vattr_initialize [:inventory]
end

class State
  attr_accessor :location_id, :time
end

class IslandWorld
  attr_accessor :state, :map, :log, :bag, :player

  def initialize
    @map = {} # int => Location
    @state = State.new
    @player = Player.new(inventory: Inventory.new(items: []))
    # @log = GameLog.new
    # puts "huh?"
  end
end

module Island
  extend self

  def create
    world = IslandWorld.new

    beach = Location.new(
      id: 1,
      name: 'Cove Shores',
      text: "You stand alone on the beach. It's sunny, slightly breezey and fairly calm.\nGulls can be heard in the distance.",
      exits: [
        { dir: 'west', location_id: 2 },
        { dir: 'north', location_id: 3 },
      ],
      items: [
        DriftWood.new,
        SeaShell.new,
      ],
    )
    shallows = Location.new(
      id: 2,
      name: 'Cove Shallows',
      text: "You're waste deep in glittering blue water. Briney waves lap at your waste, and you're concerned your possesions may be getting drenched.",
      exits: [
        { dir: 'east', location_id: 1 },
        { dir: 'north', location_id: 3 },
      ],
      items: [
        SeaShell.new,
      ],
    )
    point = Location.new(
      id: 3,
      name: 'North Pointe',
      text: "You're at the northern extent of this tiny island.\nHere, the eastward beach ends amidst tumbled rocks and reeds.",
      exits: [
        { dir: 'south', location_id: 1 },
      ],
      items: [
        Flint.new,
      ],
    )

    world.map[1] = beach
    world.map[2] = shallows
    world.map[3] = point
    world.state.location_id = 1
    world.state.time = Time.parse('apr 24 1652 8:00am')

    return Look.new.run(world, nil)
  end

  def update(world, action)
    if command = Command.find(action)
      # if command.verbs.first != action.first
      #   _, *tail = action
      #   inferred = [command.verbs.first.to_s, *tail]
      #   puts "(#{inferred.join(' ')})"
      # end
      return command.new.run(world, action)
    end
    return world, []
  end

  def get_prompt(world)
    Prompt.new(label: '', term: '>')
  end
end
