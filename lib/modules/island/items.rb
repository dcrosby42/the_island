class Item
  def type
    self.class.name.downcase.to_sym
  end

  def self.desc(str)
    define_method :look do str end
  end

  def self.format_list(items)
    return items.map.with_index do |item, i|
             " #{i + 1}) #{item.look}"
           end.join("\n")
  end
end

class DriftWood < Item
  desc %{A piece of dry driftwood}
end

class SeaShell < Item
  desc %{A sea shell}
end

class Flint < Item
  desc %{A flint shard}
end
