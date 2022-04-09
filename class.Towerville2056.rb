# --- # ---
require('psych')
require_relative('lib.wolfstar_studios.rb')

class Towerville2056
  TABLE_FILENAME = "tables.randomTowerville.yaml"
  TABLE_CONTENT_SETS = Psych.load_file(TABLE_FILENAME)

  attr_accessor :tables_count,
    :construction_rules, :economy_rules,
    :name, :number_of_floors, :building_profile,
    :primary_industry_index, :primary_employer_scale,
    :shop_count_variance_percent,
    :social_spaces_variance_percent, :green_spaces_variance_percent

  def initialize(args = {})
    self.tables_count = TABLE_CONTENT_SETS.count

    # ---
    self.construction_rules = {}
		self.construction_rules[:story_height_in_m] = 3.5
		self.construction_rules[:efficiency_of_design] = 0.70
		self.construction_rules[:home_volume_in_m3] = 700
    self.construction_rules[:people_per_home] = 3.5
    self.construction_rules[:ground_floors_cap] = 12
    montreal_retail_stores = 7700.0
    montreal_city_population = 1906865.0
		self.construction_rules[:shops_per_person] = montreal_retail_stores / montreal_city_population

    social_floor_count_per_sixty_stories  = 44
    sixty_stories_single_floor_area = 14700
    arbitrary_house_to_social_ratio = 1.77
    arbitrary_social_to_green_ratio = 1.0 / 1.67

    self.construction_rules[:base_area_social_space_fraction] = (sixty_stories_single_floor_area / social_floor_count_per_sixty_stories)
    self.construction_rules[:social_space_size_ea_msq] = self.construction_rules[:home_volume_in_m3] * arbitrary_house_to_social_ratio

    self.construction_rules[:base_area_green_space_fraction] = self.construction_rules[:base_area_social_space_fraction] * arbitrary_social_to_green_ratio
    self.construction_rules[:green_space_size_ea_msq] = self.construction_rules[:social_space_size_ea_msq] * arbitrary_house_to_social_ratio

    # ---
    self.economy_rules = {}
		self.economy_rules[:worker_annual_salary_in_nafta] = 35000

    # ---
    self.name = "example"
    self.primary_industry_index = -1
    self.number_of_floors = -1

    unset =  {unset: ['unset',-13]}
    self.building_profile = {:basement => unset,
      :ground_floors => unset, :ground_to_f22 => unset,
      :f23_to_middle  => unset, :middle_to_crown => unset,
			:crown => unset, :crown_cap => unset}

    self.primary_employer_scale = -1
    self.shop_count_variance_percent    = 0.0
    self.social_spaces_variance_percent = 0.0
    self.green_spaces_variance_percent  = 0.0

  end # def initialize

# ---
  def green_spaces_data
    green_spaces_data = {}
    green_spaces_data.default = -1.1

    change_modifier = 1 + self.green_spaces_variance_percent.percent

    green_spaces_data[:total_msq] = change_modifier * self.construction_rules[:base_area_green_space_fraction] * self.number_of_floors
    green_spaces_data[:size_ea_msq] = change_modifier * self.construction_rules[:green_space_size_ea_msq]

    return green_spaces_data
  end

# ---
  def social_spaces_data
    social_spaces_data = {}
    social_spaces_data.default = -1.1

    change_modifier = 1 + self.social_spaces_variance_percent.percent

    social_spaces_data[:total_msq] = change_modifier * self.construction_rules[:base_area_social_space_fraction] * self.number_of_floors
    social_spaces_data[:size_ea_msq] = change_modifier * self.construction_rules[:social_space_size_ea_msq]

    return social_spaces_data
  end

# ---
  def building_foot_print
    building_in_m = {}
		building_in_m[:height]	= self.building_height()
		building_in_m[:width]		= building_in_m[:height].half.round(1)
		building_in_m[:depth]		= building_in_m[:width].two_thirds.round(1)
    building_in_m[:sq]      = (building_in_m[:width] * building_in_m[:depth]).round(1)
    return building_in_m
  end

# ---
  def self.random_variance_by_primary_economic_rating(primary_economic_rating)
    dieMod = -14.0 + (primary_economic_rating/500.0 - 9.0)
    return (4.d6 + dieMod)
  end

# ---
  def shop_count_estimate
    ((self.population_estimate * self.construction_rules[:shops_per_person]) * (1.0 + self.shop_count_variance_percent.percent))
    .round(0) if self.shop_count_variance_percent != -111
  end

# ---
  def primary_economic_rating()
    primary_economic_rating = -1
    unless (self.primary_industry_index == -1 ||
      self.number_of_floors == -1 ||
      self.primary_employer_scale == -1)

      spare_tv = Towerville2056.new

      pii_value = self.primary_industry_index
      if self.primary_industry_index.to_s.size == 2
        first_industry = self.primary_employer_scale % 10
        second_industry = self.primary_employer_scale / 10
        pes_value = first_industry + second_industry
      end

      pes_value = self.primary_employer_scale
      if self.primary_employer_scale.to_s.size > 2
        first_industry = self.primary_employer_scale % 100
        second_industry = self.primary_employer_scale / 100
        pes_value = first_industry + second_industry
      end
      nohs_value = Math.sqrt(self.number_of_homes_estimate).to_f.round

      pii_pes_relevance_scalar = 4
      primary_economic_rating =  (pii_value + pes_value) * pii_pes_relevance_scalar + nohs_value
    end

    dbz_scalar =  9000.0/624.0 # 14.42
    return (primary_economic_rating > 0 ? (primary_economic_rating * dbz_scalar).round : primary_economic_rating)
  end

# ---
  def self.random_primary_employer_scale()
    max_value = TABLE_CONTENT_SETS[:primary_employer_scale].last.first
    roll_string = TABLE_CONTENT_SETS[:primary_employer_scale][:dice_rule].gsub("}",", cap: #{max_value}}")
    return eval(roll_string)
  end

# ---
  def population_estimate()
		estimated_population = self.number_of_homes_estimate * self.construction_rules[:people_per_home]

		return estimated_population.round_up().to_i
  end

	# ---
	def number_of_homes_estimate()
		building_in_m = self.building_foot_print

		functional_volume_in_m3	= building_in_m[:height] * building_in_m[:sq] * self.construction_rules[:efficiency_of_design]

		number_of_homes 	= functional_volume_in_m3 / self.construction_rules[:home_volume_in_m3]

		return number_of_homes.round_up(0).to_i
	end

  # ---
  def building_height()
    return self.number_of_floors * self.construction_rules[:story_height_in_m]
  end

  # ---
  def self.random_floor_count(args = {})
    tens = 4
    twentys = 2
    const = 20

    return tens+twentys+const if args[:force] == :min
    return (tens*5.5+twentys*11+const).round if args[:force] == :avg
    return tens*10+twentys*20+const if args[:force] == :max
    return tens.d10+twentys.d20+const
  end

	# ---
  def self.random_building_profile(section_requested, tv_object, args={})

    section_requested = section_requested.to_s.to_lower.gsub(' ','_').to_sym if section_requested.class != :example.class

    basement_depth = lambda do |tv_object|
      (tv_object.number_of_floors * 5.percent * -1.0).round
    end

    ground_floors_capped_height = lambda do |tv_object|
      gfc = tv_object.construction_rules[:ground_floors_cap]
      last_floor = (tv_object.number_of_floors * 12.percent).round
      last_floor < gfc ? last_floor : gfc
    end

    crown_height = lambda do |tv_object|
      (tv_object.number_of_floors * 10.percent).round
    end

    crown_first_floor = lambda do |tv_object|
      tv_object.number_of_floors - crown_height.call(tv_object)
    end

    table_column = "unset"
    floors_range = (-2..-5)
    profile_category = "unset"
    die_roll_cap = -1
    skyline_floor = 22

    case section_requested
    when :basement
      profile_category = :bottom
      die_roll_cap = 8

			last_floor = -1
      first_floor =  basement_depth.call(tv_object) + last_floor
      floors_range =  (first_floor..last_floor)

    when :ground_floors
      profile_category = :bottom
      die_roll_cap = 13

      first_floor = 1
      last_floor = ground_floors_capped_height.call(tv_object)
      floors_range = (first_floor..last_floor)

    when :ground_to_f22
      profile_category = :bottom
      die_roll_cap = 18

      first_floor = tv_object.building_profile[:ground_floors].last.last + 1
      last_floor = skyline_floor
      floors_range = (first_floor..last_floor)

    when :f23_to_middle
      profile_category = :middle
      die_roll_cap = 24

      first_floor = skyline_floor + 1
      last_floor = first_floor + half_of(crown_first_floor.call(tv_object) - first_floor).round
      floors_range = (first_floor..last_floor)

    when :middle_to_crown
      profile_category = :middle
      die_roll_cap = 24

      first_floor = tv_object.building_profile[:f23_to_middle].last.last + 1
      last_floor = crown_first_floor.call(tv_object) - 1

      floors_range = (first_floor..last_floor)

    when :crown
      profile_category = :crown
      die_roll_cap = 12

      first_floor = crown_first_floor.call(tv_object)
      last_floor = tv_object.number_of_floors
      floors_range = (first_floor..last_floor)

    when :crown_cap
      profile_category = :crown_cap
      die_roll_cap = -1
      floors_range = (tv_object.number_of_floors+1..tv_object.number_of_floors+2)
    end

    table_data = TABLE_CONTENT_SETS[:building_shape][profile_category]

		unless profile_category == :crown_cap
      if args[:row_value].nil?
        table_column = table_data[1.d6({ex: true, cap: die_roll_cap})]
      else
        table_column = table_data[args[:row_value]]
      end
		else
			percent_lower_has_cap = 70
			ptr_1 = 1.d100
			unless ptr_1 <= percent_lower_has_cap
				table_column = "(none)"
			else
				how_tall = 1.d4 + 1.d6
				table_column = "The 'Crown' is capped with forest of RF antennas, microwave link dishes, aircraft warning lights, weather sensors, cameras, and even very short range anti-aircraft systems. Additionally, there will heavy cables, struts, hatches, ladders and scaffolding to allow access and maintenance to all that hardware.  The 'Crown Forest' unofficially increases the height of the building another #{how_tall} stories."
			end
		end

    if table_column.downcase.include? "pillars"
      text_to_insert = DiceStrings.parse TABLE_CONTENT_SETS[:building_shape][:supporting_info]["pillar_blurb"]
      table_column = "#{table_column} (#{text_to_insert})"
    end

    return [table_column, floors_range]
  end

  # ---
  def self.random_primary_industry_index()
		roll_result = 0

		end_of_table = TABLE_CONTENT_SETS[:primary_industry].last.first
		max_value = end_of_table
    roll_string = TABLE_CONTENT_SETS[:primary_industry][:dice_rule].gsub("}",", cap: #{max_value}}")

    roll_result =  eval(roll_string)
		roll_result_10x = 0
    if roll_result == end_of_table then
			max_value = end_of_table - 1
			roll_string = TABLE_CONTENT_SETS[:primary_industry][:dice_rule].gsub("}",", cap: #{max_value}}")

			1.upto(2) do |pointer|
				roll_result = 0
				roll_result_10x = 0

				if pointer == 1 then
					roll_result =  eval(roll_string)
				else
					roll_result_10x =  10 * eval(roll_string)
				end
			end
			roll_result = roll_result + roll_result_10x
    end
    return roll_result
  end

  # ---
  private
  # ---

  def get_sub_method(method_name)
    puts "get_sub_method >>> [#{method_name.to_s.split('.').last}]"
    method_name.to_s.split(".").last
  end

  def method_missing(method_name, *args, &block)
    if (get_sub_method(method_name).include?("to_desc"))then
      to_desc property_name
    else
      puts "method_missing :>> #{method_name}"
      super
    end
  end # def method_missing

  def respond_to_missing?(method_name, *)
     get_sub_method(method_name).include?("to_desc")|| super
  end # def respond_to_missing?

  # ---
  def to_desc(property_name)
    case property_name.to_sym
      when :green_spaces_data
        self.green_spaces_data[:floors_used] = self.green_spaces_data[:total_msq] / self.building_foot_print[:sq] * 3.0

        self.green_spaces_data[:number_of_spaces] = self.green_spaces_data[:total_msq] / self.green_spaces_data[:size_ea_msq]

        "#{self.green_spaces_data[:number_of_spaces].round} or so #{self.green_spaces_data[:size_ea_msq].round_to_nearest_5.to_s_formated}m.sq spaces, totalling #{self.green_spaces_data[:total_msq].round_to_nearest_5.to_s_formated}m.sq over #{self.green_spaces_data[:floors_used].round_up(0)} floors"
        # ---
      when :building_foot_print
        building_in_m = self.building_foot_print
        "#{building_in_m[:width]}m by #{building_in_m[:depth]}m, totalling #{building_in_m[:sq].round_to_nearest_5.to_i.to_s_formated}m.sq"
        # ---
      when :social_spaces_data
        social_spaces_data = {}
        social_spaces_data = self.social_spaces_data

        social_spaces_data[:floors_used] = social_spaces_data[:total_msq] / self.building_foot_print[:sq]

        social_spaces_data[:number_of_spaces] = social_spaces_data[:total_msq] / social_spaces_data[:size_ea_msq]

        "#{social_spaces_data[:number_of_spaces].round_to_nearest_5} or so #{social_spaces_data[:size_ea_msq].round_to_nearest_5.to_s_formated}m.sq spaces, totalling #{social_spaces_data[:total_msq].round_to_nearest_5.to_s_formated}m.sq over #{social_spaces_data[:floors_used].round_up(0)} floors"
        # ---
      when :primary_economic_rating
        per_text ="undefined"

        table_primary_economic_rating = TABLE_CONTENT_SETS[:primary_economic_rating_scale].select {|minimum_roll, desc| minimum_roll != :dice_rule}

        table_primary_economic_rating.each do |minimum_roll, desc|
          per_text = desc if self.primary_economic_rating >= minimum_roll
        end
        return per_text.gsub("!e", "economy").gsub("\w", "with")
        # ---
      when :primary_employer_scale
        TABLE_CONTENT_SETS[:primary_employer_scale][self.primary_employer_scale] || "undefined"
        # ---
      when :primary_industry_index
        # each digit is a different Industry
        # 26 would be three industries, indexes of 2 & 6.

    		table_col_1 = ""
        table_col_2 = ""
        table_primary_industry = TABLE_CONTENT_SETS[:primary_industry]

    		0.upto(self.primary_industry_index.to_s.length - 1) do |pi_ptr|
    			row_pointer = self.primary_industry_index.to_s[pi_ptr].to_i
    			table_row = table_primary_industry[row_pointer]

    			if pi_ptr !=  0 then
    				table_col_1 = table_col_1 + " | "
    				table_col_2 = table_col_2 + " | "
    			end

    			table_col_1 = table_col_1 + table_row["summary_desc"]
          table_col_2 = table_col_2 + table_row["broad_desc"]
    		end # if index == 2

        return {summary_desc: table_col_1, broad_desc: table_col_2}
        # ---
      end # case
  end #def to_desc
end # class Towerville2056
# --- end of file ---
