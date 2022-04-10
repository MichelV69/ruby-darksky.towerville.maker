require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')
# ---

Then('Primary Economic Rating should be {int}') do |expect_value|
  expect(@subject.primary_economic_rating).to eq(expect_value)
end

Then('Primary Economic Rating should be valid') do
  expect(@subject.primary_economic_rating.round.to_i).to be_greater_than(0)
end

Then('I should get valid details for the Primary Economic Rating') do
  peri = {}
  peri[:min_value] = 270
  peri[:max_value] = 9000
  expect(@subject.primary_economic_rating).to be_greater_than(peri[:min_value])
  expect(@subject.primary_economic_rating).to be_less_than(peri[:max_value])
end

Given('I set the Primary Industry to {int}') do |new_PII|
  @subject.primary_industry_index = new_PII
end

Given('I set the Primary Employer Scale to {int}') do |new_PES|
  @subject.primary_employer_scale = new_PES
end

When('I set the Floor Count to {int}') do |new_FloorCount|
  @subject.number_of_floors = new_FloorCount
  puts "Number of Homes:  #{@subject.number_of_homes_estimate}"
end

Then('the Primary Economic Rating value should be {int}') do |expect_value|
  expect(@subject.primary_economic_rating).to eq(expect_value)
end

Then('the Primary Economic Rating description should be {string}') do |expect_text|
  expect(@subject.text_block_for_primary_economic_rating).to eq(expect_text)
end

# --- end of file ---
