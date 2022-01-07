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
tv.buildingProfile[:crown] = Towerville2056.getRandomBuildingProfile(:crown)
tv.buildingProfile[:crown_cap] = Towerville2056.getRandomBuildingProfile(:crown_cap)

space_bar = spaces(tv.name.length)
puts "\n\n ----- \n  #{tv.name} :: #{tv.primaryIndustry[:summaryDesc]} (#{tv.primaryIndustry[:broadDesc]})"
puts " #{tv.name} :: Bottom section: #{tv.buildingProfile[:bottom]} "
puts " #{space_bar} :: Middle section: #{tv.buildingProfile[:middle]} "
puts " #{space_bar} :: Crown section: #{tv.buildingProfile[:crown]} "
puts " #{space_bar} :: 'Crown Forest': #{tv.buildingProfile[:crown_cap]} "
# --- ---
