%% ANGELO TULBURE - A17

%Production
S1A = 10; %min 
S1B = 4;
S1C = 6;

%Packing
S2A = 12; %min 
S2B = 3;
S2C = 6;

lambdaA = 2/60;     %lambda Raw parts A in min
lambdaB = 3/60;     %lambda Raw parts B in min
lambdaC = 2.5/60;   %lambda Raw parts C in min

lambda = [lambdaA; lambdaB; lambdaC];   %parts/min

S = [S1A , S2A;       %Service times
     S1B , S2B;
     S1C , S2C; ];   

Xc = lambda;

U_kc = Xc .* S; 

U_k = sum(U_kc);

X = sum(Xc);

R_kc = S ./ (1 - U_k);

R_c = sum(R_kc,2);

R = sum(Xc./X .* R_c);     %Response Time
 
N_c = Xc .* R_c;   %Number of jobs

fprintf(1, "The utilization of the First Station is: %g\n", U_k(1));
fprintf(1, "The utilization of the Second Station is: %g\n", U_k(2));

fprintf(1, "The average number of jobs in the system of Class A is: %g\n", N_c(1));
fprintf(1, "The average number of jobs in the system of Class B is: %g\n", N_c(2));
fprintf(1, "The average number of jobs in the system of Class C is: %g\n", N_c(3));

fprintf(1, "The average system response time of Class A is: %g\n", R_c(1));
fprintf(1, "The average system response time of Class B is: %g\n", R_c(2));
fprintf(1, "The average system response time of Class C is: %g\n", R_c(3));

fprintf(1, "The class-independent average system response time (R) is %g\n", R);


