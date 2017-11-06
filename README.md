# Algorithmic challenge

Welome to today's programming challenge: **Who programs the *quickest* M&A bid-counter?**

Prize: To be announced.

All programming languages allowed.

The idea is to identify only independent bids for a given target company, i.e. to clean the data for bidding contest when multiple companies were bidding for the same target. Therfore, multiple bids for the same target firm within a two-month period should only be counted as one single bid.

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
- Upload your script to the repository
- Hand in your sys.time difference from beginning and end of script
- Introduce your script to your fellow coders 
- Visualize the results
