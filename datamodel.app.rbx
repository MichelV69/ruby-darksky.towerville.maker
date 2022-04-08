#! env ruby
# presumes cucumber –init // for Testing
require_relative('lib.wolfstar_studios.rb')
require_relative('class.Towerville2056.rb')
#require_relative('class.ExternalRandom.rb')

def dashbar
  result = ""
  5.times {result += '-'}
  "#{result}"
end

def title_line(title = "+++")
  title_output = "#{dashbar} #{title} #{dashbar}"
  space_bar_size = ((78 - title_output.length)/2).round
  if space_bar_size < 0
    space_bar_size = 0
  end
  space_bar = ""
  space_bar_size.times {space_bar += " "}
  "\n#{space_bar} #{title_output} #{space_bar}\n"
end

puts title_line "Dice String Parse Test"
example_string = "This is a test paragraph with three rolls in it. The first is 2d6+3:>[roll:2d6+1]< and the second is 3d8-2:>[roll:3d8-2]<.  The last is a weirdo of 4d6+3d4-99:>[roll:4d6+3d4-99]<"

puts "Finished result > '#{DiceStrings.parse example_string}'"

puts title_line "height to housing check"
tv = Towerville2056.new
tv.number_of_floors = Towerville2056::get_random_floor_count({force: :min})
puts "min houses for #{tv.number_of_floors} is #{tv.get_number_of_homes_estimate} w/ SQRT #{Math.sqrt(tv.get_number_of_homes_estimate)}"

tv.number_of_floors = Towerville2056::get_random_floor_count({force: :avg})
puts "avg houses for #{tv.number_of_floors} is #{tv.get_number_of_homes_estimate} w/ SQRT #{Math.sqrt(tv.get_number_of_homes_estimate)}"

tv.number_of_floors = Towerville2056::get_random_floor_count({force: :max})
puts "max houses for #{tv.number_of_floors} is #{tv.get_number_of_homes_estimate} w/ SQRT #{Math.sqrt(tv.get_number_of_homes_estimate)}"

puts title_line "Economic Scale Curve Test"
stat_analysis = Hash.new
stat_analysis.default = 0

tv = Towerville2056.new
tv.name = "Testing Tower"
putc "!>"
pii_tens = 0
pes_tens = 0
#0.upto(7) do |pii_tens|
  1.upto(7) do |pii_ones|
    putc "+"
    primary_industry_index = "#{pii_tens}#{pii_ones}".to_i
#    0.upto(6) do |pes_tens|
      1.upto(6) do |pes_ones|
        primary_employer_scale = "#{pes_tens}#{pes_ones}".to_i
        26.upto(100) do |number_of_floors|
          tv.primary_industry_index = primary_industry_index
          tv.primary_employer_scale = primary_employer_scale
          tv.number_of_floors = number_of_floors
          pER = tv.primary_economic_rating
          stat_analysis[pER].nil? ? stat_analysis[pER] = 1 : stat_analysis[pER] += 1
      end
    end
#    end
  end
#end
puts "<* DONE"

puts "PER Index, Significance"
stat_analysis.each { |index,value|
  index = 0 if index.nil?
  value = 0 if value.nil?
  puts "%02d,%02d" % [index,value]
  }

# ----- end of file -----
