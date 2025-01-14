## Confidence Intervals

The 2 scenarios considered was:

**Scenario 1:**
- Arrival -> Two stages hyper-exponential distribution with λ<sub>1</sub> = 0.02, λ<sub>2</sub> = 0.2, p<sub>1</sub> = 0.1
- Service -> Erlang with k = 10, λ = 1.5

**Scenario 2:**
- Arrival -> Exponential with λ = 0.1
- Service -> Uniform with a = 5, b = 10

For each scenario, using batches of M = 1000 jobs, it was computed the 95% confidence interval, with a 4% relative error, of the following performance indices:
- Utilization
- Throughput
- Average number of jobs in the system
- Average response time
- Variance of the response time

Then, it was reported the number of batches K required to reach the accuracy defined above.
