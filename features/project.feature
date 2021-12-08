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
    And that I provide a Number other than 8 to the getPrimaryIndustry method
    Then the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc

    Given that the number sent to the getPrimaryIndustry method is "8"
    Then I should not see "Split Decsion"
    And the summaryDesc & broadDesc should contain "|"

	Scenario: Roll 1d6, 1d8, 1d10
		Given that I create a new instance of Towerville2056
		And I request Die Rolls for "1d6", "1d8", and "1d10"
		Then I should get three valid die results
