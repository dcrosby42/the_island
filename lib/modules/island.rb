require "game_view"
require "modules/island/location"

class IslandWorld
  attr_reader :state, :map, :log, :bag

  def initialize
    @map = {}
    @state = {}
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

    return world, look(world)
  end

  def update(world, action)
    case action.first
    when "go"
      fx = go(world, action)
      return world, fx
    when "look"
      return world, look(world, action)
    end
    world
  end

  def get_prompt(world)
    Prompt.new(label: "", term: "?")
  end

  private

  def look(world, action = nil)
    loc = world.map[world.state[:location_id]]
    text = "#{loc.name}\n\n#{loc.text}"
    [SideEffect::Message.new(text)]
  end

  def go(world, action)
    dir = action[1]
    if dir.nil?
      return [SideEffect::Message.new("Go where?")]
    end
    loc = current_location(world)
    ex = loc.exits.find do |e| e[:dir] == dir end
    if ex
      world.state[:location_id] = ex[:location_id]
      return look(world)
    else
      return [SideEffect::Message.new("Cannot go '#{dir}' from here.")]
    end
  end

  def current_location(world)
    world.map[world.state[:location_id]]
  end
end
