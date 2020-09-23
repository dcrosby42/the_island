require 'damerau-levenshtein'

module StringDistance
  extend self

  # Compute the DamerauLevenshtein distance between two strings
  def damerau_levenshtein_distance(xstr, ystr)
    DamerauLevenshtein.distance(xstr, ystr)
  end

  # Detect the longest common substring
  def lcs(xstr, ystr)
    return '' if xstr.empty? || ystr.empty?

    x, xs, y, ys = xstr[0..0], xstr[1..-1], ystr[0..0], ystr[1..-1]
    if x == y
      x + lcs(xs, ys)
    else
      [lcs(xstr, ys), lcs(xs, ystr)].max_by { |x| x.size }
    end
  end

  # Compute the length of the longest common substring
  def lcs_length(xstr, ystr)
    lcs(xstr, ystr).length
  end
end
