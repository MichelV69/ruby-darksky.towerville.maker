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
    @method_output = Towerville2056.getRandomPrimaryIndustry(ptr)

    fields = {}
    fields[1] = ptr
    fields[2] = primaryIndustryTable[ptr]["summaryDesc"]
    fields[3] = primaryIndustryTable[ptr]["broadDesc"]

    expect(@method_output["rollIndex".to_sym]).to    eq(fields[1])
    expect(@method_output["summaryDesc".to_sym]).to  eq(fields[2])
    expect(@method_output["broadDesc".to_sym]).to    eq(fields[3])
  end
end

Then('the summaryDesc & broadDesc should contain {string}') do |string|
  expect(@method_output["broadDesc".to_sym]).to    include(string)
end

Then('the Base Class should respond to {string}') do |string|
  Towerville2056.respond_to? string.to_sym
end

Then('correctly set the Primary Industry') do
  @subject.primaryIndustry = Towerville2056.getRandomPrimaryIndustry()
  expect(@subject.primaryIndustry).not_to eq("undefined")
end

# --- end of file ---
