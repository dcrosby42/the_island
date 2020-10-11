require 'prompt'
require 'commands'
require_pattern __dir__ + '/island/*.rb'

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
  attr_accessor :state, :map, :player

  def initialize
    @map = {} # int => Location
    @state = State.new
    @player = Player.new(inventory: Inventory.new(items: []))
  end
end

module Island
  extend self

  def create
    world = IslandWorld.new

    locs = Locations.load_file('data/island1.locations.yml')
    locs.each do |loc|
      world.map[loc.id] = loc
    end

    world.state.location_id = 1
    world.state.time = Time.parse('apr 24 1652 8:00am')

    return Look.new.run(world, nil)
  end

  def update(world, action)
    if command = Command.find(action)
      return command.new.run(world, action)
    end
    return world, []
  end

  def get_prompt(world)
    Prompt.new(label: '', term: '>')
  end
end
