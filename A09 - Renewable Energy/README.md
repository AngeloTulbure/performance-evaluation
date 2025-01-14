## Renewable Energy Based System

A wildlife monitoring device deployed in a forest, is equipped by both solar panels and a battery. 
To save energy, the system sleeps for a given amount of time, and then scans the environment. 
Scanning have an average duration of 2 minutes. 
The sleeping time depends on the environment: during the night, it sleeps for an average of 18 minutes,
while during the day, it sleeps for 3 minutes during sunny periods and for 8 minutes during cloudy periods. 
Days and nights have an average length of 12 hours, and sunny period have an average length of 6 hours, while cloudy periods an average of 3 hours.
The average power consumption when sleeping is 0.1 Watts, while when scanning the environment is 12 Watts.

Given the description of the system above, the images represent:
- The Continuous Time Markov Chain (CTMC) modeling the system
- The infinitesimal generator matrix Q
- The reward vector for the average power consumption
- The reward vector for the utilization
- The reward matrix for the throughput

Lastly, the following metrics were computed:
- The average power consumption
- The utilization
- The throughput, expressed in scans per day
