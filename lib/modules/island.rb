require "game_view"
require "modules/island/location"
require "modules/island/handler"
require "modules/island/go"
require "modules/island/look"

class IslandWorld
  attr_accessor :state, :map, :log, :bag, :handlers

  def initialize
    @map = {}
    @state = {}
    @handlers = []

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
        { dir: "east", location_id: 2 },
        { dir: "north", location_id: 3 },
      ],
    )
    shallows = SimpleLocation.new(
      id: 2,
      name: "Cove Shallows",
      text: "You're waste deep in glittering blue water. Briney waves lap at your waste, and you're concerned your possesions may be getting drenched.",
      exits: [
        { dir: "west", location_id: 1 },
        { dir: "north", location_id: 3 },
      ],
    )
    point = SimpleLocation.new(
      id: 3,
      name: "North Pointe",
      text: "You're at the northern extent of this tiny island.\nHere, the eastward beach ends amidst tumbled rocks and reeds.",
      exits: [
        { dir: "south", location_id: 1 },
      ],
    )

    world.map[1] = beach
    world.map[2] = shallows
    world.map[3] = point
    world.state[:location_id] = 1

    world.handlers = [
      Go.new,
      Look.new,
    ]
    return Look.new.handle(world, nil)
  end

  def update(world, action)
    handler = get_handler world, action
    if handler
      return handler.handle(world, action)
    else
      # For convenience, let's see if the user was using a "go" abbreviation.
      action.unshift "go"
      handler = get_handler world, action
      if handler
        # yup.
        return handler.handle(world, action)
      end
    end
    return world, []
  end

  def get_prompt(world)
    Prompt.new(label: "", term: ">")
  end

  private

  def get_handler(world, action)
    handler = world.handlers.find { |h| h.match(action) }
    if not handler
      handler = world.handlers.find { |h| h.soft_match(action) }
    end
    handler
  end
end
