# Recharging of an electric car on a highway

## Project Statement
An electric car has to travel a distance which is slightly longer than the one allowed by its battery capacity: it must stop exactly once for recharging on the way! <br>

There are four road segments on the route, with three charging stations in between: each station has a number of chargers available, and a different loads in number of requests <br>

Considering a given probability of choosing exactly one of the charging station, compute the average total travelling time <br>

The travelling times of the four segments, is distributed according to the following traces (all times are expressed in minutes).


Further details:
- Charging time are exponentially distributed, according to an exponential distribution, with an average of 30 minutes.
- The request rate by other cars at the station, and the number of chargers, is given in the following table.
- A station is identified by the number of the segments it is between
  
| Station    | Other traffic [car / hour] | Number of chargers |
|------------|:--------------------------:|:------------------:|
| I - II     | 6                          | 4                  |
| II - III   | 4                          | 3                  |
| III - IV   | 5                          | 3                  |

- The arrival rate of other cars at the stations can be considered a Poisson process.

## Goal
Given this scenario, the goal of the project was to determine the best stopping probability distribution by: 
- Testing different alternatives of probabilities of stopping at each station
- Determine the average travelling time for each scenario.


## Solution
I attempted to model this issue by experimenting with various distributions for each trace using Matlab, aiming to identify the ones that best matched the samples.

To obtain the most precise result I tested 6 different distributions: Uniform, Exponential, Erlang, Hypo Exponential, Weibull and Pareto (Hyper Exponential couldn’t be used because the CoV of all the traces was < 1)

After the fitting phase of the given traces, the distributions found were used to characterize the stages in JMT.

I considered the motion of the electric car as a closed system, with a single job, where the car once it has completed its course, it is teleported back to the initial position to immediately start another trip.
The other cars competing for the charger were considered as an open process.

After testing 7 different scenarios, the best stopping probably found was to stop at Charging Station II-III with prob = 1. With these stopping probabilities, the average travelling time is 81,2512 minutes 
(1 hour and 35 minutes) and its confidential interval is (min: 80,1111, max:82,3914).

For a more detailed solution, have a look at the Excel file present in this folder and at the XXXXXXXXXX link presentazione XXXXXXXX
