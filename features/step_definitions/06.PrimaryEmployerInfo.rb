require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')
# ---

Given('the Primary Industry has been generated') do
  @subject.primaryIndustry = Towerville2056::getRandomPrimaryIndustry
	p @subject.primaryIndustry
end

When('I directly set the Primary Employer Scale') do
  @new_primary_employers_scale = 1
	@subject.primaryEmployerScale = @new_primary_employers_scale
end

Then('I should get the details for the Primary Employer Scale that I expect') do
  @table_row_data = @all_tables[:PrimaryEmployerScale][@new_primary_employers_scale]

  expect(@subject.getprimaryEmployerScale_as_text).to eq(@table_row_data)
end


# correct_PES =  3 * @new_primary_employers_scale +
#      SQRT(@subject.getNumberOfHomesEstimate) +
#      3x Primary Employer Scale +
#      Something.Something - Something.Else

# --- end of file ---
