
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

end
