#! env ruby
# presumes cucumber –init // for Testing
require('psych')
require_relative('app.classes.rb')
require_relative('lib.wolfstar_studios.rb')

tv = Towerville2056.new()
puts "tables found: #{tv.tables_count}"

tv.name = "Example Tower"
tv.primaryIndustry = Towerville2056::getRandomPrimaryIndustry()
puts tv.primaryIndustry
# --- ---
