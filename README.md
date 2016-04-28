## Black Thursday

Find the [project spec here](https://github.com/turingschool/curriculum/blob/master/source/projects/black_thursday.markdown).

#### Project completed by:
Charlie Kaminer and Nick Pisciotta

#### Purpose:
The purpose of Black Thursday was to create a system that could take in business intelligence data and perform a variety of actions on it (i.e. read, parse, query, etc.)  There were six classes of data:
* Merchant
* Invoice Items
* Invoices
* Customers
* Transactions
* Items

The overarching goal was to create a sales analyst/engine that could handle any of the tasks listed above by traversing to and from each of the six repositories.

#### Parts:
There were a variety of pieces required to analyze the data.  This included the ability to calculate averages, standard deviations, sorting by ids, linking relationships, and running queries that traverse many levels of data.  

#### Workflow:
We were able to complete this project using the given spec as a guide for how to build everything from the ground up.  We started out making unit classes and their matching repositories before we ran any queries using the sales analyst.  This helped us keep everything in order and link objects together in an orderly way.

#### Challenges:
One of the main challenges of this project was dealing with large data sets that were given.  Testing was difficult to implement due to the size/run time of this data.  When we tried shrinking the data set it became a challenge to find meaningful results due to all of the moving parts that had to match up in the data.  We circumvented this problem by creating our own smaller data sets.  This allowed us to throughly test our results better and decreased our test suite run time greatly.

#### Successes:
The feature we are most proud of on this project is the emphasis on the single responsibility principle.  We spent a large amount of time refactoring, creating modules, and moving methods to a more appropriate class, which we thought made the project a lot more readable.  Our hope is that someone opening this project for the first time would be able to spend a minimal amount of time figuring out what methods are trying to accomplish and where they need to go to accomplish them.
