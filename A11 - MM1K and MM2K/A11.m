%% ANGELO TULBURE - A11

% M/M/1/K system - CASE WITH 1 SERVER
lambda = 150/60;  

D = 350/1000;

mu = 1/D;

rho = lambda/mu;    

K = 32;

U = (rho - rho^(K+1)) / (1 - rho^(K+1));     %Utilization of the system

N = (rho / (1 - rho)) - ((K+1) * rho^(K+1)) / (1 - rho^(K+1));   %Average number of jobs

P_loss = (rho^(K) - rho^(K+1)) / (1 - rho^(K+1));     %Loss probability


Drop_rate = lambda * ((rho^K - rho^(K+1)) / (1-rho^(K+1)));    %Drop_rate

R = D * ((1-(K+1)*rho^K + K*rho^(K+1)) / ((1-rho)*(1-rho^K)));   %response time

Avg_Queue_T = R - D;

fprintf("M/M/1/K system\n");
fprintf(1, "Utilization of the system is: %g\n", U);
fprintf(1, "Loss probability is: %g\n", P_loss);
fprintf(1, "Average number of jobs in the system is: %g\n", N);
fprintf(1, "Drop rate is: %g\n", Drop_rate);
fprintf(1, "Average Response time is: %g\n", R);
fprintf(1, "Average time spent in the queue (waiting for service) is: %g\n", Avg_Queue_T);


% M/M/2/K system - CASE WITH 2 SERVERS
lambda_2 = 250/60;

c = 2;

mu_2 = mu;

rho_2 = lambda_2 / (c * mu_2);    

sum_for_p0 = 0;
for k1 = 0:c-1
    sum_for_p0 = sum_for_p0 + (c * rho_2)^k1 / factorial(k1);
end

p0_2 = ((((c*rho_2)^c / factorial(c))*((1 - rho_2^(K-c+1)) / (1 - rho_2))) + sum_for_p0)^(-1);


first_part = 0;
for i = 1:c
    pi = (p0_2 / (factorial(c) * c^(i-c))) * (lambda_2 / mu_2)^i;
    first_part = first_part + (i*pi);
end

second_part = 0;
for i = c+1:K
    pi = (p0_2 / (factorial(c) * c^(i-c))) * (lambda_2 / mu_2)^i;
    second_part = second_part + pi;
end

U_2 = first_part + (c * second_part);

Avg_U_2 = U_2 / c;

N_2 = 0;
for i = 1:K
    pi = (p0_2 / (factorial(c) * c^(i-c))) * (lambda_2 / mu_2)^i;
    N_2 = N_2 + (i*pi);
end

pn_2 = (p0_2 / (factorial(c)*c^(K-c))) * (lambda_2 / mu_2)^K;

Drop_rate_2 = lambda_2 * pn_2; %equal to c=1

R_2 = N_2 / (lambda_2 * (1 - pn_2));

Avg_Queue_T_2 = R_2 - D;

fprintf("\n\nM/M/2/K system\n");
fprintf(1, "Total Utilization of the system is: %g\n", U_2);
fprintf(1, "Average Utilization of the system is: %g\n", Avg_U_2);
fprintf(1, "Loss probability of the system is: %g\n", pn_2);
fprintf(1, "Average number of jobs in the system is: %g\n", N_2);
fprintf(1, "Drop rate is: %g\n", Drop_rate_2);
fprintf(1, "Average Response time is: %g\n", R_2);
fprintf(1, "Average time spent in the queue (waiting for service) is: %g\n", Avg_Queue_T_2);

