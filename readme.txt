EMEX Coding Challenge: Rank Price Quotes
========================================

Overview
--------

You will be writing a program to load price quotes for a list of customers, rank them, and output them again. You could imagine this program being used to show customers the best quotes available to them.

You should use Ruby for the main program. Feel free to use any standard or external libraries that will help you. If you use an external library, please include it with your submission.

Recommended steps:

* Take a few minutes to write up an analysis of the approach you intend to take.
* Get as far as you can on a solution.
* If you don't finish, include a few notes on what your next steps would be. If you do finish, include any steps you would take to improve your program.

Details
-------

You've been given a file containing electricity quotes for a list of customers. Every customer will have one or more quotes, each one from a different electricity supplier. You need to output a new file containing each customer's quotes, ranked in descending order. In addition, you will need to include price differentials between each quote and that customer's winning quote.

Some quotes include tax and some don't. The ranking and differentials need to be based on a price that includes tax. That means that for some quotes, you will need to add in the state's tax before doing the ranking. Customers are located in different states, so you'll need to look up the appropriate tax for their state. State taxes are included in a separate file.

The key part of this challenge is in ranking each customer's quotes correctly.

Input
-----

In this directory are two .csv files which will serve as input:

* quotes.csv
  * Each row contains a customer's quote from a specific supplier.
  * A customer's quotes will appear together -- quotes are sorted by cust_id.
  * Not every supplier will provide a quote to each customer.
  * You can't count on the order of supplier quotes for a customer.
   
* state_taxes.csv
  * Each row contains the tax for a state.
  * All states referenced in quotes.csv are present.

quotes.csv columns:
  * cust_id -- Customer's numeric ID
  * supplier -- Supplier's name
  * quote -- Price for electricity, as a floating point number
  * includes_tax -- 'Y' or 'N'
  * state -- 2-letter state abbreviation (all of a customer's quotes will
    be in the same state)

state_taxes.csv columns:
  * state -- 2-letter state abbreviation
  * tax -- Tax percentage (7.0 means a 7% tax)

Output
------

You should output a new .csv file called 'ranked_quotes.csv'. The file should contain the same number of quotes as the input quotes file. However, the ordering and format will be different.

ranked_quotes.csv columns:
  * cust_id -- Customer's numeric ID
  * supplier -- Supplier's name
  * quote_with_tax -- Electricity price, including tax
  * ranking -- The quote's ranking for that customer, where lowest quote
    is #1 (assuming tax added in)
  * differential -- Difference between this quote and the lowest quote,
    rounded to the 4th decimal place. (0.04519 -> 0.0452) Difference must
    be based on price with tax added in, just like the ranking.

The rows should be ordered by 1) customer id ascending, 2) quote's ranking for the customer, 3) supplier name (if two quotes are the same.) Customers should appear in the same order as in the original file, and each customer's quotes should appear together in the file.

SAMPLE: Please see sample input and output files in sample_input.csv and
sample_output.csv. These are based on the taxes in state_taxes.csv.

Evaluation
----------

In evaluating your submission, we will be looking at the following criteria:

* Correctness - Does the program generate the correct output?
* Clarity - Is your code clear and readable?
* Prioritization - If you didn't finish, did you work on most important tasks first?

We will also look at your analysis to get a good idea of your thought process.