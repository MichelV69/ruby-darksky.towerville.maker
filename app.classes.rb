
class Towerville2056
  attr_accessor :name, :primaryIndustry, :howManyFloors, :buildingShapeStack

  def initialize(args = {})
    self.name = "example"
    self.primaryIndustry = "undefined"
    self.howManyFloors = 11
    self.buildingShapeStack = {}
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
  def getPrimaryIndustry(ptr)
    primaryIndustryTable = YAML.load_file("tables.randomTowerville.yaml")

    tableRow = primaryIndustryTable[ptr]
    f1 = tableRow["summaryDesc"]
    f2 = tableRow["broadDesc"]
    {rollIndex: ptr.to_s, summaryDesc: f1, broadDesc: f2}
  end
end
