%% ANGELO MAXIMILIAN TULBURE 10931652 - A09

% ASSUMPTIONS 1: THE SYSTEM CAN'T PASS FROM A SLEEP STATE TO ANOTHER SLEEP STATE
% ASSUMPTIONS 2: THE SYSTEM CAN'T DO TWO SCANS IN A ROW. THE SYSTEM MUST GO FROM A SCAN TO A SLEEP AND VICE VERSA
% ASSUMPTIONS 3: THE SYSTEM CAN'T PASS FROM A SLEEP SUNNY/CLOUDY TO SLEEP NIGHT. IT MUST FINISH ALL THE TIME IN SLEEP AND THEN GO TO A SCAN

rew_sleep = 0.1;
rew_scan = 12;


s11 = -((1/3)*(6/24) + (1/3)*(3/24) + (1/3)*(12/24));
s22 = -((1/2)*(6/24) + (1/2)*(3/24) + (1/2)*(12/24));
s33 = -((1/8)*(6/24) + (1/8)*(3/24) + (1/8)*(12/24));
s44 = -((1/2)*(6/24) + (1/2)*(3/24) + (1/2)*(12/24));
s55 = -((1/18)*(6/24) + (1/18)*(3/24) + (1/18)*(12/24));
s66 = -((1/2)*(6/24) + (1/2)*(3/24) + (1/2)*(12/24));

%              s1        s2       s3     s4       s5      s6
sleep_sunny = [s11, (1/3)*(6/24), 0, (1/3)*(3/24), 0, (1/3)*(12/24)];     %s1
scan_sunny =  [(1/2)*(6/24), s22, (1/2)*(3/24), 0, (1/2)*(12/24), 0];     %s2
sleep_cloudy = [0, (1/8)*(6/24), s33,  (1/8)*(3/24), 0, (1/8)*(12/24)];   %s3
scan_cloudy = [(1/2)*(6/24), 0, (1/2)*(3/24), s44, (1/2)*(12/24), 0];     %s4
sleep_night = [0, (1/18)*(6/24), 0, (1/18)*(3/24), s55, (1/18)*(12/24)];  %s5
scan_night =  [(1/2)*(6/24), 0, (1/2)*(3/24), 0, (1/2)*(12/24), s66];     %s6

   %     s1         s2            s3          s4            s5        s6
Q =[sleep_sunny; scan_sunny; sleep_cloudy; scan_cloudy; sleep_night; scan_night];

pi_d = [1, 0, 0, 0, 0, 0];

[t, Sol] = ode45(@(t,x) Q'*x, [0 100], pi_d');
figure(1);
plot(t, Sol, "-");
hold on;
title('State probabilities:');
legend("sleep sunny", "scan sunny", "sleep clody", "scan cloudy", "sleep night", "scan night");
grid("on");

Qp = [ones(6,1),Q(:,2:6)];
p_lim = [1, 0, 0, 0, 0, 0] * inv(Qp);

costWatt = [rew_sleep, rew_scan, rew_sleep, rew_scan, rew_sleep, rew_scan];

power_consumption_avg = p_lim * costWatt';

alpha_U = [0, 1, 0, 1, 0, 1];

scan_rew_matrix = [0, 0, 0, 0, 0, 0;
                   1, 0, 1, 0, 1, 0;
                   0, 0, 0, 0, 0, 0;
                   1, 0, 1, 0, 1, 0;
                   0, 0, 0, 0, 0, 0;
                   1, 0, 1, 0, 1, 0;
                   ];

AverageCost = p_lim * costWatt';
Utilization = p_lim * alpha_U';
scanMin = abs(p_lim * sum((scan_rew_matrix .* Q)')');
Throughput = scanMin * 60 * 24;

fprintf(1, "Average power consuption is: %g\n", AverageCost);
fprintf(1, "Utilization is: %g\n", Utilization);
fprintf(1, "Throughput [scans/day] is: %g\n", Throughput);

label = {'sleep sunny'; 'scan sunny'; 'sleep clody'; 'scan cloudy'; 'sleep night'; 'scan night'};
T = array2table(Q, 'RowNames', label, 'VariableNames', label);
fprintf("\nInfinitesimal generator of the CTMC of the system:\n")
disp(T);

label = {'sleep sunny'; 'scan sunny'; 'sleep clody'; 'scan cloudy'; 'sleep night'; 'scan night'};
T = array2table(alpha_U, 'VariableNames', label);
fprintf("\nReward vector for the Utilization:\n")
disp(T);


label = {'sleep sunny'; 'scan sunny'; 'sleep clody'; 'scan cloudy'; 'sleep night'; 'scan night'};
T = array2table(costWatt, 'VariableNames', label);
fprintf("\nReward vector for the Average Power Consumption:\n")
disp(T);


label = {'sleep sunny'; 'scan sunny'; 'sleep clody'; 'scan cloudy'; 'sleep night'; 'scan night'};
T = array2table(scan_rew_matrix, 'VariableNames', label);
fprintf("\nReward Matrix of the throughput:\n")
disp(T);

