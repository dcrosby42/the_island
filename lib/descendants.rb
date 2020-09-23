# A class may "extend" this module to acquire the .descendants class method
# which will enumerate that class's subclasses.
module Descendants
  def descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
