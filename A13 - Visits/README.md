## Visits, Throughput and Demands

Considering an embedded system composed by a CPU, a disk and a memory bank like in the following image:

![A13_1](https://github.com/user-attachments/assets/77e1043d-cb43-4607-8359-df5d0b777847)

The disk controller can use DMA to transfer data between the memory and the disk independently from the CPU. New jobs start and finish on the CPU. 
The system is currently used by a fixed population of N = 10 users.

The following metrics were computed:
- The visits to the four stations
- The demand of the four stations

After testing has been completed, the fixed users are replaced by external arrival and departures. 
Moreover, it has been observed that sometimes the disk fails, making jobs leave immediately after their service. 
The new system can be modelled with the following queuing network:

![A13_2](https://github.com/user-attachments/assets/ec9c7248-51e8-4e69-8b12-1b49c2250059)

Given this new scenario, the following metrics were computed:
- The visits to the three stations
- The demand of the three stations
- The throughput of the three stations

