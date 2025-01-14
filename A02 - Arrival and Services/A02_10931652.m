%% ANGELO MAXIMILIAN TULBURE 10931652 - A02

clear all;

filename1 = 'Trace1.csv';
filename2 = 'Trace2.csv';
filename3 = 'Trace3.csv';

AS_1 = csvread(filename1);
AS_2 = csvread(filename2);
AS_3 = csvread(filename3);

IA_1 = AS_1(:,1);   %inter-arrival time first file
s_1 = AS_1(:,2);    %Service time first file

IA_2 = AS_2(:,1);   %inter-arrival time second file
S_2 = AS_2(:,2);    %Service time second file

IA_3 = AS_3(:,1);   %inter-arrival time third file
S_3 = AS_3(:,2);    %Service time third file

avgIA_mean_1 = mean(IA_1);       %average inter-arrival time file 1
A_rate1 = 1/avgIA_mean_1;        %lambda 1

avgIA_mean_2 = mean(IA_2);       %average inter-arrival time file 2
A_rate2 = 1/avgIA_mean_2;        %lambda 2

avgIA_mean_3 = mean(IA_3);       %average inter-arrival time file 3
A_rate3 = 1/avgIA_mean_3;        %lambda 3

A1 = zeros(length(IA_1), 1);   
A1(1:end,1) = cumsum(IA_1);      %Arrivals file 1


A2 = zeros(length(IA_2), 1);
A2(1:end,1) = cumsum(IA_2);    %Arrivals file 2


A3 = zeros(length(IA_3), 1);
A3(1:end,1) = cumsum(IA_3);    %Arrivals file 3


C1 = zeros(length(A1),1);     
C1(1) = A1(1) + s_1(1);      %Completions file 1
for i=2:length(A1)
    C1(i) = max(A1(i), C1(i-1)) + s_1(i);
end
response_time = C1 - A1;
R1 = sum(response_time)/(length(A1));     %Average response time file 1
fprintf(1, "Average Response Time 1: %g\n", R1);

C2 = zeros(length(A2),1); 
C2(1) = A2(1) + S_2(1);       %Completions file 2
for i=2:length(A2)
    C2(i) = max(A2(i), C2(i-1)) + S_2(i);
end
response_time = C2 - A2;
R2 = sum(response_time)/(length(A2));   %Average response time file 2
fprintf(1, "Average Response Time 2: %g\n", R2);


C3 = zeros(length(A3),1); 
C3(1) = A3(1) + S_3(1);     %Average response time file 3
for i=2:length(A3)
    C3(i) = max(A3(i), C3(i-1)) + S_3(i);
end
response_time = C3 - A3;
R3 = sum(response_time)/(length(A3));   %Average response time file 3
fprintf(1, "Average Response Time 3: %g\n", R3);


T1 = C1(end) - A1(1);
%T1 = sum(IA_1);
nA1 = size(A1, 1);    %number of arrivals file 1
nC1 = size(C1, 1);    %number of completions file 1

evs = [A1, ones(nA1, 1), zeros(nA1, 4); C1, -ones(nC1,1), zeros(nC1,4)];
evs = sortrows(evs, 1);
evs(:,3) = cumsum(evs(:,2));
evs(1:end-1, 4) = evs(2:end,1) - evs(1:end-1,1);
evs(:,5) = (evs(:,3) > 0) .* evs(:,4);
evs(:,6) = evs(:,3) .* evs(:,4);

IdleF1 = evs(:,3) == 0;    %idle frequency file 1
totIdleF1 = sum(IdleF1);   %total idle frequency file 1

B1 = sum(evs(:,5));
U1 = B1 / T1;         %system Utilization 1
fprintf(1, "System Utilization 1: %g\n", U1);
S1 = B1 / nC1;


T2 = C2(end) - A2(1);
%T2 = sum(IA_2);
nA2 = size(A2, 1);    %number of arrivals file 2
nC2 = size(C2, 1);    %number of completions file 2

evs = [A2, ones(nA2, 1), zeros(nA2, 4); C2, -ones(nC2,1), zeros(nC2,4)];
evs = sortrows(evs, 1);
evs(:,3) = cumsum(evs(:,2));
evs(1:end-1, 4) = evs(2:end,1) - evs(1:end-1,1);
evs(:,5) = (evs(:,3) > 0) .* evs(:,4);
evs(:,6) = evs(:,3) .* evs(:,4);

IdleF2 = evs(:,3) == 0;    %idle frequency file 2
totIdleF2 = sum(IdleF2);   %total idle frequency file 2

B2 = sum(evs(:,5));
U2 = B2 / T2;           %system Utilization 2
fprintf(1, "System Utilization 2 : %g\n", U2);
S2 = B2 / nC2;


T3 = C3(end) - A3(1);
%T3 = sum(IA_3);
nA3 = size(A3, 1);    %number of arrivals file 3
nC3 = size(C3, 1);    %number of completions file 3

evs = [A3, ones(nA3, 1), zeros(nA3, 4); C3, -ones(nC3,1), zeros(nC3,4)];
evs = sortrows(evs, 1);
evs(:,3) = cumsum(evs(:,2));
evs(1:end-1, 4) = evs(2:end,1) - evs(1:end-1,1);
evs(:,5) = (evs(:,3) > 0) .* evs(:,4);
evs(:,6) = evs(:,3) .* evs(:,4);

IdleF3 = evs(:,3) == 0;    %idle frequency file 3
totIdleF3 = sum(IdleF3);   %total idle frequency file 3

B3 = sum(evs(:,5));
U3 = B3 / T3;      %system Utilization 3
fprintf(1, "System Utilization 3 : %g\n", U3);
S3 = B3 / nC3;

avgIdleF1 = (T1 - B1) / totIdleF1;   %average idle frequency file 1
avgIdleF2 = (T2 - B2) / totIdleF2;   %average idle frequency file 2
avgIdleF3 = (T3 - B3) / totIdleF3;   %average idle frequency file 3

fprintf(1, "T1: %g\n", T1);
fprintf(1, "T2: %g\n", T2);
fprintf(1, "T3: %g\n", T3);

F1 = totIdleF1/T1;
F2 = totIdleF2/T2;
F3 = totIdleF3/T3;

fprintf(1, "frequency at which the system returns idle 1: %g\n", F1);
fprintf(1, "frequency at which the system returns idle 2: %g\n", F2);
fprintf(1, "ifrequency at which the system returns idle 3: %g\n", F3);

fprintf(1, "average idle time 1 : %g\n", avgIdleF1);
fprintf(1, "average idle time 2 : %g\n", avgIdleF2);
fprintf(1, "average idle time 3 : %g\n", avgIdleF3);

