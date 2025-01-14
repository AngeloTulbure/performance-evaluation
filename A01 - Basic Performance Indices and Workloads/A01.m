%% ANGELO TULBURE - A01

clear all;

Table = readcell("barrier.log", "Delimiter",']');

T_s = strrep(Table,'[','');
T_s = strrep(T_s,']','');

Arrivals = T_s(T_s(:,2) == "_IN_");    %arrival table 
  
Completions = T_s(T_s(:,2) == "_OUT");  %completion table

A = datetime(Arrivals, 'InputFormat', 'yyyy:DDD:HH:mm:ss:S');     %arrival dates
C = datetime(Completions, 'InputFormat', 'yyyy:DDD:HH:mm:ss:S');  %completion dates 

A = posixtime(A);
C = posixtime(C);

nA = size(A, 1);    %number of arrivals
nC = size(C, 1);    %number of completions
fprintf(1, "nA: %g\n", nA);
fprintf(1, "nC: %g\n", nC);

T = C(end) - A(1); 
Lambda = nA / T;    %%arrival rate
X = nC / T;         %%throughput
fprintf(1, "Arrival Rate: %g, Throughput %g\n", Lambda, X);
Rt = C - A;
W = sum(Rt);

R = W / nC;
fprintf(1, "Average Response Time: %g\n", R);
N = W / T;
fprintf(1, "Average Number of jobs: %g\n", N);

avg_Inter_arr = 1 / Lambda;
fprintf(1, "Average Inter-arrival time: %g\n", avg_Inter_arr);
Inter_arr = A(2:end) - A(1:end-1);    %inter arrival time

evs = [A, ones(nA, 1), zeros(nA, 4); C, -ones(nC,1), zeros(nC,4)];
evs = sortrows(evs, 1);
evs(:,3) = cumsum(evs(:,2));
evs(1:end-1, 4) = evs(2:end,1) - evs(1:end-1,1);
evs(:,5) = (evs(:,3) > 0) .* evs(:,4);
evs(:,6) = evs(:,3) .* evs(:,4);

B = sum(evs(:,5));    %Busy time
U = B / T;            %Utilization
fprintf(1, "Utilization: %g\n", U);
S = B / nC;      %Service time
fprintf(1, "Average Service Time: %g\n", S);

PR_30sec = sum(Rt < 30) / nC;  %probability of having response time less than 30 seconds
PR_3min = sum(Rt < 180) / nC;  %probability of having response time less than 3 minutes

fprintf(1, "Pr(R < 30sec): %g\n", PR_30sec);
fprintf(1, "Pr(R < 3 min): %g\n", PR_3min);

NoTimes = cumsum(evs(:, 2));   %number of times
dt = evs(2:end, 1) - evs(1:end-1, 1);   %deltaT

Pm0 = sum(dt .* (NoTimes(1:end-1, :) == 0)) / T;  %Probability of having 0 parts in the machine
fprintf(1, "Pr(0 parts): %g\n", Pm0);

Pm1 = sum(dt .* (NoTimes(1:end-1, :) == 1)) / T;  %Probability of having 1 part in the machine
fprintf(1, "Pr(1 part): %g\n", Pm1);

Pm2 = sum(dt .* (NoTimes(1:end-1, :) == 2)) / T;  %Probability of having 2 parts in the machine
fprintf(1, "Pr(2 parts): %g\n", Pm2);

PR_int_arr1m = sum(Inter_arr < 60) / nC;   %Probability of having inter-arrival time shorter than 1 minute
fprintf(1, "Pr(Inter_arrival < 1 min): %g\n", PR_int_arr1m);

s_i = C(2:end) - max(A(2:end), C(1:end-1));
PR_S1m = sum(s_i > 60) / nC;    %Probability of having service time longer than 1 minute
fprintf(1, "Pr(Service time > 1 min): %g\n", PR_S1m);
