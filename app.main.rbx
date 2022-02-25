#! env ruby
# presumes cucumber –init // for Testing
require_relative('lib.wolfstar_studios.rb')
require_relative('class.Towerville2056.rb')

myAppConfig = AppConfig.new
puts "config option sets found: #{myAppConfig.config_option_sets_count}"

if myAppConfig.general_options[:use_random_org_for_dice]
  require_relative('class.ExternalRandom.rb')
end

tv = Towerville2056.new()
puts "tables found: #{tv.tables_count}"

tv.name = "Example Tower"
tv.howManyFloors = Towerville2056::getRandomFloorCount
tv.primaryIndustryIndex = Towerville2056::getRandomPrimaryIndustryIndex

tv.buildingProfile[:bottom] = Towerville2056.getRandomBuildingProfile(:bottom)
tv.buildingProfile[:middle] = Towerville2056.getRandomBuildingProfile(:middle)
tv.buildingProfile[:crown] = Towerville2056.getRandomBuildingProfile(:crown)
tv.buildingProfile[:crown_cap] = Towerville2056.getRandomBuildingProfile(:crown_cap)

tv.primaryEmployerScale = Towerville2056::getRandomPrimaryEmployerScale()

space_bar = spaces(tv.name.length)
puts "\n\n ----- \n  #{tv.name} :: #{tv.getPrimaryIndustry_as_text[:summaryDesc]} (#{tv.getPrimaryIndustry_as_text[:broadDesc]})"
puts " #{space_bar} :: primary Employer Scale: #{tv.primaryEmployerScale}: #{tv.getprimaryEmployerScale_as_text} "

puts " #{tv.name} :: Bottom section: #{tv.buildingProfile[:bottom]} "
puts " #{space_bar} :: Middle section: #{tv.buildingProfile[:middle]} "
puts " #{space_bar} :: Crown section: #{tv.buildingProfile[:crown]} "
puts " #{space_bar} :: 'Crown Forest': #{tv.buildingProfile[:crown_cap]} "
puts " #{tv.name} :: # of Floors: #{tv.howManyFloors}"
puts " #{space_bar} :: Height: #{tv.getBuildingHeight} meters tall"
puts " #{space_bar} :: Foot Print: ????"
puts " #{space_bar} :: # of Homes : #{tv.getNumberOfHomesEstimate}"
puts " #{space_bar} :: # of People : #{tv.getPopulationEstimate}"
puts " #{space_bar} :: Relative Economic Status : #{tv.getPrimaryEconomicRating } : #{tv.getPrimaryEconomicRating_as_Text}"
# --- ---
