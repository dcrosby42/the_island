# Dir-glob a set of files and 'require' them.
# No ordering guarantees.
# By default, assumes the glob_pattern is relative to the
# Eg:  require_pattern "#{__dir__}/commands/*_helper.rb"
def require_pattern(glob_pattern)
  Dir[glob_pattern].each do |f| require f end
end
