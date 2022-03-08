# https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/
# https://www.rubyguides.com/2018/07/rspec-tutorial/#RSpec_Testing_Example

require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

# ---
When ('I request a random floor count') do
  @subject.number_of_floors = Towerville2056.get_random_floor_count()
end

Then('the building floor count should be set') do
  puts "building floor count: #{@subject.number_of_floors}"
  expect(@subject.number_of_floors).not_to eq(-1)
end

Then('should be within a valid range') do
  expect(@subject.number_of_floors).to be_greater_than(20)
  expect(@subject.number_of_floors).to be_less_than(101)
end

Given('I request a random Building Profile for the {string} section') do |building_profile_section|
  @subject.building_profile[as_table_target building_profile_section] = Towerville2056.get_random_building_profile(as_table_target(building_profile_section), @subject)
end

Then('Building Profile - {string} should be set') do |building_profile_section|
	expect(@subject.building_profile[as_table_target  building_profile_section].first).not_to eq("unset")
  expect(@subject.building_profile[as_table_target  building_profile_section].first).not_to eq("")
end

# --- start new ---

Given('the building is {int} stories tall') do |stories_tall|
  @subject.number_of_floors = stories_tall
end

Then('the {string} section should be {int}% of building height') do |section_requested, expected_floors_percent|

	floors_range = @subject.building_profile[as_table_target section_requested].last
  actual_floors_percent = 100.00 * (floors_range.count.to_f / @subject.number_of_floors.to_f)

  expect(actual_floors_percent.round(0)).to eq(expected_floors_percent.round(0))
end

Then('{string} section should be {int}% of the building height, but less than {int} floors') do |section_requested, expected_floors_percent, expected_floors_max_count|

	floors_range = @subject.building_profile[as_table_target section_requested].last
	actual_floors_percent = 100.00 * (floors_range.count.to_f / @subject.number_of_floors.to_f)

	expect(actual_floors_percent.round(0)).to eq(expected_floors_percent.round(0))
	expect(floors_range.count).to be_less_than(expected_floors_max_count)
end

Then('the {string} section should be higher than the {string} section but less than {int} floors') do |section_requested, section_prior, expected_floors_max_count|

	section_requested_floors_range = @subject.building_profile[as_table_target section_requested].last
	puts "#{section_requested} =>> #{section_requested_floors_range}"
	section_prior_floors_range = @subject.building_profile[as_table_target section_prior].last

	expect(section_requested_floors_range.first).to be_greater_than(section_prior_floors_range.last)
	expect(section_requested_floors_range.count).to be_less_than(expected_floors_max_count)
end

Then('the {string} section should be higher than {int} floors, but less than the {string} section') do |string, int, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('should be higher than the {string} section but less than the {string} section') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I have aleady requested a random Building Profile for the {string} section') do |section_requested|
	@subject.building_profile[as_table_target section_requested] = Towerville2056.get_random_building_profile(as_table_target(section_requested), @subject)
end
# ---- end new ----

When('I request the Number of Homes in the Building') do
	@subject.number_of_floors = 60
end

Then('the Number of Homes in the Building should be {int}') do |int|
	expect(@subject.get_number_of_homes_estimate()).to eq(int)
end

When('I Calculate the Towerville Population') do
	@test_population = @subject.get_population_estimate()
end

Then('the Towerville Population should be {string}') do |string|
  expect(@test_population).to eq(string.as_int)
end
# --- end of file ---
