# https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/
# https://www.rubyguides.com/2018/07/rspec-tutorial/#RSpec_Testing_Example

require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

# ---
Before do
  @all_tables = Psych.load_file(Towerville2056::TABLE_FILENAME)
	@subject = Towerville2056.new
end

Given('that I have an instance of Towerville2056') do
  expect(@subject).not_to be_nil
end
Then('initialize should run') do
  expect(@subject.name).to eq("example")
  expect(@subject.primaryIndustry).to eq("undefined")
  expect(@subject.howManyFloors).to eq(-1)
end

Given('that I set the Tower name to {string}') do |new_building_name|
  @subject.name = new_building_name
end

Then('I should see the name {string}') do |new_building_name|
  expect(@subject.name).to eq(new_building_name)
end

Given('that I set the Tower height to {int} stories') do |stories_tall|
  @subject.howManyFloors = stories_tall
end

Then('I should see a height in metres of {int}m') do |metres_tall|
  expect(@subject.getBuildingHeight).to eq(metres_tall)
end

# --- end of file ---
