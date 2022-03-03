# 08.otherDetails.rb
require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

Given('a {string} Test-Build Towerville') do |build_config|
  @subject.primaryIndustryIndex = build_config.split("/")[0].to_i
  @subject.primaryEmployerScale = build_config.split("/")[1].to_i
  @subject.howManyFloors = build_config.split("/")[2].to_i
end

When('I use getRandomShopCountVariancePercent') do
  @subject.shopCountVariancePercent = Towerville2056.getRandomShopCountVariancePercent(@subject.getPrimaryEconomicRating)
end

Then('the number of shops should be around {int}') do |expectedShopCountEstimate|

  maxPERModifier = 9000/500 - 9
  minPERModifier =   90/500 - 9
  max4d6Roll = 24 - 14
  min4d6Roll =  4 - 14

  maxShopCountModifierPercent = 1 + (maxPERModifier + max4d6Roll)/100.0
  minShopCountModifierPercent = 1 + (minPERModifier + min4d6Roll)/100.0

  highShopCount = expectedShopCountEstimate * maxShopCountModifierPercent
  lowShopCount  = expectedShopCountEstimate * minShopCountModifierPercent

  expect(@subject.getShopCountEstimate).to be_greater_than(lowShopCount)
  expect(@subject.getShopCountEstimate).to be_less_than(highShopCount)
end

When('I use getBuildingFootPrint_as_Text') do
  @buildingFootPrintText = @subject.getBuildingFootPrint_as_Text
end

Then('the Building Footprint text should be {string}') do |expected_string|
  expect(@buildingFootPrintText).to eq(expected_string)
end

When('I set getRandomSocialSpacesVariancePercent to 0.0 with getSocialSpaces_as_Text') do
  #@subject.socialSpacesVariancePercent = Towerville2056.getRandomSocialSpacesVariancePercent(@subject.getPrimaryEconomicRating)
  @subject.socialSpacesVariancePercent = 0.0

  @socialSpacesText = @subject.getSocialSpaces_as_Text
end

Then('the description of Social Spaces should be {string}') do |expected_string|
  expect(@socialSpacesText).to eq(expected_string)
end

When('I use getSocialSpaces with set getRandomSocialSpacesVariancePercent fully randomized') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the Social Spaces data should be reasonable') do
  pending # Write code here that turns the phrase above into concrete actions
end
# ---
