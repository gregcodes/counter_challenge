# Algorithmic challenge

Welome to today's programming challenge: **Who programs the *quickest* M&A bid-counter?**

Prize: to be announced.

All programming languages allowed.

Requirement:
Multiple bids for the same target firm within a two-month period are counted only as one single bid (the idea is to identify only independent events, i.e. to count a bidding contest when multiple companies are bidding for the same company only as one bid).

Example (date format: dd/mm/yyyy):

Target Name | Date Announced | Count
------------|----------------|------
IceCream Inc | 12.04.1993 | 1
*IceCream Inc* | *02.07.1993* | *1*
*IceCream Inc* | *02.07.1993* | *0*
*IceCream Inc* | *10.07.1993* | *0*
*IceCream Inc* | *11.08.1993* | *0*
IceCream Inc | 29.09.1995 | 1
next Target  | -- | 1


Requirements:
Your counter needs to count all 1,000 bids correctly but at the same time be ultra-fast. 

Are you up for the challenge? Then download the dataset.csv and get started!

When you are finished, please:
- upload your script to the repository
- hand in your sys.time difference from beginning and end of script
- introduce your script to your fellow coders 
- visualize the results
