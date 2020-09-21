class Handler
  def self.verb(vsym)
    define_method :verb do
      vsym
    end
  end

  def match(action)
    verb.to_s == action.first.to_s
  end

  def soft_match(action)
    verb.to_s.start_with?(action.first.to_s)
  end

  def handle(world, action)
    return world, []
  end
end
