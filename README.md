[_metadata_:author_name]:- "Michel R Vaillancourt"
[_metadata_:author_email]:- "Michel@MichelRVaillancourt.com"
[_metadata_:studio_name]:- "Wolfstar Studios"
[_metadata_:project_start_date]:- "01 Dec 2021 - Afternoon"
[_metadata_:tags]:- "ttrpg ruby markdown"

[_metadata_:version]:- "1.1.0"
[_metadata_:last_change_date]:- "05 Mar 2022 @ 08h55ADT"


Project Purpose
---------------

Project intends to develop a simple to use random roller that will build "Towervilles" based on the "Dark Sky - Dark Future" rules for Open Legend.

What It Does
============

  * Performs a series of API calls to random.org to simulate various die rolls.
  * Uses rules from "Dark Sky - Dark Future" in code as well as YAML-formated look-up tables to determine roll results.
  * Provides setting descriptions of the following characteristics:

    + Physical building dimensions
    + Physical building shape / form-factor
    + Interior space allocations
    + Population
    + Key economic data

### Pending Specification Changes

 * Building shape / form-factor should be changed from 3 to 5 sections
    + Basement is +5% of total height
    + Ground is 1/8th total height, max 11.
    + Ground to F22.
    + Above F22
    + Above 2/3 total height.
    + Crown is last 10%

  * Building shape / form-factor descriptions should be listed "sky to ground", which is the inverse of how they are currently listed.

  * Add glossary-style footnotes to output such that repetitive large descriptions are taken out of main "stat block".

How To Use
==========

 * Clone or Unpack the source into a directory on the working machine.
 * Switch to that directory.
 * Execute the following command:

`ruby ./app.main.rbx`

Example Output
==============

    Example Tower :: # of Floors: 68
                  :: Height: 238.0 meters tall
                  :: Ground area footprint: 119.0m by 79.3m, totalling 9 440m.sq
                  :: # of Homes : 2 246
                  :: # of People : 7 861
                  :: Approximate # of shops: 29
                  :: Approximate # of social spaces : 20 or so 1 195m.sq spaces, totalling 21 895m.sq over 3 floors
                  :: Approximate # of green spaces : 6 or so 2 140m.sq spaces, totalling 13 250m.sq over 5 floors

    Example Tower :: Bottom section: Octagonal
                  :: Middle section: Rectangle
                  :: Crown section: 3 Triangular pillars leading to single full-area pyramid cap (“Pillars” are 7 in number and 8 stories tall, and leave 50% void space of the foot print.)
                  :: 'Crown Forest':
    The 'Crown' is capped with forest of RF antennas, microwave link dishes,
    aircraft warning lights, weather sensors, cameras, and even very short range
    anti-aircraft systems. Additionally, there will heavy cables, struts, hatches,
    ladders and scaffolding to allow access and maintenance to all that hardware.
     The 'Crown Forest' unofficially increases the height of the building another
    8 stories.

    Example Tower :: Economics: Quinary Sector
    The highest levels of decision-making in a society or economy. This sector
    includes top executives or officials in such fields as government, science,
    universities, nonprofits, health care, culture, and the media. It also
    includes police and fire departments, when those are actually are public
    services
                  :: primary Employer Scale: 2: City-Level Meta-Corp
                  :: Relative Economic Status : 1197 : Healthy economy, with/ noticeable City influence

Future Plans
------------

* Batch-build mode.
* Command-line key arguments for building configuration.
* Add HTML generation for inclusion in webpage.
