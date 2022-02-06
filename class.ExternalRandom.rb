# --- # ---
class Fixnum
  def d(dice_sides, args={})
    workTotal = 0
    loop_tick = 0
    number_rolls_needed = self

    dev_msg "exploded dice: requested" if args[:ex]

    while loop_tick < number_rolls_needed do
      loop_tick = loop_tick +1
      this_roll = ExternalRandom.get(dice_sides)+1
      workTotal += this_roll
      if (args[:ex] && this_roll.modulo(dice_sides) == 0 )
        dev_msg "exploded dice:  number_rolls_needed was #{number_rolls_needed}"
        number_rolls_needed += 1
        dev_msg "exploded dice:  number_rolls_needed is now #{number_rolls_needed}"
        end
      end # do

    unless (args[:cap].nil? || args[:cap] == :no)
      if workTotal > args[:cap]
        workTotal = args[:cap]
        end
      end

    return workTotal
  end


end # class Fixnum

# --- # ---
class	ExternalRandom
	require 'random_org_http_api'
	@rand_max=10000

	def self.get(max)
    putc ">" if (!ENV["RUBY_ENV"].nil? && ENV["RUBY_ENV"].contains?("dev"))
		rg = RandomOrgHttpApi::Generator.new

    putc ">" if (!ENV["RUBY_ENV"].nil? && ENV["RUBY_ENV"].contains?("dev"))
		ten_thousand = rg.generate_integers(num: 1, max: @rand_max)

    putc "<" if (!ENV["RUBY_ENV"].nil? && ENV["RUBY_ENV"].contains?("dev"))
    result = ((ten_thousand.first.to_f / @rand_max.to_f ) * max).to_i

    puts "!" if (!ENV["RUBY_ENV"].nil? && ENV["RUBY_ENV"].contains?("dev"))
		return result
	end
end # class ExternalRandom
# --- end of file ---
