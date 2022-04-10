require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')
# ---

When('initialize has run') do
  object_post_intialize_expectations()
end

Then('Primary Employer Scale should be {int}') do |expect_value|
  expect(@subject.primary_employer_scale).to eq(expect_value)
end

Given('the Primary Industry has been generated') do
  @subject.primary_industry_index = Towerville2056::random_primary_industry_index
end

When('I directly set the Primary Employer Scale') do
  @new_primary_employers_scale = 1
	@subject.primary_employer_scale = @new_primary_employers_scale
end

Then('I should get the details for the Primary Employer Scale that I expect') do
  @table_row_data = @all_tables[:primary_employer_scale][@new_primary_employers_scale]

  expect(@subject.text_block_for_primary_employer_scale).to eq(@table_row_data)
end

When('I randomly set the Primary Employer Scale') do
  @subject.primary_employer_scale = Towerville2056::random_primary_employer_scale()
end

Then('Primary Employer Scale should be valid') do
  expect(@subject.primary_employer_scale).to be_greater_than(0)
  expect(@subject.primary_employer_scale).to be_less_than(16)
end

Then('I should get valid details for the Primary Employer Scale') do
  expect(@subject.text_block_for_primary_employer_scale).not_to eq("")
end

# --- end of file ---
