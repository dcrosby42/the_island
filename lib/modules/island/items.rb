require 'descendants'

class Item
  extend Descendants

  def type
    self.class.type
  end

  class << self
    def type
      name.downcase.to_sym
    end

    def get_class(sym)
      (self.descendants.find do |d| d.type.to_sym == sym end) || raise("No Item type #{sym.inspect}")
    end

    def list_types
      self.descendants.map do |d| d.type end
    end

    def desc(str)
      define_method :look do str end
    end

    def format_list(items)
      return items.map.with_index do |item, i|
               " #{i + 1}) #{item.look}"
             end.join("\n")
    end
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
