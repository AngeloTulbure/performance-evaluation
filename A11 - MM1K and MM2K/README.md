## M/M/1/K and M/M/2/K systems

A web server receives requests arriving according to a Poisson process of rate λ = 150 req/min, 
and serves them with an average service time D = 350 ms. 
The web server can handle a maximum of 32 requests at a time: if the system is full, new arrivals are discarded.
The following metrics were computed:
- The utilization of the system
- The loss probability
- The average number of jobs in the system
- The drop rate
- The average response time
- The average time spent in the queue

After 1 year, the load has increased to λ = 250 req/min, making the current solution no longer applicable. 
The system administrator adds a second web server and a load balancer: requests enqueues at the load balancer, 
and then are sent to the first available webserver. 
Considering the communication time between load balancers and servers to be negligible compared to the service times, 
the following metrics were computed for this new configuration:
- The total and average utilization of the system
- The loss probability
- The average number of jobs in the system
- The drop rate
- The average response time
7. The average time spent in the queue
