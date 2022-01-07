#! env ruby
# presumes cucumber –init // for Testing
require('psych')
require_relative('lib.wolfstar_studios.rb')
require_relative('app.classes.rb')

tv = Towerville2056.new()
puts "tables found: #{tv.tables_count}"

tv.name = "Example Tower"
tv.primaryIndustry = Towerville2056::getRandomPrimaryIndustry()
tv.buildingProfile[:bottom] = Towerville2056.getRandomBuildingProfile(:bottom)
tv.buildingProfile[:middle] = Towerville2056.getRandomBuildingProfile(:middle)

space_bar = spaces(tv.name.length)
puts "\n\n ----- \n  #{tv.name} :: #{tv.primaryIndustry[:summaryDesc]} (#{tv.primaryIndustry[:broadDesc]})"
puts " #{tv.name} :: bottom section: #{tv.buildingProfile[:bottom]} "
puts " #{space_bar} :: middle section: #{tv.buildingProfile[:middle]} "
# --- ---
