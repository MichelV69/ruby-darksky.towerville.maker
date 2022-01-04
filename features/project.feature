Feature: BuildATowerVille
As a CommandLineUser
I want to create a randomly generated TV for DarkSky

	Scenario: Roll 1d6, 1d8, 1d10
		Given that I create a new instance of Towerville2056
		And I request Die Rolls for "1d6", "1d8", and "1d10"
		Then I should get three valid die results

  Scenario: Test Class Featues
    Given that I create a new instance of Towerville2056
    Then initialize should run

    Given that I set the Tower name to 'BigAndRich'
    Then I should see the name 'BigAndRich'

    Given that I set the Tower height to 20 stories
    Then I should see a height in metres of 70m

  Scenario: Test Primary Industry Table
    Given that I create a new instance of Towerville2056
    And that I provide a Number other than 8 to the getRandomPrimaryIndustry method
    Then the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc

  Scenario: Test Random Primary Industry Getter
    Given that I create a new instance of Towerville2056
    Then the Base Class should respond to "getRandomPrimaryIndustry"
    And correctly set the Primary Industry

  Scenario: Determine Number of Floors to Towerville
    Given that I create a new instance of Towerville2056
    And that I request a random floor count
    Then the building floor count should be set
    And should be within a valid range

  Scenario: Determine Building Profile for the Bottom section of Towerville
    Given that I create a new instance of Towerville2056
    And I request a random Building Profile for the Bottom section
    Then Building Profile - Bottom should be set
