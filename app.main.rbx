#! env ruby
# presumes cucumber –init // for Testing
require('psych')
require_relative('lib.wolfstar_studios.rb')
require_relative('app.classes.rb')

22.times do | count| puts "#{count+1}:" + roll_and_explode("4.d4").to_s ; end

tv = Towerville2056.new()
puts "tables found: #{tv.tables_count}"

tv.name = "Example Tower"
tv.primaryIndustry = Towerville2056::getRandomPrimaryIndustry()
puts " #{tv.name} :: #{tv.primaryIndustry[:summaryDesc]} (#{tv.primaryIndustry[:broadDesc]})"
# --- ---
