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
tv.number_of_floors = Towerville2056::get_random_floor_count
tv.primary_industry_index = Towerville2056::get_random_primary_industry_index

tv.building_profile[:bottom] = Towerville2056.get_random_building_profile(:bottom)
tv.building_profile[:middle] = Towerville2056.get_random_building_profile(:middle)
tv.building_profile[:crown] = Towerville2056.get_random_building_profile(:crown)
tv.building_profile[:crown_cap] = Towerville2056.get_random_building_profile(:crown_cap)

tv.primary_employer_scale = Towerville2056::get_random_primary_employer_scale()
tv.shop_count_variance_percent = Towerville2056::get_random_variance_by_primary_economic_rating(tv.primary_industry_index)

space_bar = spaces(tv.name.length)
puts "\n\n ----- \n #{tv.name} :: #{tv.get_primary_industry_as_text[:summary_desc]} (#{tv.get_primary_industry_as_text[:broad_desc]})"
puts " #{space_bar} :: primary Employer Scale: #{tv.primary_employer_scale}: #{tv.get_primary_employer_scale_as_text} "

puts "\n #{tv.name} :: Bottom section: #{tv.building_profile[:bottom]} "
puts " #{space_bar} :: Middle section: #{tv.building_profile[:middle]} "
puts " #{space_bar} :: Crown section: #{tv.building_profile[:crown]} "
puts " #{space_bar} :: 'Crown Forest': #{tv.building_profile[:crown_cap]} "

puts "\n #{tv.name} :: # of Floors: #{tv.number_of_floors}"
puts " #{space_bar} :: Height: #{tv.get_building_height} meters tall"
puts " #{space_bar} :: Ground area footprint: #{tv.get_building_foot_print_as_text}"
puts " #{space_bar} :: # of Homes : #{tv.get_number_of_homes_estimate}"
puts " #{space_bar} :: # of People : #{tv.get_population_estimate}"

puts "\n #{tv.name} :: Relative Economic Status : #{tv.get_primary_economic_rating } : #{tv.get_primary_economic_rating_as_text}"
puts " #{space_bar} :: Approximate # of shops : #{tv.get_shop_count_estimate}"
# --- ---
