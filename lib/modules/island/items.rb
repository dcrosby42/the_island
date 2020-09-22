class Item
  def type
    self.class.name.downcase.to_sym
  end

  def self.format_list(items)
    return items.map.with_index do |item, i|
             " #{i + 1}) #{item.look}"
           end.join("\n")
  end
end

class DriftWood < Item
  def look
    %{A piece of dry driftwood}
  end
end
