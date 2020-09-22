module MapHelper
  def current_location(world)
    loc_id = world.state[:location_id]
    if loc_id
      return world.map[loc_id]
    end
    nil
  end
end
