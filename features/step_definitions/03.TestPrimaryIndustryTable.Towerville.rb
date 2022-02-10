require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

# ---

When ('I provide a Number other than {int} to the getRandomPrimaryIndustry method') do |int|
  @testVar_TableSize = int -1
end

Then('the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc') do
  primaryIndustryTable = @all_tables[:PrimaryIndustry]

  1.upto(@testVar_TableSize) do | ptr |
		puts "#{ptr}"
		@subject.primaryIndustryIndex = ptr
    @method_output = @subject.getPrimaryIndustry_as_text

    fields = {}
    fields[1] = primaryIndustryTable[ptr]["summaryDesc"]
    fields[2] = primaryIndustryTable[ptr]["broadDesc"]

    expect(@method_output["summaryDesc".to_sym]).to		eq(fields[1])
    expect(@method_output["broadDesc".to_sym]).to  		eq(fields[2])
  end
end

Then('the summaryDesc & broadDesc should contain {string}') do |string|
  expect(@method_output["broadDesc".to_sym]).to    include(string)
end

Then('the Base Class should respond to {string}') do |string|
  Towerville2056.respond_to? string.to_sym
end

Then('correctly set the Primary Industry') do
  @subject.primaryIndustryIndex = Towerville2056.getRandomPrimaryIndustryIndex()
  expect(@subject.primaryIndustryIndex).not_to eq(-1)
end

# --- end of file ---
