module TimeHelper
  def time_str(t)
    t.strftime('%l:%M %p').strip
  end

  def look_time(t)
    "It's #{time_str t}"
  end
end
