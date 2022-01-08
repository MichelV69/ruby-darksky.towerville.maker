require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

# ---
Before do
end

Given('I request Die Rolls for {string}, {string}, and {string}') do |string, string2, string3|
	@rolled_1d6 = 1.d6
	@rolled_1d8 = 1.d8
  @rolled_1d10 = 1.d10
end

Then('I should get three valid die results') do
  expect(@rolled_1d6).to be_between(1,6)
  expect(@rolled_1d8).to be_between(1,8)
  expect(@rolled_1d10).to be_between(1,10)
end
# ---
# eof
