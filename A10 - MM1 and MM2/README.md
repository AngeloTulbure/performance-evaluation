## M/M/1 and M/M/2 systems
Considering a server that executes jobs arriving according to a 
Poisson process of rate λ = 40 job/s, and serves them with an average service time D = 16 ms, 
the following metrics were determined:
- The utilization of the system
- The probability of having exactly one job in the system
- The probability of having less than 10 jobs in the system
- The average queue length (jobs not in service)
- The average response time
- The probability that the response time is greater than 0.5 s
- The 90 percentile of the response time distribution

After 1 year, the load has increased to λ = 90 job/s. 
The system administrator adds a second server and a load balancer: jobs enqueues at the load balancer, 
and then are sent to the first available server.
Considering the communication time between load balancers and servers to be negligible compared to the service times, 
the following metrics were determined for this new configuration:
- The total and average utilization of the system
- The probability of having exactly one job in the system
- The probability of having less than 10 jobs in the system
- The average queue length (jobs not in service)
- The average response time
