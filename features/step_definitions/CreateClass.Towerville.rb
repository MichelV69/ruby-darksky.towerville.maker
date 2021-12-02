require "rspec/expectations"
require_relative('../../app.classes.rb')

def assert_cucumber(assersion, msg = "an error was thrown")
  assert(assersion == true, msg)
end

Given('that create a new instance of Towerville2056') do
  @object_instance  = Towerville2056.new
end

Then('initialize should run') do
  assert_cucumber(@object_instance.name.include?("this is wrong"))
end

# --- end of file ---
