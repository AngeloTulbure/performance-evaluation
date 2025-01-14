## Performance indices of M/G/1 and G/G/3 queue

A web server receives jobs according to a Poisson process of rate λ = 10 j/s. The duration of each job is distributed according to an Hyper-Exponential distribution,
of rate μ<sub>1</sub> = 50 j/s and μ<sub>2</sub> = 5 j/s and p<sub>1</sub> = 0.8.

Considering the scenario described above, the following metrics were computed:
- The utilization of the system
- The (exact) average response time
- The (exact) average number of jobs in the system

After a year, the traffic increases and stabilizes: now it can be considered distributed according to a 5 stages Erlang distribution, 
with λ = 240 j/s. To support this new scenario, two extra web servers are added, together with a load-balancer that holds request in a single queue, 
and dispatches them to the first available server.

Assuming the time required by the load balancer to be negligible, the following metrics were computed:
- The average utilization of the system
- The approximate average response time
- The approximate average number of jobs in the system
