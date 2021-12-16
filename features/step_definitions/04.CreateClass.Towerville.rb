# https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/
# https://www.rubyguides.com/2018/07/rspec-tutorial/#RSpec_Testing_Example

require "rspec/expectations"
require_relative('../../app.classes.rb')
require_relative('../../lib.wolfstar_studios.rb')

# ---
Before do
  @subject = Towerville2056.new
end

Given('that I request a random floor count') do
  @subject.howManyFloors = Towerville2056.getNewFloorCount()
end

Then('the building floor count should be set') do
  puts "building floor count: #{@subject.howManyFloors}"
  expect(@subject.howManyFloors).not_to eq(-1)
end

Then('should be within a valid range') do
  expect(@subject.howManyFloors).to be_greater_than(20)
  expect(@subject.howManyFloors).to be_less_than(101)
end
# --- end of file ---
