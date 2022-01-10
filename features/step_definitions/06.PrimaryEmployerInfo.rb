require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')
# ---

Given('the Primary Industry has been generated') do
  @subject.primaryIndustry = Towerville2056::getRandomPrimaryIndustry
	p @subject.primaryIndustry
end

When('Directly set the Primary Employer Scale') do
  @new_primary_employers_scale = 1
	@subject.primaryEmployerScale = @new_primary_employers_scale
end

Then('I should get the details for the Primary Employer Scale that I expect') do
  pending # Write code here that turns the phrase above into concrete actions
end

# --- end of file ---
