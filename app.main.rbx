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
tv.name = "Example Tower"
tv.number_of_floors = Towerville2056::random_floor_count
tv.primary_industry_index = Towerville2056::random_primary_industry_index

tv.building_profile.each { |bldg_section, section_data|
    tv.building_profile[bldg_section] =  Towerville2056.random_building_profile(bldg_section, tv)
  }

tv.primary_employer_scale = Towerville2056::random_primary_employer_scale()
tv.shop_count_variance_percent = Towerville2056::random_variance_by_primary_economic_rating(tv.primary_industry_index)

tv.social_spaces_variance = Towerville2056.random_variance_by_primary_economic_rating(tv.primary_economic_rating)

tv.green_spaces_variance = Towerville2056.random_variance_by_primary_economic_rating(tv.primary_economic_rating)

space_bar = spaces(tv.name.length)
# ---
puts "\n\n ----- "
puts "\n #{tv.name} :: # of Floors: #{tv.number_of_floors}"
puts " #{space_bar} :: Height: #{tv.building_height} meters tall"
puts " #{space_bar} :: Ground area footprint: #{tv.text_block_for_building_foot_print}"
puts " #{space_bar} :: # of Homes : #{tv.text_block_for_number_of_homes_estimate}"
puts " #{space_bar} :: # of People : #{tv.text_block_for_population_estimate}"

puts " #{space_bar} :: Approximate # of shops: #{tv.shop_count_estimate}"
puts " #{space_bar} :: Approximate # of social spaces : #{tv.text_block_for_social_spaces_data}"
puts " #{space_bar} :: Approximate # of green spaces : #{tv.text_block_for_green_spaces_data}"

tv.building_profile.keys.each { |bldg_section|
  front = " #{space_bar}"
  if bldg_section == :basement
    front = "\n Building Profile:"
  end
  ## REDO :  use the Tabulo.gem here for an output table
  text_block = tv.text_block_for_building_profile(bldg_section)
  if bldg_section == :crown_cap
    text_block = "(not present)" if tv.building_profile[bldg_section].first == "(none)"
  end
  puts word_wrap_this("#{front} :: #{label_for bldg_section}: #{text_block} ", {at: 77})
  }

puts "\n" + word_wrap_this(" Economics: :: #{label_for 'primary_industry_index'} : #{tv.primary_industry_index} =>  #{tv.text_block_for_primary_industry_index}", {at: 77})

puts " #{space_bar} :: #{label_for 'primary_employer_scale'}: #{tv.primary_employer_scale} => #{tv.text_block_for_primary_employer_scale} "

puts " #{space_bar} :: #{label_for 'primary_economic_rating'} : #{tv.primary_economic_rating } => #{tv.text_block_for_primary_economic_rating}"

puts "\n\n  #{space_bar}"
# --- ---
