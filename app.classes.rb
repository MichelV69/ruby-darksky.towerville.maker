class Towerville2056
  TABLE_FILENAME = "tables.randomTowerville.yaml"
  TABLE_CONTENT_SETS = Psych.load_file(TABLE_FILENAME)

  attr_accessor :tables_count, :name, :primaryIndustry, :howManyFloors, :buildingProfile

  def initialize(args = {})
    self.tables_count = TABLE_CONTENT_SETS.count
    self.name = "example"
    self.primaryIndustry = "undefined"
    self.howManyFloors = -1
    self.buildingProfile = {:bottom => "unset", :middle => "unset", :top => "unset"}
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
    tableColumn = tableData[roll_and_explode("1.d6", {cap: cap_by_section[section]})]

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
