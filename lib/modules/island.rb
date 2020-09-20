require "game_view"

IslandWorld = Struct.new(
  :location_id,
  :map,
  :log,
  :bag
) do
  def initialize
    # @map = GameMap.new
    # @log = GameLog.new
    # @bag = GameInventory.new
  end
end

module Island
  extend self

  def create
    world = IslandWorld.new
    return world
  end

  def update(world, action)
  end

  def render(world)
    return GameView.new(
             text: "Cove Shores\n\nYou stand alone on the beach. It's sunny, slightly breezey and fairly calm.\nGulls can be heard in the distance.",
             prompt: Prompt.new(label: "", term: "?"),
           )
  end
end
