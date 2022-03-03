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
    When I provide a Number other than 8 to the getRandomprimary_industry method
    Then the array I am returned shoud include the rollIndex, the summary_desc and the broad_desc

  Scenario Outline: Test Random Primary Industry Getter
    Given that I have an instance of Towerville2056
    Then the Base Class should respond to "getRandomprimary_industry"
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

  Scenario Outline: New TV should have PES -1
    Given that I have an instance of Towerville2056
    When initialize has run
    Then Primary Employer Scale should be -1

	Scenario Outline: Directly set and get Primary Employer Scale
	  Given that I have an instance of Towerville2056
		And the Primary Industry has been generated
	  When I directly set the Primary Employer Scale
	  Then I should get the details for the Primary Employer Scale that I expect

  Scenario Outline: Randomly set and get Primary Employer Scale
    Given that I have an instance of Towerville2056
    And the Primary Industry has been generated
    When I randomly set the Primary Employer Scale
    Then Primary Employer Scale should be valid
    And I should get valid details for the Primary Employer Scale

  Scenario Outline: New TV should have PER -1
    Given that I have an instance of Towerville2056
    When initialize has run
    Then Primary Economic Rating should be -1

  Scenario Outline: Get Primary Economic Rating as value with randoms
    Given that I have an instance of Towerville2056
    And the Primary Industry has been generated
    When I randomly set the Primary Employer Scale
    And I request a random floor count
    Then Primary Economic Rating should be valid
    And I should get valid details for the Primary Economic Rating

  Scenario Outline: Get Primary Economic Rating as value and text with 7s
    Given that I have an instance of Towerville2056
    And I set the Primary Industry to 5
    And I set the Primary Employer Scale to 6
    When I set the Floor Count to 78
    Then the Primary Economic Rating value should be 1471
    And the Primary Economic Rating description should be "Booming economy, City-famous"

  Scenario Outline: Provide other Details; How Many Shops?
    Given a "5/6/78" Test-Build Towerville
    When I use get_random_variance_by_primary_economic_rating
    Then the number of shops should be around 50

@WIP
  Scenario Outline: Provide other Details; Building Footprint
    Given a "5/6/78" Test-Build Towerville
    When I use get_building_foot_print_as_text
    Then the Building Footprint text should be "136.5m by 91.0m, totalling 12421.5m.sq"

@WIP
 Scenario Outline: Provide other Details; How Many Social Spaces?
   Given a "5/6/78" Test-Build Towerville
   When I set get_random_variance_by_primary_economic_rating to 0.0 with get_social_spaces_data_as_text
   Then the description of Social Spaces should be "25 or so 1240m.sq spaces, totaling 26055m.sq over 3 floors"

@WIP
  Scenario Outline: Provide other Details; How Many Social Spaces?
    Given a "5/6/78" Test-Build Towerville
    When I use getSocialSpaces with set get_random_variance_by_primary_economic_rating fully randomized
    Then the Social Spaces data should be reasonable

# @WIP
#   Scenario Outline: Provide other Details; How Many Green Spaces?
#     Given a "5/6/78" Test-Build Towerville
#     When I check for the number of Green Spaces
#     Then then I should get 2222
# ----- end of file -----
