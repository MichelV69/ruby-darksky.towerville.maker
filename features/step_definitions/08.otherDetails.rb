# 08.otherDetails.rb
require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

Given('a {string} Test-Build Towerville') do |build_config|
  @subject.primaryIndustryIndex = build_config.split("/")[0].to_i
  @subject.primaryEmployerScale = build_config.split("/")[1].to_i
  @subject.howManyFloors = build_config.split("/")[2].to_i
  puts "Number of Homes:  #{@subject.getNumberOfHomesEstimate}"
end

When('I check for the number of Shops') do
  @shopCountEstimate = @subject.getShopCountEstimate
end

Then('then I should get {int}') do |expectedShopCountEstimate|
  expect(@shopCountEstimate).to eq(expectedShopCountEstimate)
end

When('I check for the number of Social Spaces') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I check for the number of Gocial Spaces') do
  pending # Write code here that turns the phrase above into concrete actions
end
# ---
