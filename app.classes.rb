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
  def self.getPrimaryIndustry(ptr)
    if ptr == 8
      good_rolls = 0
      set_of_results = {}
      until good_rolls == 2
        this_roll = 1.d8
        unless this_roll == 8
          good_rolls = good_rolls+1
          set_of_results[good_rolls] = self.loadFromTablePrimaryIndustry(this_roll)
        end
      end

      r1 = set_of_results.first.last
      r1c1 = r1[:summaryDesc]
      r1c2 = r1[:broadDesc]

      r2 = set_of_results.last.last
      r2c1 = set_of_results[:summaryDesc]
      r2c2 = set_of_results[:broadDesc]

      f1 = "#{r1c1} | #{r2c1}"
      f2 = "#{r1c2} | #{r2c2}"

      {rollIndex: ptr, summaryDesc: f1, broadDesc: f2}

    else
      self.loadFromTablePrimaryIndustry(ptr)
    end
  end

  # ---
  def self.loadFromTablePrimaryIndustry(ptr)
    primaryIndustryTable = TABLE_CONTENT_SETS[:PrimaryIndustry]

    tableRow = primaryIndustryTable[ptr]
    f1 = tableRow["summaryDesc"]
    f2 = tableRow["broadDesc"]
    {rollIndex: ptr, summaryDesc: f1, broadDesc: f2}
  end

  # ---
  def self.getNewFloorCount()
    return 4.d10+2.d20+20
  end

  def self.getRandomBuildingProfile(section)
    debug_output("section requested was |#{section.inspect}|")

    tableData = TABLE_CONTENT_SETS[:BuildingShape][section]
    debug_output("tableData was |#{tableData.inspect}|")

    return "unset"
  end

  # ---
  def self.getRandomPrimaryIndustry()
    self.getPrimaryIndustry(1.d8)
  end
end # class Towerville2056
# ---
