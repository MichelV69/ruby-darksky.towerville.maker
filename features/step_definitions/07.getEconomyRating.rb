require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')
# ---

Then('Primary Economic Rating should be {int}') do |expect_value|
  expect(@subject.getPrimaryEconomicRating).to eq(expect_value)
end

Then('Primary Economic Rating should be valid') do
  expect(@subject.getPrimaryEconomicRating.round.to_i).to be_greater_than(0)
end

Then('I should get valid details for the Primary Economic Rating') do
  peri = {}
  peri[:min_value] = 250
  peri[:max_value] = 9000
  expect(@subject.getPrimaryEconomicRating).to be_greater_than(peri[:min_value])
  expect(@subject.getPrimaryEconomicRating).to be_less_than(peri[:max_value])
  puts @subject.getPrimaryEconomicRating
end

Given('I set the Primary Industry to {int}') do |new_PII|
  @subject.primaryIndustryIndex = new_PII
end

Given('I set the Primary Employer Scale to {int}') do |new_PES|
  @subject.primaryEmployerScale = new_PES
end

When('I set the Floor Count to {int}') do |new_FloorCount|
  @subject.howManyFloors = new_FloorCount
end

Then('the Primary Economic Rating value should be {int}') do |int|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the Primary Economic Rating description should be {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

# --- end of file ---
