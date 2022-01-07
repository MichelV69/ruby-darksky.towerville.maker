# https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/
# https://www.rubyguides.com/2018/07/rspec-tutorial/#RSpec_Testing_Example

require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../app.classes.rb')

# ---
When ('I request a random floor count') do
  @subject.howManyFloors = Towerville2056.getRandomFloorCount()
end

Then('the building floor count should be set') do
  puts "building floor count: #{@subject.howManyFloors}"
  expect(@subject.howManyFloors).not_to eq(-1)
end

Then('should be within a valid range') do
  expect(@subject.howManyFloors).to be_greater_than(20)
  expect(@subject.howManyFloors).to be_less_than(101)
end

Given('I request a random Building Profile for the {string} section') do |string|
	building_profile_section = string.to_lower.gsub(' ','_').to_sym
  @subject.buildingProfile[building_profile_section] = Towerville2056.getRandomBuildingProfile(building_profile_section)
end

Then('Building Profile - {string} should be set') do |string|
	building_profile_section = string.to_lower.gsub(' ','_').to_sym
	expect(@subject.buildingProfile[building_profile_section]).not_to eq("unset")
  expect(@subject.buildingProfile[building_profile_section]).not_to eq("")
end

When('I request the Number of Homes in the Building') do
	@subject.howManyFloors = 60
end

Then('the Number of Homes in the Building should be {int}') do |int|
	expect(@subject.getNumberOfHomesEstimate()).to eq(int)
end

When('I Calculate the Towerville Population') do
	@test_population = @subject.getPopulationEstimate()
end

Then('the Towerville Population should be {string}') do |string|
	expect(@subject.name).to eq("Recycled Property")
  expect(@test_population).to eq(string.as_int)
end
# --- end of file ---
