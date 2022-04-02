# 08.otherDetails.rb
require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

Given('a {string} Test-Build Towerville') do |build_config|
  @subject.primary_industry_index = build_config.split("/")[0].to_i
  @subject.primary_employer_scale = build_config.split("/")[1].to_i
  @subject.number_of_floors = build_config.split("/")[2].to_i
end

When('I use get_random_variance_by_primary_economic_rating') do
  @subject.shop_count_variance_percent = Towerville2056.get_random_variance_by_primary_economic_rating(@subject.primary_economic_rating)
end

Then('the number of shops should be around {int}') do |expectedShopCountEstimate|

  maxPERModifier = 9000/500 - 9
  minPERModifier =   90/500 - 9

  maxShopCountModifierPercent = 1 + (maxPERModifier + @roll4d6[:max])/100.0
  minShopCountModifierPercent = 1 + (minPERModifier + @roll4d6[:min])/100.0

  highShopCount = expectedShopCountEstimate * maxShopCountModifierPercent
  lowShopCount  = expectedShopCountEstimate * minShopCountModifierPercent

  expect(@subject.get_shop_count_estimate).to be_greater_than(lowShopCount)
  expect(@subject.get_shop_count_estimate).to be_less_than(highShopCount)
end

When('I use get_building_foot_print_to_desc') do
  @buildingFootPrintText = @subject.building_foot_print_to_desc
end

Then('the Building Footprint text should be {string}') do |expected_string|
  expect(@buildingFootPrintText).to eq(expected_string)
end

When('I set get_random_variance_by_primary_economic_rating to 0.0 with get_social_spaces_data_to_desc') do
  @subject.social_spaces_variance_percent = 0.0
  @social_spaces_text = @subject.get_social_spaces_data_to_desc
end

Then('the description of Social Spaces should be {string}') do |expected_string|
  expect(@social_spaces_text).to eq(expected_string)
end

When('I use get_social_spaces with set get_random_variance_by_primary_economic_rating fully randomized') do
  @subject.social_spaces_variance_percent = 0.0
  @social_spaces_median_data = @subject.get_social_spaces_data
  @subject.social_spaces_variance_percent = Towerville2056.get_random_variance_by_primary_economic_rating(@subject.primary_economic_rating)
end

Then('the Social Spaces data should be reasonable') do
  low_variance  = 1.0 + @roll4d6[:min]
  high_variance = 1.0 + @roll4d6[:max]

  expect(@subject.get_social_spaces_data[:total_msq].to_i).to be_greater_than((@social_spaces_median_data[:total_msq] * low_variance).to_i)

  expect(@subject.get_social_spaces_data[:total_msq].to_i).to be_less_than((@social_spaces_median_data[:total_msq] * high_variance).to_i)

  expect(@subject.get_social_spaces_data[:size_ea_msq].to_i).to be_greater_than((@social_spaces_median_data[:size_ea_msq] * low_variance).to_i)

  expect(@subject.get_social_spaces_data[:size_ea_msq].to_i).to be_less_than((@social_spaces_median_data[:size_ea_msq] * high_variance).to_i)
end

When('I set get_random_variance_by_primary_economic_rating to 0.0 with get_green_spaces_data_to_desc') do
  @subject.green_spaces_variance_percent = 0.0
  @green_spaces_text = @subject.get_green_spaces_data_to_desc
end

Then('the description of Green Spaces should be {string}') do |expected_string|
  expect(@green_spaces_text).to eq(expected_string)
end

When('I use get_green_spaces_data with set get_random_variance_by_primary_economic_rating fully randomized') do
  @subject.green_spaces_variance_percent = 0.0
  @green_spaces_median_data = @subject.get_social_spaces_data
  @subject.green_spaces_variance_percent = Towerville2056.get_random_variance_by_primary_economic_rating(@subject.primary_economic_rating)
end

Then('the Green Spaces data should be reasonable') do
  low_variance  = 1.0 + @roll4d6[:min]
  high_variance = 1.0 + @roll4d6[:max]

  expect(@subject.get_green_spaces_data[:total_msq].to_i).to be_greater_than((@green_spaces_median_data[:total_msq] * low_variance).to_i)

  expect(@subject.get_green_spaces_data[:total_msq].to_i).to be_less_than((@green_spaces_median_data[:total_msq] * high_variance).to_i)

  expect(@subject.get_green_spaces_data[:size_ea_msq].to_i).to be_greater_than((@green_spaces_median_data[:size_ea_msq] * low_variance).to_i)

  expect(@subject.get_green_spaces_data[:size_ea_msq].to_i).to be_less_than((@green_spaces_median_data[:size_ea_msq] * high_variance).to_i)
end

# ---
