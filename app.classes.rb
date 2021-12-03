
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

    primaryIndustryTable = []
    primaryIndustryTable[1] = {summaryDesc: "Primary Sector", broadDesc: "Processing & Refining of externally extracted or harvested goods.  Ore, Minerals, Oils, Produce, Forest Products and the like are examples."}
    primaryIndustryTable[2] = {summaryDesc: "Secondary Sector", broadDesc: "Processing, and construction using Primary Sector goods"}
    primaryIndustryTable[3] = {summaryDesc: "wrong3", broadDesc: "still_wrong"}
    primaryIndustryTable[4] = {summaryDesc: "wrong4", broadDesc: "still_wrong"}
    primaryIndustryTable[5] = {summaryDesc: "wrong5", broadDesc: "still_wrong"}
    primaryIndustryTable[6] = {summaryDesc: "wrong6", broadDesc: "still_wrong"}

    tableRow = primaryIndustryTable[ptr]
    f1 = tableRow[:summaryDesc]
    f2 = tableRow[:broadDesc]
    {rollIndex: ptr.to_s, summaryDesc: f1, broadDesc: f2}

  end

end
