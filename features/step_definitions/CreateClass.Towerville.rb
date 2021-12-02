require "rspec/expectations"
require_relative('../../app.classes.rb')

@output_trap = ""

Given('that I run the app') do
  @output_trap = This is test output"
end

Then('I should see {string}') do |string|
  @output_trap.contains(string)
end
