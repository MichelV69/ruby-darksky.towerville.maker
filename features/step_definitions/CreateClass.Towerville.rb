# https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/
# https://www.rubyguides.com/2018/07/rspec-tutorial/#RSpec_Testing_Example

require "rspec/expectations"
require_relative('../../app.classes.rb')

class String
  def is_wrong!
    self  + "-isWrong"
  end
end

class Integer
  def is_wrong!
    self + 2
  end
end

Before do
  @subject = Towerville2056.new
end

Given('that I create a new instance of Towerville2056') do
    expect(@subject).not_to be_nil
end

Then('initialize should run') do
  expect(@subject.name).to eq("example")
  expect(@subject.primaryIndustry).to eq("undefined")
  expect(@subject.howManyFloors).to eq(11)
end

Given('that I set the Tower name to {string}') do |string|
  @subject.name = "BigAndRich"
end

Then('I should see the name {string}') do |string|
  expect(@subject.name).to eq("BigAndRich")
end

# --- end of file ---
