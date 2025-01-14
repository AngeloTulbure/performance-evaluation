%% ANGELO MAXIMILIAN TULBURE 10931652 - A14

S1 = 2;  %sec        %ShelfCheck
S2 = 30/1000;       %AppServer
S3 = 100/1000;      %Storage
S4 = 80/1000;       %DBMS
 
p10 = 0.2;
p12 = 0.8;
p20 = 0.2;
p23 = 0.3;
p24 = 0.5;
p32 = 1; 
p42 = 1;

lambda_IN = [3, 2, 0, 0];

S = [S1, S2, S3, S4];

P = [0, p12, 0, 0;
     0, 0, p23, p24;
     0, p32, 0, 0;
     0, p42, 0, 0;
     ];

lambda_0 = sum(lambda_IN);

l = lambda_IN/lambda_0;

v = l * inv((eye(4) - P));

D = v.*S;

X = lambda_0;

U = X .* D(2:4);

N_i = U./(1-U);

U1 = X.*D(1);

N = U1 + sum(N_i);

D1 = D(1);

D = D(2:4);

R_i = D ./ (1-U);

R = D1 + sum(R_i);

fprintf(1, "The throughput of the system (X) is: %f\n", X);
fprintf(1, "The average number of jobs in the system (N) is: %f\n", N);
fprintf(1, "The average system response time (R) is: %f\n", R);

