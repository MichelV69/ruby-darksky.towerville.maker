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

  @roll4d6 = {}
  @roll4d6[:max] = 24 - 14
  @roll4d6[:min] =  4 - 14

  def object_post_intialize_expectations()
    expect(@subject.name).to eq("example")
    expect(@subject.primary_industry_index).to eq(-1)
    expect(@subject.number_of_floors).to eq(-1)
    expect(@subject.primary_employer_scale).to eq(-1)
  end
end

Given('that I have an instance of Towerville2056') do
  expect(@subject).not_to be_nil
end

Then('initialize should run') do
  object_post_intialize_expectations()
end

Given('that I set the Tower name to {string}') do |new_building_name|
  @subject.name = new_building_name
end

Then('I should see the name {string}') do |new_building_name|
  expect(@subject.name).to eq(new_building_name)
end

Given('that I set the Tower height to {int} stories') do |stories_tall|
  @subject.number_of_floors = stories_tall
end

Then('I should see a height in metres of {int}m') do |metres_tall|
  expect(@subject.get_building_height).to eq(metres_tall)
end

# --- end of file ---
