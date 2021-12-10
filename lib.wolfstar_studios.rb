# ---
class	ExternalRandom
	require 'random_org_http_api'
	@rand_max=10000

	def self.get(max)

		rg = RandomOrgHttpApi::Generator.new
		ten_thousand = rg.generate_integers(num: 1, max: @rand_max)

    result = ((ten_thousand.first.to_f / @rand_max.to_f ) * max).to_i

		debug_output("#{max}|#{ten_thousand}|#{result}")
		return result
	end
end # class Random

# ---
class String
  def is_wrong!
    self  + "-isWrong"
  end
  def debug
    " >> "+self
  end
  def as_int
    self.to_i
  end
end

# ---
class Integer
  def is_wrong!
    self + 2
  end
  def debug
    " >> "+self.to_s
  end
  def as_str
    self.to_s
  end
end

# ---
class Fixnum
  def billion
    self * 1000000000
  end # def billion

  def million
    self * 1000000
  end # def billion

  def percent
    (self / 100).to_f
  end # def percent

  def hex
		case self
			when 10 then return "A"
			when 11 then return "B"
			when 12 then return "C"
			when 13 then return "D"
			when 14 then return "E"
			when 15 then return "F"
			when 16 then return "G"
			when 17 then return "H"
			default
				return self
		end # case self
	end # def hex

  def d100
    workTotal=0
    1.upto(self) do |dicePtr|
      workTotal += ExternalRandom.get(100)+1
      end # do
    return workTotal
  end # def d100

  def d10
    workTotal=0
    1.upto(self) do |dicePtr|
      workTotal += ExternalRandom.get(10)+1
      end # do
    return workTotal
  end # def d10

  def d8
    workTotal=0
    1.upto(self) do |dicePtr|
      workTotal += ExternalRandom.get(8)+1
      end # do
    return workTotal
  end # def d6

  def d6
    workTotal=0
    1.upto(self) do |dicePtr|
      workTotal += ExternalRandom.get(6)+1
      end # do
    return workTotal
  end # def d6

end # class Fixnum


# ---
class Array
  def debug
    " >> "+self.to_s
  end
end

# ---
class Hash
  def last
    last = self.count
    last_key = self.keys[last -1]
    product = Array.new
    product << last_key << self[last_key]
    return product
  end
  def debug
    " >> "+self.inspect
  end
end
# ---
def leastof(first, second)

	if first < second then
		return first
	else
		return second
	end # if first, second
end # def leastof(first, second)

def mostof(first, second)

	if first > second then
		return first
	else
		return second
	end # if first, second
end # def leastof(first, second)

def debug_output(message)
  puts " DEV NOTE >> "+message.to_s
end

def signi2(to_round)
  up_value = to_round.to_f*100.00
  round_value = up_value.round
  down_value = round_value/100.00
  return down_value.to_f
end
# ---
