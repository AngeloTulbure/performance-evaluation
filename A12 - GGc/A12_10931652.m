%% ANGELO MAXIMILIAN TULBURE 10931652 - A12

% Performance indices of an G/G/1 queue - 1 server
lambda = 10;   %jobs/sec  

mu_1 = 50;

mu_2 = 5;

p1 = 0.8;

D = p1/mu_1 + (1-p1)/mu_2;

m2 = 2*((p1/(mu_1^2)) + ((1-p1)/(mu_2^2)));

rho = lambda * D;    %utilization

R = D + (lambda*m2)/(2*(1-rho));    %respose time

N = lambda * R;   %number of jobs

fprintf("Performance indices of an G/G/1 queue\n");
fprintf(1, "Utilization of the system is: %g\n", rho);
fprintf(1, "(exact) Average Response time is: %g hours \n", R);
fprintf(1, "(exact) Average Response time is: %g minutes \n", R*60);
fprintf(1, "(exact) Average number of jobs in the system is: %g\n", N);


% Performance indices of an G/G/3 queue - 3 servers
lambda_2 = 240;

c = 3;  %G/G/3

k = 5;  %number of stages

T = k / lambda_2;  %mean of the arrivals

rho_2 = D / (3*T);

U_2 = rho_2;   %avg utilization

cv = 1 / sqrt(k);             

ca = sqrt((m2 - D^2)/D^2);

sum_term = 0;
for i = 0:c-1
    sum_term = sum_term + ((c*rho_2)^i / factorial(i));
end

theta = ((D / (c*(1-rho_2)) / (1+(1-rho_2)*(factorial(c)/((c*rho_2)^c))*sum_term)));

R_2 = D + ((ca^2 + cv^2)/2) * theta;   %aprox response time

N_2 = R_2 / T;  %aprox number of jobs

fprintf("\nPerformance indices of an G/G/3 queue\n");
fprintf(1, "Average Utilization of the system is: %g\n", U_2);
fprintf(1, "Aproximate Average Response time is: %g\n", R_2);
fprintf(1, "Aproximate Average number of jobs in the system is: %g\n", N_2);




