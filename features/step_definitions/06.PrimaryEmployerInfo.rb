require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')
# ---

When('initialize has run') do
  object_post_intialize_expectations()
end

Then('Primary Employer Scale should be {int}') do |expect_value|
  expect(@subject.primaryEmployerScale).to eq(expect_value)
end

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

When('I randomly set the Primary Employer Scale') do
  @subject.primaryEmployerScale = Towerville2056::getRandomPrimaryEmployerScale()
end

Then('Primary Employer Scale should be valid') do
  expect(@subject.primaryEmployerScale).to be_greater_than(0)
  expect(@subject.primaryEmployerScale).to be_less_than(16)
end

Then('I should get valid details for the Primary Employer Scale') do
  expect(@subject.getprimaryEmployerScale_as_text).not_to eq("")
end

# economic_scale =  3 * @new_primary_employers_scale +
#      SQRT(@subject.getNumberOfHomesEstimate) +
#      3x Primary Employer Scale +
#      Something.Something - Something.Else

# --- end of file ---