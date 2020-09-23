require 'descendents'

class Command
  extend Descendents

  class << self
    # Meta: Command subclasses need to define one or more "verbse" for themselves.
    def verb(*syms)
      define_method :verbs do syms end
    end

    private

    def descendent_instances
      @descendent_instances ||= self.descendants.map do |clazz| clazz.new end
    end
  end

  # Find a Command implementation that matches the given action.
  # Attempts matching via #match, and failing that, re-searches using #soft_match
  def self.find(action)
    command = descendent_instances.find { |c| c.match(action) }
    if not command
      command = descendent_instances.find { |c| c.soft_match(action) }
    end
    command
  end

  # Returns true if the action's first word is an exact match for this Command's verb
  # or one of its synonyms.
  def match(action)
    (verbs.find do |verb| verb.to_s == action.first.to_s end) != nil
  end

  # Returns true if the action's first word matches the START of this Command's verb
  # or one of its synonyms.
  def soft_match(action)
    (verbs.find do |verb| verb.to_s.start_with?(action.first.to_s) end) != nil
  end

  # Command subclasses must implement
  # (default noop implementation)
  def run(world, action)
    raise "Command subclass #{self.class.name} does not implement #run"
  end
end
