Feature: BuildATowerVille
As a CommandLineUser
I want to create a randomly generated TV for DarkSky

	Scenario Outline: Roll 1d6, 1d8, 1d10
		Given that I create a new instance of Towerville2056
		When I request Die Rolls for "1d6", "1d8", and "1d10"
		Then I should get three valid die results

  Scenario Outline: Test Class Featues
    Given that I create a new instance of Towerville2056
    Then initialize should run

    Given that I set the Tower name to 'BigAndRich'
    Then I should see the name 'BigAndRich'

    Given that I set the Tower height to 20 stories
    Then I should see a height in metres of 70m

  Scenario Outline: Test Primary Industry Table
    Given that I create a new instance of Towerville2056
    When I provide a Number other than 8 to the getRandomPrimaryIndustry method
    Then the array I am returned shoud include the rollIndex, the summaryDesc and the broadDesc

  Scenario Outline: Test Random Primary Industry Getter
    Given that I create a new instance of Towerville2056
    Then the Base Class should respond to "getRandomPrimaryIndustry"
    And correctly set the Primary Industry

  Scenario Outline: Determine Number of Floors to Towerville
    Given that I create a new instance of Towerville2056
    When I request a random floor count
    Then the building floor count should be set
    And should be within a valid range

  Scenario Outline: Determine Building Profile for the "Bottom" section of Towerville
    Given that I create a new instance of Towerville2056
    When I request a random Building Profile for the "Bottom" section
    Then Building Profile - "Bottom" should be set

	Scenario Outline: Determine Building Profile for the "Middle" section of Towerville
    Given that I create a new instance of Towerville2056
    When I request a random Building Profile for the "Middle" section
    Then Building Profile - "Middle" should be set

	Scenario Outline: Determine Building Profile for the "Crown" section of Towerville
    Given that I create a new instance of Towerville2056
    When I request a random Building Profile for the "Crown" section
    Then Building Profile - "Crown" should be set

@WIP
	Scenario Outline: Determine Building Profile for the "Crown Cap" section of Towerville
    Given that I create a new instance of Towerville2056
    When I request a random Building Profile for the "Crown Cap" section
    Then Building Profile - "Crown Cap" should be set

@WIP
Scenario Outline: Calculate the Number of Homes in the Building
#Comment : NS:	60.0	Stories
#Comment : SH:	3.5	m
#Comment : H:	210.0	m
#Comment : W:	105.0	m
#Comment : D:	70.0	m
#Comment : FV:	1,080,450.0	m3
#Comment : M3/Home:	700	M3
#Comment : Homes:	1,544.0 (Round up always)
  Given that I create a new instance of Towerville2056
	And that I set the Tower height to 60 stories
  When I request the Number of Homes in the Building
  Then the Number of Homes in the Building should be 1544

@WIP
	Scenario Outline: Calculate Building Population
#Comment : Ppl/Home:	3.5	Ppl
#Comment : Pop =	5,404.0	Ppl	(Round up always)
	  Given that I use the existing instance of Towerville2056
	  When I Calculate the Towerville Population
	  Then the Towerville Population should be "5404.0"
