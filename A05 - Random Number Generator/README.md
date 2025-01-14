## Random Number Generation

The Linear Congruent Generator with the following parameters:
- m = 2<sup>32</sup>
- a = 1664525
- c = 1013904223
- seed = 521191478

generates N = 10000 samples, with wich the following distribution were generated:
- N1 = 10000 samples of an Exponential distribution of rate λ = 0.1
- N2 = 10000 samples of a Pareto distribution with parameters α = 1.5, m = 5
- N3 = 2500 samples of an Erlang distribution with k = 4, and λ = 0.4
- N4 = 5000 samples of a Hypo-Exponential distribution with rates λ<sub>1</sub> = 0.5, λ<sub>2</sub> = 0.125
- N5 = 5000 samples of a Hyper-Exponential distribution with rates λ<sub>1</sub> = 0.5, λ<sub>2</sub> = 0.05, p<sub>1</sub> = 0.55

The plots represent the comparisons between the empirical distributions obtained from the samples and the corresponding real distributions, in the range [0, 25].

Then, considered the previous distributions as the length of a file, expressed in GB and the charge for
storing and making available each file by a provider is:
- 0.01 $/GB if the file is less than 10 GB
- 0.02 $/GB if the file is greater than 10 GB

the total cost for storing the N<sub>i</sub> files in each of the previous five scenarios was computed.
