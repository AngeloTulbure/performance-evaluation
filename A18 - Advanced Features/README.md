## Advanced features

A secure storage system is composed by a controller and three disks: each file is replicated on the three devices.
Two types of requests are generated: read requests and write requests.
Write requests access all disks and are considered finished only when are all the replicas completed.
Read requests access instead only one of the three disks, using a join the shortest queue approach.
The controller takes an average of 0.2 s The three disks work respectively with an average service time respectively of 0.15 s, 0.17 s, and 0.18 s.

Considering all the timing being exponentially distributed, write requests arriving at a rate of 1.5 req/s, and read requests at the rate of 3 req/s, 
the following metrics were computed using a JMT model:
- The average system response time, global and for read and write requests
- The utilization of the three disks and of the controller
