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
tv.howManyFloors = Towerville2056::getRandomFloorCount({force: :min})
puts "min houses for #{tv.howManyFloors} is #{tv.getNumberOfHomesEstimate} w/ SQRT #{Math.sqrt(tv.getNumberOfHomesEstimate)}"

tv.howManyFloors = Towerville2056::getRandomFloorCount({force: :avg})
puts "avg houses for #{tv.howManyFloors} is #{tv.getNumberOfHomesEstimate} w/ SQRT #{Math.sqrt(tv.getNumberOfHomesEstimate)}"

tv.howManyFloors = Towerville2056::getRandomFloorCount({force: :max})
puts "max houses for #{tv.howManyFloors} is #{tv.getNumberOfHomesEstimate} w/ SQRT #{Math.sqrt(tv.getNumberOfHomesEstimate)}"

puts title_line "Economic Scale Curve Test"
stat_analysis = Hash.new

tv = Towerville2056.new
tv.name = "Testing Tower"
putc "!>"
1.upto(7) do |tens|
  1.upto(7) do |ones|
    putc "+"

    26.upto(100) do |howManyFloors|
      151.upto(1515) do |primaryEmployerScale|
        tv.primaryIndustryIndex = tens * 10 + ones
        tv.howManyFloors = howManyFloors
        tv.primaryEmployerScale = primaryEmployerScale
        primaryEconomicRating = tv.getPrimaryEconomicRating

        unless stat_analysis[primaryEconomicRating].nil?
          stat_analysis[primaryEconomicRating] += 1
        else
          stat_analysis[primaryEconomicRating] = 1
        end

      end
    end
  end
end
puts "<* DONE"

puts "PER Index, Significance"
stat_analysis.each { |index,value|
  index = 0 if index.nil?
  value = 0 if value.nil?
  puts "%02d,%02d" % [index,value]
  }

# ----- end of file -----
