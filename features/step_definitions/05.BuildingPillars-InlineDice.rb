require "rspec/expectations"
require_relative('../../lib.wolfstar_studios.rb')
require_relative('../../class.Towerville2056.rb')
require_relative('../../class.ExternalRandom.rb')

# ---

Given('the Description for Pillars includes a random-rolled height') do
  @example_string = "Pillars are [roll:2d4+2] in number and [roll:1d4+1d6+1] stories tall, and leave 50% void space of the foot print."
end

When('a formatted string like {string}') do |simple_dice_string|
  @simple_dice_string = simple_dice_string
end

Then('the dice string should be parsed and replaced with a number') do
  parsed_simple_dice_string = DiceString.parse(@simple_dice_string)
  parsed_example_string     = DiceString.parse(@example_string)

  expect(parsed_simple_dice_string).not_to  eq(@simple_dice_string)
  expect(parsed_example_string).not_to      eq(@example_string)

  expect(parsed_simple_dice_string).not_to  include("[roll:")
  expect(parsed_example_string).not_to      include("[roll:")

  dev_msg(parsed_simple_dice_string)
  dev_msg(parsed_example_string)
end
# --- end of file ---
