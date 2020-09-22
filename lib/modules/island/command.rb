class Command
  def self.verb(vsym)
    define_method :verb do
      vsym
    end
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.known
    @known ||= self.descendants.map do |clazz| clazz.new end
  end

  def self.find(action)
    command = known.find { |c| c.match(action) }
    if not command
      command = known.find { |c| c.soft_match(action) }
    end
    command
  end

  def match(action)
    verb.to_s == action.first.to_s
  end

  def soft_match(action)
    verb.to_s.start_with?(action.first.to_s)
  end

  def run(world, action)
    return world, []
  end
end
