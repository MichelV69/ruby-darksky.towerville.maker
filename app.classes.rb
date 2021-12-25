
class Towerville2056
  attr_accessor :name, :primaryIndustry, :howManyFloors, :buildingProfile, :table_content_sets
  TABLE_FILENAME = "tables.randomTowerville.yaml"

  def initialize(args = {})
    self.table_content_sets == {}
    load_table_content_sets()

    self.name = "example"
    self.primaryIndustry = "undefined"
    self.howManyFloors = -1
    self.buildingProfile = {:bottom => "unset", :middle => "unset", :top => "unset"}
  end

  # ---
  def load_table_content_sets()
    debug_output("load_table_content_sets")
    unless self.table_content_sets
      debug_output("... loading ...")
      self.table_content_sets = Psych.load_file(TABLE_FILENAME)
    end
  end

  # ---
  def getPopulationEstimate()
    "TO DO"
  end

  # ---
  def getBuildingHeight()
    @howManyFloors * 3.5
  end

  # ---
  def self.getRandomPrimarIndustry()
    getPrimaryIndustry(1.d8)
  end

  # ---
  def getPrimaryIndustry(ptr)
    if ptr == 8
      good_rolls = 0
      set_of_results = {}
      until good_rolls == 2
        this_roll = 1.d8
        unless this_roll == 8
          good_rolls = good_rolls+1
          set_of_results[good_rolls]=loadFromTablePrimaryIndustry(this_roll)
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
      loadFromTablePrimaryIndustry(ptr)
    end
  end

  # ---
  def loadFromTablePrimaryIndustry(ptr)
    primaryIndustryTable = self.table_content_sets[:PrimaryIndustry]

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
    load_table_content_sets()
    debug_output("section requested was |#{section.inspect}|")
    debug_output("table_content_sets was |#{self.table_content_sets.inspect}|")

    tableData = self.table_content_sets[:BuildingShape][section]
    debug_output("tableData was |#{tableData.inspect}|")

    return "unset"
  end

end # class Towerville2056
# ---
