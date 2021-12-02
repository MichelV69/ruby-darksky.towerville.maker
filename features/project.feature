Feature: BuildATowerVille
As a CommandLineUser
I want to create a randomly generated TV for DarkSky

  Scenario: Test Class Featues
    Given that I create a new instance of Towerville2056
    Then initialize should run

    Given that I set the Tower name to 'BigAndRich'
    Then I should see the name 'BigAndRich'

    Given that I set the Tower height to 20 stories
    Then I should see a height in metres of 70m

  Scenario: Test Primary Industry Table
    Given that I create a new instance of Towerville2056
    And that I provide a Number to the getPrimaryIndustry method
    Then the array I am returned shoud include the Number, the SummaryDesc and the BroadDesc
    | Number   |  SummaryDesc    |  BroadDesc |
    | 1        | Primary Sector  |  Processing & Refining of externally extracted or harvested goods.  Ore, Minerals, Oils, Produce, Forest Products and the like are examples. |
