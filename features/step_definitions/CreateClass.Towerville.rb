require "rspec/expectations"
require_relative('../../app.classes.rb')

def assert_cucumber(assersion, msg = "an error was thrown")
  assert(assersion == true, msg)
end

Given('that create a new instance of Towerville2056') do
  @object_instance  = Towerville2056.new
end

Then('initialize should run') do
  is_false = false
  expect(is_false).to be(true)
end

# --- end of file ---
