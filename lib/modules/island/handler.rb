class Handler
  def self.verb(vsym)
    define_method :verb do
      vsym
    end
  end

  def match(action)
    action.first.to_s == verb.to_s
  end

  def handle(world, action)
    return world, []
  end
end
