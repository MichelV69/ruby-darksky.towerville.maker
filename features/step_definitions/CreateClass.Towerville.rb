# https://www.rubypigeon.com/posts/rspec-expectations-cheat-sheet/
# https://www.rubyguides.com/2018/07/rspec-tutorial/#RSpec_Testing_Example

require "rspec/expectations"
require_relative('../../app.classes.rb')

class String
  def is_wrong!
    self  + "-isWrong"
  end
end

Before do
  @subject = Towerville2056.new
end

Given('that create a new instance of Towerville2056') do
    expect(@subject).not_to be_nil
end

Then('initialize should run') do
  test_string = "example"
  expect(@subject.name).to eq(test_string)
end

# --- end of file ---
