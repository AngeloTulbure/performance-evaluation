%% ANGELO TULBURE - A10

% M/M/1 - CASE WITH 1 SERVER
lambda = 40;  

D = 16/1000;

mu = 1/D;

rho = lambda/mu;    %utilization of the system

P1 = (1 - rho) * rho^1;  %probability to have exactly one job in the system

P_less_10 = 1 - rho^10;  %probability to have less than 10 jobs in the system

N = rho / (1 - rho);   %total number of jobs

R = D / (1 - rho);   %response time

Avg_queue_length = rho^2 / (1 - rho);   %Average Queue Length

P_R_more_5 = exp(-0.5 / R);  %prob response time is greater than 0.5s

per90 = -log(1-90/100) * R;    %90 percentile of the response time distribution

fprintf("M/M/1 - Case with 1 server\n");
fprintf(1, "Average Utilization of the system is: %g\n", rho);
fprintf(1, "Probability of having exactly one job in the system is: %g\n", P1);
fprintf(1, "Probability of having less than 10 jobs in the system is: %g\n", P_less_10);
fprintf(1, "Average Queue Length (jobs not in service) is: %g\n", Avg_queue_length);
fprintf(1, "Average Response time is: %g\n", R);
fprintf(1, "Probability that the response time is greater than 0.5s is: %g\n", P_R_more_5);
fprintf(1, "90 percentile of the response time distribution is: %g\n", per90);


% M/M/2 - CASE WITH 2 SERVERS
lambda_2 = 90;

c = 2;

mu_2 = mu;

rho_2 = lambda_2 * D / c;    

U_2 = lambda_2 / mu_2;       %total utilization of the system with 2 servers

Avg_U_2 = U_2 / c;           %Avg utilization of the system with 2 servers

P0 = (1 - rho_2) / (1 + rho_2);  

P1_2 = 2 * P0 * rho_2^1;    %probability to have exactly one job in the system with 2 servers

P_less_10_2 = P0;    %probability to have less than 10 jobs in the system with 2 servers

for i = 1:9
    P_less_10_2 = P_less_10_2 + (2 * P0 * rho_2^i);
end

N = rho_2 / (1 - rho^2);    %Avg number of jobs

Avg_queue_length_2 = lambda_2 * rho_2^2 * D / (1 - rho_2^2);  %Average Queue Length

R_2 = D / (1 - rho_2^2);   %Average Response time

fprintf("\n\nM/M/2 - Case with 2 servers\n");
fprintf(1, "Total Utilization of the system is: %g\n", U_2);
fprintf(1, "Average Utilization of the system is: %g\n", Avg_U_2);
fprintf(1, "Probability of having exactly one job in the system is: %g\n", P1_2);
fprintf(1, "Probability of having less than 10 jobs in the system is: %g\n", P_less_10_2);
fprintf(1, "Average Queue Length (jobs not in service) is: %g\n", Avg_queue_length_2);
fprintf(1, "Average Response time is: %g\n", R_2);



%pn_2 = [p0_2, p0_2 * 2 * rho_2, p0_2 * 2 * rho_2 .^[2:K]];

%sum_pn_2 = sum(pn_2);

%P_loss_2 = (rho_2^(K) - rho_2^(K+1)) / (1 - rho_2^(K+1));

%pn = ((1 - rho_2) / (1-rho_2^(K+1))) * rho_2.^[0:K];

%pK = pn(1,end);        %blocking probability

%Avg_U_2 = U_2 / c;           %Avg utilization of the system with 2 servers

%Drop_rate_2 = lambda_2 * pK;

%X_2 = lambda_2 * (1 - pK);

%R_2 = N / lambda_2 * (1 - pK);   %Average Response time   X

%R_2 = N / X_2;
