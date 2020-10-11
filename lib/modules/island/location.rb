class Location
  vattr_initialize [:id!, :name!, :text, :exits, :items]
end

module Locations
  extend self

  def load_file(file)
    location_defs = YAML.load_file(file).map do |x| x.deep_symbolize_keys end
    location_defs.map(&method(:new_location))
  end

  def new_location(ldef)
    Location.new(
      id: ldef[:id],
      name: ldef[:name],
      text: ldef[:text].strip,
      exits: ldef[:exits],
      items: ldef[:items].map(&method(:new_item)),
    )
  end

  def new_item(type)
    Item.get_class(type).new
  end
end
