# --- # ---
class StoryTools
  def self.get_character_gender_by_age_category(age_category)
    case age_category.to_lower
    when "teen"
      case 1.d10
      when 1..4
        "masc"
      when 5..7
        "femme"
      when 8
        case 1.d6
        when 1..4
          "andro femme"
        when 5..6
          "andro masc"
        end
      when 9..10
        "fluid"
      end
    end
  end
end # class StoryTools

# --- # ---
class AppConfig
  require('psych')
  CONFIG_FILENAME = "config.yaml"
  CONFIG_OPTION_SETS = Psych.load_file(CONFIG_FILENAME)[:wolfstar_studios]

  attr_accessor :config_option_sets_count, :general_options

  def initialize(args = {})
    self.config_option_sets_count = CONFIG_OPTION_SETS.count
    self.general_options = CONFIG_OPTION_SETS[:general]
  end

  def get_options_for(category, args = {})
    options_for = CONFIG_OPTION_SETS[category.to_sym]
    if args[:sub_category]
      options_for = CONFIG_OPTION_SETS[category.to_sym][args[:sub_category].to_sym]
    end
    return options_for
  end
end #class AppConfig

# --- # ---
class DiceStrings
  def self.parse(to_parse, args={})
    output_string = to_parse

    dice_command = {}
    dice_command[:start] = "[roll:"
    dice_command[:stop]  = "]"

    delimiters = ["and",',','.']
    phrases = {}
    phrases = to_parse.split(Regexp.union(delimiters))
      .select{|x| x.contains? dice_command[:start]}
    phrases.each do |phrase|
      if phrase.contains? dice_command[:start]
        # isolate the roll syntax
        roll_text = phrase.split(dice_command[:start])
        .last
        .split(dice_command[:stop])
        .first
        # now handle compound roll requests
        delimiters = ['+']
        roll_total_for_phrase = 0
        roll_text.split(Regexp.union(delimiters)).each do |roll_to_eval|
          roll_total_for_phrase += eval(roll_to_eval.gsub("d",".d"))
        end
        # now replace the roll syntax in the original String
        output_string.gsub!("#{dice_command[:start]}#{roll_text}#{dice_command[:stop]}", roll_total_for_phrase.to_s)
      end
    end
    return output_string
  end # def parse_string
end # class DiceString

# --- # ---
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
	def to_lower
		self.downcase
	end
  def contains?(test)
    self.include?(test)
  end
end

# --- # ---
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

  def less_than?(test)
    self < test
  end

  def greater_than?(test)
    self > test
  end

  def to_s_formated(spacer = ' ')
    self.to_s.gsub(/\B(?=(...)*\b)/, spacer)
  end
end

# --- # ---
class	Float
	def halved
		self * 1.00/2.00
	end

  def half
    self.halved
  end

	def two_thirds
		self * 2.00/3.00
	end

	def round_up(bar=2)
		self.ceil(bar)
	end

  def round_down(bar=2)
		self.floor(bar)
	end

  def round_to_nearest_5
    return self if self % 5 == 0
    rounded = self.round(-1)
    rounded > self ? rounded : rounded + 5
  end

  def percent
    self / 100.0000
  end # def percent

  def to_s_formated(spacer = ' ')
    self.to_s.gsub(/\B(?=(...)*\b)/, spacer)
  end
end

# --- # ---
class Fixnum
  def billion
    self * 1000000000
  end # def billion

  def million
    self * 1000000
  end # def billion

  def percent
    (self / 100.0000).to_f
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

  def d(dice_sides, args={})
    workTotal = 0
    loop_tick = 0
    number_rolls_needed = self

    dev_msg "exploded dice: requested" if args[:ex]

    while loop_tick < number_rolls_needed do
      loop_tick = loop_tick +1
      this_roll = rand(dice_sides) +1
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

  def d100(args = {ex: false, cap: :no})
    self.d(100, args)
  end # def d100

  def d20(args = {ex: false, cap: :no})
    self.d(20, args)
  end # def d10

  def d10(args = {ex: false, cap: :no})
    self.d(10, args)
  end # def d10

  def d8(args = {ex: false, cap: :no})
    self.d(8, args)
  end # def d6

  def d6(args = {ex: false, cap: :no})
    self.d(6, args)
  end # def d6

  def d4(args = {ex: false, cap: :no})
    self.d(4, args)
  end # def d4
end # class Fixnum

# --- # ---
class Array
  def debug
    " >> "+self.to_s
  end
end

# --- # ---
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
def least_of(first, second)

	if first < second then
		return first
	else
		return second
	end # if first, second
end # def leastof(first, second)

# ---
def most_of(first, second)

	if first > second then
		return first
	else
		return second
	end # if first, second
end # def leastof(first, second)

# ---
def half_of(a_number)
  a_number.to_f.halved
end

# ---
def dev_msg(message)
  puts " DEV NOTE >> "+message.to_s if (!ENV["RUBY_ENV"].nil? && ENV["RUBY_ENV"].contains?("dev"))
end

# ---
def signi2(to_round)
  up_value = to_round.to_f*100.00
  round_value = up_value.round
  down_value = round_value/100.00
  return down_value.to_f
end

# ---
def roll_and_explode(dice_string, args = {cap: -1})
  return "Function Deprecated"
end

# ---
def spaces(number_of = 4)
  spaces = ""
  number_of.times do spaces = spaces + " " end
  return spaces
end

# ---
def word_wrap_this(text, args={})
  page_width = 80
  page_width = args[:at] unless args[:at].nil?
  column = 0
  default_margin = (page_width * 0.1).round_up(0)

  while column + page_width < text.size
    search_from = column + page_width - default_margin
    found_at = text.slice(search_from, default_margin).index(" ")
    while found_at.nil?
      search_from -= 2
      found_at = text.slice(search_from, default_margin).index(' ')
      stop if search_from < 1
    end
    column_break = search_from + found_at
    puts "#{text.slice(column, column_break - column)}"
    column = column_break
  end
  puts "#{text.slice(column, text.size - column)}"
end

# --- end of file ---
