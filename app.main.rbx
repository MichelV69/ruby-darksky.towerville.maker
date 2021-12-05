#! env ruby
# presumes cucumber –init // for Testing
require('psych')
require_relative('app.classes.rb')
require_relative('lib.wolfstar_studios.rb')
# --- ---

puts "... about to load YAML from disk..."

yaml_data=Psych.load("--- \n 1 : \n - some : data\n - another : set of data")
puts yaml_data.inspect

puts "... about to load YAML from disk..."
yaml_data = Psych.load_file("tables.randomTowerville.yaml")

puts yaml_data.last.inspect
