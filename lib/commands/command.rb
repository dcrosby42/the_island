require 'descendants'
require 'string_distance'

class Command
  extend Descendants

  class << self
    # Meta: Command subclasses need to define one or more "verbs" for themselves.
    def verb(*syms)
      @verbs = syms
    end

    # Meta: define a block of text for this Command's help message
    def help_text(s)
      @helps = s
    end

    attr_reader :verbs, :helps

    private

    def descendant_instances
      @descendant_instances ||= self.descendants.map do |clazz| clazz.new end
    end
  end

  # Find a Command implementation that matches the given action.
  # Attempts matching via #match, and failing that, re-searches using #soft_match
  def self.find(action)
    word = action.first.to_s.downcase
    search_results = descendants.flat_map do |clazz|
      clazz.verbs.map do |verb|
        verb_str = verb.to_s.downcase
        {
          verb: verb_str,
          command: clazz,
          ldist: StringDistance.damerau_levenshtein_distance(verb_str, word),
          lcs_size: StringDistance.lcs_length(verb_str, word),
        }
      end
    end.sort do |a, b|
      if b[:lcs_size] == a[:lcs_size]
        a[:ldist] <=> b[:ldist]
      else
        b[:lcs_size] <=> a[:lcs_size]
      end
    end
    # debug_search_results search_results
    return search_results.first[:command]
  end

  # XXX
  def self.debug_search_results(search_results)
    search_results.each do |sr|
      puts "#{sr[:lcs_size]} #{sr[:ldist]} #{sr[:verb]} #{sr[:command].to_s}"
    end
  end

  # Command subclasses must implement
  # (default noop implementation)
  def run(world, action)
    raise "Command subclass #{self.class.name} does not implement #run"
  end

  def self.help
    @helps || %{The '#{verbs.first}' command needs more info!}
  end
end
