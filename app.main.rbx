#! env ruby
# presumes cucumber –init // for Testing
require('psych')
require_relative('app.classes.rb')
require_relative('lib.wolfstar_studios.rb')

tv = Towerville2056.new()
puts "tables found: #{tv.table_content_sets.count}"

tv.name = "Example Tower"
tv.primaryIndustry = Towerville2056::getRandomPrimarIndustry()
# --- ---
