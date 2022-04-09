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
    puts "bldg_section: [#{bldg_section}]"
    tv.building_profile[bldg_section] =  Towerville2056.random_building_profile(bldg_section, tv)
  }

tv.primary_employer_scale = Towerville2056::random_primary_employer_scale()
tv.shop_count_variance_percent = Towerville2056::random_variance_by_primary_economic_rating(tv.primary_industry_index)

tv.social_spaces_variance_percent = Towerville2056.random_variance_by_primary_economic_rating(tv.primary_economic_rating)

tv.green_spaces_variance_percent = Towerville2056.random_variance_by_primary_economic_rating(tv.primary_economic_rating)

space_bar = spaces(tv.name.length)
# ---
puts "\n\n ----- "
puts "\n #{tv.name} :: # of Floors: #{tv.number_of_floors}"
puts " #{space_bar} :: Height: #{tv.building_height} meters tall"
puts " #{space_bar} :: Ground area footprint: #{tv.building_foot_print.to_desc}"
puts " #{space_bar} :: # of Homes : #{tv.number_of_homes_estimate.to_s_formated}"
puts " #{space_bar} :: # of People : #{tv.population_estimate.to_s_formated}"

puts " #{space_bar} :: Approximate # of shops: #{tv.shop_count_estimate}"
puts " #{space_bar} :: Approximate # of social spaces : #{tv.social_spaces_data.to_desc}"
puts " #{space_bar} :: Approximate # of green spaces : #{tv.green_spaces_data.to_desc}"

puts "\n #{tv.name} :: Bottom section: #{tv.building_profile[:bottom]} "
puts " #{space_bar} :: Middle section: #{tv.building_profile[:middle]} "
puts " #{space_bar} :: Crown section: #{tv.building_profile[:crown]} "
puts " #{space_bar} :: 'Crown Forest': "
word_wrap_this tv.building_profile[:crown_cap]

tv.building_profile.each { |bldg_section|
  front = " #{space_bar}"
  if bldg_section == :bottom
    front = "\n #{tv.name}"
  end

  tv.building_profile[bldg_section] =  Towerville2056.random_building_profile(bldg_section)


  }

puts "\n #{tv.name} :: Economics: #{tv.primary_industry.to_desc[:summary_desc]}"
word_wrap_this tv.primary_industry.to_desc[:broad_desc]

puts " #{space_bar} :: primary Employer Scale: #{tv.primary_employer_scale}: #{tv.primary_employer_scale.to_desc} "
puts " #{space_bar} :: Relative Economic Status : #{tv.primary_economic_rating } : #{tv.primary_economic_rating.to_desc}"

puts "\n\n  #{space_bar}"
# --- ---
