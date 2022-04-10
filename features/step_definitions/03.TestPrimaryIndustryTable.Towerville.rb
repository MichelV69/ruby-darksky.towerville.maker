require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

# ---

When ('I provide a Number other than {int} to the getRandomprimary_industry method') do |int|
  @testVar_TableSize = int -1
end

Then('the array I am returned shoud include the rollIndex, the summary_desc and the broad_desc') do
  rows_primary_industry = @all_tables[:primary_industry]

  1.upto(@testVar_TableSize) do | ptr |
		@subject.primary_industry_index = ptr
    @method_output = @subject.text_block_for_primary_industry_index

    columns = {}
    columns[1] = rows_primary_industry[ptr]["summary_desc"]
    columns[2] = rows_primary_industry[ptr]["broad_desc"]

    expect(@method_output["summary_desc".to_sym]).to		eq(columns[1])
    expect(@method_output["broad_desc".to_sym]).to  		eq(columns[2])
  end
end

Then('the summary_desc & broad_desc should contain {string}') do |string|
  expect(@method_output["broad_desc".to_sym]).to    include(string)
end

Then('the Base Class should respond to {string}') do |string|
  Towerville2056.respond_to? string.to_sym
end

Then('correctly set the Primary Industry') do
  @subject.primary_industry_index = Towerville2056.random_primary_industry_index()
  expect(@subject.primary_industry_index).not_to eq(-1)
end

# --- end of file ---
