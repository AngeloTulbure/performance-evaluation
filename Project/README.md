# Concert Ticket Service project

## Project Statement
A concert ticketing service has to handle a large number of requests in a short amount of time. <br>
The system can allow at most N = 1000 pending requests at a time.

The service will be composed by four stages:
- Welcome message
- Seat selection
- Payment processor
- Ticket issuing

The durations of the four stages, is distributed according to the traces present in this folder (all times are
expressed in ms).

Further details:
- Requests arrive at a rate of 6000 req/min in the first 8 hours
- Then they will arrive at a rate of 300 req/min for the following 6 days and 16 hours
- The service will propose a new concert every week
- Requests not admitted, will be dropped

## Goal
Given this scenario, the goal of the project was to try different configurations (in terms of number of cores per stage) to obtain:
- Average response time below 5 minutes
- Average drop probability below 25%

using the fewest possible cores per stage

## Solution
After the fitting phase of the given traces, the distributions found were used to characterize the stages in JMT.
Iterating the simulations for 11 times changing the number of cores, the best configuration found that respect all the constraints given is composed by:
- 1 core for Welcome Message stage
- 19 cores for Seat Selection stage
- 4 coresfor Payment processor stage
- 4 coresfor Ticket Issuing stage

For a more detailed solution, have a look at the Excel file present in this folder and at the XXXXXXXXXX link presentazione XXXXXXXX
