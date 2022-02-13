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
  pending # Write code here that turns the phrase above into concrete actions
end

# economic_scale =  3 * @new_primary_employers_scale +
#      SQRT(@subject.getNumberOfHomesEstimate) +
#      3x Primary Employer Scale +
#      Something.Something - Something.Else

# --- end of file ---
