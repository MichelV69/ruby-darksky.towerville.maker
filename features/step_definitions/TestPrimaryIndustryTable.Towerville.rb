require "rspec/expectations"
require_relative('../../app.classes.rb')
require_relative('../../lib.wolfstar_studios.rb')

# ---

Given('that I provide a Number to the getPrimaryIndustry method') do
  @testVar_TableSize = 8
end

Then('the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc') do
  primaryIndustryTable = YAML.load_file("tables.randomTowerville.yaml")

  1.upto(@testVar_TableSize) do | ptr |
    method_output = @subject::getPrimaryIndustry(ptr)

    fields = {}
    fields[1] = ptr.as_str
    fields[2] = primaryIndustryTable[ptr]["summaryDesc"]
    fields[3] = primaryIndustryTable[ptr]["broadDesc"]

    expect(method_output["rollIndex".to_sym]).to    eq(fields[1])
    expect(method_output["summaryDesc".to_sym]).to  eq(fields[2])
    expect(method_output["broadDesc".to_sym]).to    eq(fields[3])
  end
end

Given('that the number sent to the getPrimaryIndustry method is {string}') do |string|
  @isAnEight = string.as_int
  @primaryIndustryTable = YAML.load_file("tables.randomTowerville.yaml")
  @method_output = @subject::getPrimaryIndustry(@isAnEight)

  expect(@isAnEight).to eq(8)
end

Then('I should not see {string}') do |string|

  fields = {}
  fields[1] = @isAnEight.to_s
  fields[2] = @primaryIndustryTable[@isAnEight]["summaryDesc"]
  fields[3] = @primaryIndustryTable[@isAnEight]["broadDesc"]

  expect(@method_output["rollIndex".to_sym]).to    eq(fields[1])
  expect(@method_output["summaryDesc".to_sym]).not_to  eq(fields[2])
  expect(@method_output["broadDesc".to_sym]).not_to    eq(fields[3])

end

Then('the summaryDesc & broadDesc should contain {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end
