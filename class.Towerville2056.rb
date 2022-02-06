# --- # ---
require('psych')

class Towerville2056
  TABLE_FILENAME = "tables.randomTowerville.yaml"
  TABLE_CONTENT_SETS = Psych.load_file(TABLE_FILENAME)

  attr_accessor :construction_rules, :tables_count, :name, :primaryIndustry, :howManyFloors, :buildingProfile, :primaryEmployerScale

  def initialize(args = {})
    self.tables_count = TABLE_CONTENT_SETS.count
    self.name = "example"
    self.primaryIndustry = "undefined"
    self.howManyFloors = -1
    self.buildingProfile = {:bottom => "unset", :middle => "unset",
			:crown => "unset", :crown_cap => "unset"}
		self.primaryEmployerScale = -1

		self.construction_rules = {}
		self.construction_rules[:story_height_in_m] = 3.5
		self.construction_rules[:efficiency_of_design] = 0.70
		self.construction_rules[:home_volume_in_m3] = 700
		self.construction_rules[:people_per_home] = 3.5
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
		building_in_m = {}
		building_in_m[:height]	= self.getBuildingHeight()
		building_in_m[:width]		= building_in_m[:height].half
		building_in_m[:depth]		= building_in_m[:width].two_thirds

		functional_volume_in_m3	= building_in_m[:height] * building_in_m[:width] * building_in_m[:depth] * self.construction_rules[:efficiency_of_design]

		number_of_homes 	= functional_volume_in_m3 / self.construction_rules[:home_volume_in_m3]

		return number_of_homes.round_up().to_i
	end

  # ---
  def getBuildingHeight()
    return self.howManyFloors * self.construction_rules[:story_height_in_m]
  end

  # ---
  def self.getRandomFloorCount()
    return 4.d10+2.d20+20
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
				tableColumn = "The 'Crown' is capped with forest of RF antennas, microwave link dishes, aircraft warning lights, weather sensors, cameras, and even very short range anti-aircraft systems. Additionally, there will heavy cables, struts, hatches, ladders and scaffolding to allow access and maintenance to all that hardware.  The 'Cap Forest' unofficially increases the height of the building another #{how_tall} stories."
			end
		end

    if tableColumn.downcase.include? "pillars"
      text_to_insert = DiceStrings.parse TABLE_CONTENT_SETS[:BuildingShape][:supporting_info]["pillar_blurb"]
      tableColumn = "#{tableColumn} (#{text_to_insert})"
    end

    return tableColumn
  end

  # ---
  def self.getRandomPrimaryIndustry(ptr_1 = 0)
		ptr_2 = -1

    if ptr_1 == 0
      ptr_1 = 1.d8
	  end
		if ptr_1 == 8
			while ptr_1 == 8
				ptr_1 = 1.d8
			end
			while ptr_1 == 8 &&
				(ptr_2 == -1 || ptr_2 == 8)
				ptr_2 = 1.d8
			end
		end

    loop_list = Array.new
    loop_list << ptr_1
    unless ptr_2 == -1
      loop_list << ptr_2
    end

    table_col_1 = ""
    table_col_2 = ""
    primaryIndustryTable = TABLE_CONTENT_SETS[:PrimaryIndustry]
    loop_list.compact.each do |list_ptr|
      table_row = primaryIndustryTable[list_ptr]
      if loop_list.count > 1 &&
        list_ptr == loop_list.last
        table_col_1 = table_col_1 + " | "
        table_col_2 = table_col_2 + " | "
      end
      table_col_1 = table_col_1 + table_row["summaryDesc"]
      table_col_2 = table_col_2 + table_row["broadDesc"]
    end

    {rollIndex: ptr_1, summaryDesc: table_col_1, broadDesc: table_col_2}
  end

end # class Towerville2056
# --- end of file ---
