# A class may "extend" this module to acquire the .descendents class method
# which will enumerate that class's subclasses.
module Descendents
  def descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
