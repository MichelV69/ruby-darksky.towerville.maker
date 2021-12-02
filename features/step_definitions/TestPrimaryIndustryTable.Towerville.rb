Given('that I provide a Number to the getPrimaryIndustry method') do
  @testVar_TableSize = 1
end

Then('the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc') do |table|
  # table is a Cucumber::MultilineArgument::DataTable

  1.upto(@testVar_TableSize) do | ptr |
    header_row = table.raw[0]
    data_row = table.raw[ptr]
    method_output = @subject::getPrimaryIndustry(ptr)

    table_row_headings = []
    table_row_headings = header_row.each do |heading|
      table_row_headings.push(heading)
    end

    debug_output("data_row:"+data_row.debug)
    debug_output("table_row_headings:"+table_row_headings.debug)
    debug_output("method_output:"+method_output.debug)

    index=0
    table_row_headings.each_entry do |column_data|
      debug_output(method_output[column_data.to_sym])

      table_cell = data_row[index]
      expect(method_output[column_data.to_sym]).to eq(table_cell)
      index=index+1
    end
  end

end
