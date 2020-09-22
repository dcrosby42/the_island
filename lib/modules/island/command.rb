class Command
  class << self
    def verb(*syms)
      define_method :verbs do syms end
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
    (verbs.find do |verb| verb.to_s == action.first.to_s end) != nil
  end

  def soft_match(action)
    (verbs.find do |verb| verb.to_s.start_with?(action.first.to_s) end) != nil
  end

  def run(world, action)
    return world, []
  end
end
