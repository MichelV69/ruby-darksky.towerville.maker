# --- # ---
require('psych')

class Towerville2056
  TABLE_FILENAME = "tables.randomTowerville.yaml"
  TABLE_CONTENT_SETS = Psych.load_file(TABLE_FILENAME)

  attr_accessor :tables_count,
    :construction_rules, :economy_rules,
    :name, :howManyFloors, :buildingProfile,
    :primaryIndustryIndex, :primaryEmployerScale,
    :shopCountVariancePercent, :socialSpacesVariancePercent

  def initialize(args = {})
    self.tables_count = TABLE_CONTENT_SETS.count
    self.name = "example"
    self.primaryIndustryIndex = -1
    self.howManyFloors = -1
    self.buildingProfile = {:bottom => "unset", :middle => "unset",
			:crown => "unset", :crown_cap => "unset"}
    self.primaryEmployerScale = -1
    self.shopCountVariancePercent = -111
    self.socialSpacesVariancePercent = -111

		self.construction_rules = {}
		self.construction_rules[:story_height_in_m] = 3.5
		self.construction_rules[:efficiency_of_design] = 0.70
		self.construction_rules[:home_volume_in_m3] = 700
    self.construction_rules[:people_per_home] = 3.5
		self.construction_rules[:shops_per_person] = 7700.0/1906865.0 # Montreal 7700 retail stores for 1,906,865 people

    sixty_stories_single_floor_area = 14700
    floor_count_per_sixty_stories   = 44
    self.construction_rules[:base_area_social_space_fraction] = (sixty_stories_single_floor_area / floor_count_per_sixty_stories)
    self.construction_rules[:social_space_size_msq] = self.construction_rules[:home_volume_in_m3] * 1.77

    self.economy_rules = {}
		self.economy_rules[:worker_annual_salary_in_nafta] = 35000
  end

# ---
  def getSocialSpacesData
    socialSpacesData = {} if self.socialSpacesVariancePercent != -111
    socialSpacesData.default = -1.1

    change_modifier = 1 + self.socialSpacesVariancePercent.percent

    socialSpacesData[:social_space_total_msq] = change_modifier * self.construction_rules[:base_area_social_space_fraction] * self.howManyFloors
    socialSpacesData[:social_space_size_msq] = change_modifier * self.construction_rules[:social_space_size_msq]

    return socialSpacesData
  end

# ---
  def getSocialSpaces_as_Text
    socialSpacesData = {}
    socialSpacesData = self.getSocialSpacesData

    socialSpacesData[:floors_used] = socialSpacesData[:social_space_total_msq] / self.getBuildingFootPrint[:sq]

    socialSpacesData[:number_of_spaces] = socialSpacesData[:social_space_total_msq] / socialSpacesData[:social_space_size_msq]

    "#{socialSpacesData[:number_of_spaces].round_to_nearest_5} or so #{socialSpacesData[:social_space_size_msq].round_to_nearest_5}m.sq spaces, totaling #{socialSpacesData[:social_space_total_msq].round_to_nearest_5}m.sq over #{socialSpacesData[:floors_used].round_up(0)} floors"
  end

# ---
  def getBuildingFootPrint
    building_in_m = {}
		building_in_m[:height]	= self.getBuildingHeight()
		building_in_m[:width]		= building_in_m[:height].half.round(1)
		building_in_m[:depth]		= building_in_m[:width].two_thirds.round(1)
    building_in_m[:sq]      = (building_in_m[:width] * building_in_m[:depth]).round(1)
    return building_in_m
  end
# ---
  def getBuildingFootPrint_as_Text
    building_in_m = self.getBuildingFootPrint

    "#{building_in_m[:width]}m by #{building_in_m[:depth]}m, totalling #{building_in_m[:sq]}m.sq"
  end

# ---
  def self.get_random_variance_by_primary_economic_rating(primaryEconomicRating)
    dieMod = -14.0 + (primaryEconomicRating/500.0 - 9.0)
    return (4.d6 + dieMod)
  end

# ---
  def getShopCountEstimate
    ((self.getPopulationEstimate * self.construction_rules[:shops_per_person]) * (1.0 + self.shopCountVariancePercent.percent))
    .round(0) if self.shopCountVariancePercent != -111
  end

# ---
  def getPrimaryEconomicRating_as_Text()
    per_text ="undefined"

    primaryEconomicRatingTable = TABLE_CONTENT_SETS[:primaryEconomicRatingScale].select {|minimum_roll, desc| minimum_roll != :dice_rule}

    primaryEconomicRatingTable.each do |minimum_roll, desc|
      per_text = desc if self.getPrimaryEconomicRating >= minimum_roll
    end
    return per_text.gsub("!e", "economy").gsub("\w", "with")
  end

# ---
  def getPrimaryEconomicRating()
    primaryEconomicRating = -1
    unless (self.primaryIndustryIndex == -1 ||
      self.howManyFloors == -1 ||
      self.primaryEmployerScale == -1)

      spare_tv = Towerville2056.new

      pii_value = self.primaryIndustryIndex
      if self.primaryIndustryIndex.to_s.size == 2
        first_industry = self.primaryEmployerScale % 10
        second_industry = self.primaryEmployerScale / 10
        pes_value = first_industry + second_industry
      end

      pes_value = self.primaryEmployerScale
      if self.primaryEmployerScale.to_s.size > 2
        first_industry = self.primaryEmployerScale % 100
        second_industry = self.primaryEmployerScale / 100
        pes_value = first_industry + second_industry
      end
      nohs_value = Math.sqrt(self.getNumberOfHomesEstimate).to_f.round

      pii_pes_relevance_scalar = 4
      primaryEconomicRating =  (pii_value + pes_value) * pii_pes_relevance_scalar + nohs_value
    end

    dbz_scalar =  9000.0/624.0 # 14.42
    return (primaryEconomicRating > 0 ? (primaryEconomicRating * dbz_scalar).round : primaryEconomicRating)
  end

# ---
  def self.getRandomPrimaryEmployerScale()
    max_value = TABLE_CONTENT_SETS[:PrimaryEmployerScale].last.first
    roll_string = TABLE_CONTENT_SETS[:PrimaryEmployerScale][:dice_rule].gsub("}",", cap: #{max_value}}")
    return eval(roll_string)
  end

# ---
	def getprimaryEmployerScale_as_text
    TABLE_CONTENT_SETS[:PrimaryEmployerScale][self.primaryEmployerScale] || "undefined"
	end

# ---
  def getPopulationEstimate()
		estimated_population = self.getNumberOfHomesEstimate * self.construction_rules[:people_per_home]

		return estimated_population.round_up().to_i
  end

	# ---
	def getNumberOfHomesEstimate()
		building_in_m = self.getBuildingFootPrint

		functional_volume_in_m3	= building_in_m[:height] * building_in_m[:sq] * self.construction_rules[:efficiency_of_design]

		number_of_homes 	= functional_volume_in_m3 / self.construction_rules[:home_volume_in_m3]

		return number_of_homes.round_up(0).to_i
	end

  # ---
  def getBuildingHeight()
    return self.howManyFloors * self.construction_rules[:story_height_in_m]
  end

  # ---
  def self.getRandomFloorCount(args = {})
    tens = 4
    twentys = 2
    const = 20

    return tens+twentys+const if args[:force] == :min
    return (tens*5.5+twentys*11+const).round if args[:force] == :avg
    return tens*10+twentys*20+const if args[:force] == :max
    return tens.d10+twentys.d20+const
  end

	# ---
  def self.getRandomBuildingProfile(section, args={})
    tableColumn = "unset"
    tableData = TABLE_CONTENT_SETS[:BuildingShape][section]

		cap_by_section = {}
		cap_by_section[:bottom] = 18
		cap_by_section[:middle] = 24
		cap_by_section[:crown] = 12

		tableColumn = {}
		unless section == :crown_cap
      unless ! args[:get_row_value].nil?
        tableColumn = tableData[1.d6({ex: true, cap: cap_by_section[section]})]
      else
        tableColumn = tableData[args[:get_row_value]]
      end
		else
			percent_lower_has_cap = 70
			ptr_1 = 1.d100
			unless ptr_1 <= percent_lower_has_cap
				tableColumn = "(none)"
			else
				how_tall = 1.d4 + 1.d6
				tableColumn = "The 'Crown' is capped with forest of RF antennas, microwave link dishes, aircraft warning lights, weather sensors, cameras, and even very short range anti-aircraft systems. Additionally, there will heavy cables, struts, hatches, ladders and scaffolding to allow access and maintenance to all that hardware.  The 'Crown Forest' unofficially increases the height of the building another #{how_tall} stories."
			end
		end

    if tableColumn.downcase.include? "pillars"
      text_to_insert = DiceStrings.parse TABLE_CONTENT_SETS[:BuildingShape][:supporting_info]["pillar_blurb"]
      tableColumn = "#{tableColumn} (#{text_to_insert})"
    end

    return tableColumn
  end

  # ---
  def self.getRandomPrimaryIndustryIndex()
		roll_result = 0

		end_of_table = TABLE_CONTENT_SETS[:PrimaryIndustry].last.first
		max_value = end_of_table
    roll_string = TABLE_CONTENT_SETS[:PrimaryIndustry][:dice_rule].gsub("}",", cap: #{max_value}}")

    roll_result =  eval(roll_string)
		roll_result_10x = 0
    if roll_result == end_of_table then
			max_value = end_of_table - 1
			roll_string = TABLE_CONTENT_SETS[:PrimaryIndustry][:dice_rule].gsub("}",", cap: #{max_value}}")

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

  def getPrimaryIndustry_as_text()
    # RandomPrimaryIndustryIndex
    # each digit is a different Industry
    # 26 would be three industries, indexes of 2 & 6.

		table_col_1 = ""
    table_col_2 = ""
    primaryIndustryTable = TABLE_CONTENT_SETS[:PrimaryIndustry]

		0.upto(self.primaryIndustryIndex.to_s.length - 1) do |pi_ptr|
			row_pointer = self.primaryIndustryIndex.to_s[pi_ptr].to_i
			table_row = primaryIndustryTable[row_pointer]

			if pi_ptr !=  0 then
				table_col_1 = table_col_1 + " | "
				table_col_2 = table_col_2 + " | "
			end

			table_col_1 = table_col_1 + table_row["summaryDesc"]
      table_col_2 = table_col_2 + table_row["broadDesc"]
		end # if index == 2

    return {summaryDesc: table_col_1, broadDesc: table_col_2}
  end # 1.upto

end # class Towerville2056
# --- end of file ---
