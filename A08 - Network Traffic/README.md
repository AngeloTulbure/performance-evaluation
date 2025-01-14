## Network Traffic
Traffic of requests to a web server can be categorized in three different level: HIGH, MEDIUM, and LOW.
Transitions from one level to another occurs according to exponential distributions.
Moreover, in each traffic state, the network might go to a DOWN state, according to an exponential distribution.
The network remains in the DOWN state for an exponentially distributed amount of time, then returns with a certain probability to a specific traffic state.

The system discribed above is modeled as a CTMC (Markov Chain) and then the two plots show the evolution of the states of the system 
starting from the MEDIUM traffic state and DOWN traffic state.
