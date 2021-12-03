Given('that I provide a Number to the getPrimaryIndustry method') do
  @testVar_TableSize = 8
end

Then('the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc') do
  primaryIndustryTable = YAML.load_file("tables.randomTowerville.yaml")

  1.upto(@testVar_TableSize) do | ptr |
    method_output = @subject::getPrimaryIndustry(ptr)

    #debug_output("method_output:"+method_output.debug)

    field(1) = primaryIndustryTable[ptr]["rollIndex"]
    field(2) = primaryIndustryTable[ptr]["summaryDesc"]
    field(3) = primaryIndustryTable[ptr]["broadDesc"]

    expect(method_output["rollIndex".to_sym]).to    eq(field(1))
    expect(method_output["summaryDesc".to_sym]).to  eq(field(2))
    expect(method_output["broadDesc".to_sym]).to    eq(field(3))
  end
end
