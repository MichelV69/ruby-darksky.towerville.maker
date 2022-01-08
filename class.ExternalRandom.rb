# --- # ---
class Fixnum
  def d(sides)
    workTotal=0
    1.upto(self) do |dicePtr|
      workTotal += ExternalRandom.get(sides)+1
      end # do
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
