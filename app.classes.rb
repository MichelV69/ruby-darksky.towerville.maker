class Towerville2056
  TABLE_FILENAME = "tables.randomTowerville.yaml"
  TABLE_CONTENT_SETS = Psych.load_file(TABLE_FILENAME)

  attr_accessor :tables_count, :name, :primaryIndustry, :howManyFloors, :buildingProfile

  def initialize(args = {})
    self.tables_count = TABLE_CONTENT_SETS.count
    self.name = "example"
    self.primaryIndustry = "undefined"
    self.howManyFloors = -1
    self.buildingProfile = {:bottom => "unset", :middle => "unset",
			:crown => "unset", :crown_cap => "unset"}
  end

  # ---
  def getPopulationEstimate()
    "TO DO"
  end

  # ---
  def getBuildingHeight()
    self.howManyFloors * 3.5
  end

  # ---
  def self.getRandomFloorCount()
    return 4.d10+2.d20+20
  end

  def self.getRandomBuildingProfile(section)
    tableColumn = "unset"
    tableData = TABLE_CONTENT_SETS[:BuildingShape][section]

		cap_by_section = {}
		cap_by_section[:bottom] = 18
		cap_by_section[:middle] = 24
		cap_by_section[:crown] = 12

		tableColumn = {}
		unless section == :crown_cap
			tableColumn = tableData[roll_and_explode("1.d6", {cap: cap_by_section[section]})]
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
# ---
