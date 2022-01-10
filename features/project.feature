Feature: BuildATowerVille
As a CommandLineUser
I want to create a randomly generated TV for DarkSky

	Scenario Outline: Roll 1d6, 1d8, 1d10
		Given that I have an instance of Towerville2056
		When I request Die Rolls for "1d6", "1d8", and "1d10"
		Then I should get three valid die results

  Scenario Outline: Test Class Featues
    Given that I have an instance of Towerville2056
    Then initialize should run

    Given that I set the Tower name to 'BigAndRich'
    Then I should see the name 'BigAndRich'

    Given that I set the Tower height to 20 stories
    Then I should see a height in metres of 70m

  Scenario Outline: Test Primary Industry Table
    Given that I have an instance of Towerville2056
    When I provide a Number other than 8 to the getRandomPrimaryIndustry method
    Then the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc

  Scenario Outline: Test Random Primary Industry Getter
    Given that I have an instance of Towerville2056
    Then the Base Class should respond to "getRandomPrimaryIndustry"
    And correctly set the Primary Industry

  Scenario Outline: Determine Number of Floors to Towerville
    Given that I have an instance of Towerville2056
    When I request a random floor count
    Then the building floor count should be set
    And should be within a valid range

  Scenario Outline: Determine Building Profile for the "Bottom" section of Towerville
    Given that I have an instance of Towerville2056
    When I request a random Building Profile for the "Bottom" section
    Then Building Profile - "Bottom" should be set

	Scenario Outline: Determine Building Profile for the "Middle" section of Towerville
    Given that I have an instance of Towerville2056
    When I request a random Building Profile for the "Middle" section
    Then Building Profile - "Middle" should be set

	Scenario Outline: Determine Building Profile for the "Crown" section of Towerville
    Given that I have an instance of Towerville2056
    When I request a random Building Profile for the "Crown" section
    Then Building Profile - "Crown" should be set

	Scenario Outline: Determine Building Profile for the "Crown Cap" section of Towerville
    Given that I have an instance of Towerville2056
    When I request a random Building Profile for the "Crown Cap" section
    Then Building Profile - "Crown Cap" should be set

  Scenario Outline: Calculate the Number of Homes in the Building
#Comment : NS:	60.0	Stories
#Comment : SH:	3.5	m
#Comment : H:	210.0	m
#Comment : W:	105.0	m
#Comment : D:	70.0	m
#Comment : FV:	1,080,450.0	m3
#Comment : M3/Home:	700	M3
#Comment : Homes:	1,544 (Round up always)
    Given that I have an instance of Towerville2056
  	And that I set the Tower height to 60 stories
    When I request the Number of Homes in the Building
    Then the Number of Homes in the Building should be 1544

	Scenario Outline: Calculate Building Population
#Comment : Homes:	1,544 (Round up always)
#Comment : Ppl/Home:	3.5	Ppl
#Comment : Pop =	5,404	Ppl	(Round up always)
	  Given that I have an instance of Towerville2056
		And that I set the Tower height to 60 stories
	  When I Calculate the Towerville Population
	  Then the Towerville Population should be "5404"

@DiceStrings
  Scenario Outline: Description for Pillars includes a random-rolled height
    Given the Description for Pillars includes a random-rolled height
    When a formatted string like "height is [roll:1d4+1d6+1] stories"
    Then the dice string should be parsed and replaced with a number

  Scenario Outline: Add expanded Description for Pillars
    Given that a Building Section is added
    When the table result is 'Pillars'
    Then Shape Description should have the 'Pillars Description' added to it.
    And the inline dice string should be parsed and replaced with the result rolled.

@WIP
	Scenario Outline: Directly set and get Primary Employer Scale
	  Given that I have an instance of Towerville2056
		And the Primary Industry has been generated
	  When Directly set the Primary Employer Scale
	  Then I should get the details for the Primary Employer Scale that I expect
