Given('that I provide a Number to the getPrimaryIndustry method') do
  @testVar_TableSize = 1
end

Then('the array I am returned shoud include the Number, the SummaryDesc and the BroadDesc') do |table|
  # table is a Cucumber::MultilineArgument::DataTable

  1.upto(@testVar_TableSize) do | ptr |
    expect(@subject::getPrimaryIndustry(ptr)).to eq("example")
  end

end
