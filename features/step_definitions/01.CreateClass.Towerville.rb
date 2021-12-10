# https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/
# https://www.rubyguides.com/2018/07/rspec-tutorial/#RSpec_Testing_Example

require "rspec/expectations"
require_relative('../../app.classes.rb')
require_relative('../../lib.wolfstar_studios.rb')

# ---
Before do
  @subject = Towerville2056.new
end

Given('that I create a new instance of Towerville2056') do
    expect(@subject).not_to be_nil
end

Then('initialize should run') do
  expect(@subject.name).to eq("example")
  expect(@subject.primaryIndustry).to eq("undefined")
  expect(@subject.howManyFloors).to eq(-1)
end

Given('that I set the Tower name to {string}') do |string|
  @subject.name = "BigAndRich"
end

Then('I should see the name {string}') do |string|
  expect(@subject.name).to eq("BigAndRich")
end

Given('that I set the Tower height to {int} stories') do |stories_tall|
  @subject.howManyFloors = stories_tall
end

Then('I should see a height in metres of {int}m') do |metres_tall|
  expect(@subject.getBuildingHeight).to eq(metres_tall)
end

# --- end of file ---
