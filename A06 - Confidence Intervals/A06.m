%% ANGELO TULBURE - A06
clear all;

K0 = 1000;
maxK = 20000;
M = 1000;  %number of jobs
DK = 100;

MaxRelErr = 0.04;
gam = 0.95;
d_gamma = norminv((1+gam)/2);

K = K0;
tA = 0;
tC = 0;
U = 0;
U2 = 0;
R = 0;
R2 = 0;
X = 0;
X2 = 0;
NoJ = 0;
NoJ2 = 0;
VR = 0;
VR2 = 0;

r_i_a = [];

newIters = K;

%Scenario 1
while K < maxK
	for i = 1:newIters
		Bi = 0;
		Wi = 0;
		tA0 = tA;
		for j = 1:M
			a_ji = hyper_rdm();
			s_ji = erl_rdm();
			tC = max(tA, tC) + s_ji;
			ri = tC - tA;
			r_i_a(j) = ri;
            Rd((i-1)*M+j,1) = ri;
			tA = tA + a_ji;	
			Bi = Bi + s_ji;
			Wi = Wi + ri;
        end
		Ri = Wi / M;
		R = R + Ri;
		R2 = R2 + Ri^2;

		Ti = tC - tA0;
		Ui = Bi / Ti;
		U = U + Ui;
		U2 = U + Ui^2;

        Xi = M / Ti;
        X = X + Xi;
        X2 = X2 + Xi^2;

        Ni = Wi / Ti;
        NoJ = NoJ + Ni;
        NoJ2 = NoJ2 + Ni^2;

        VRi = var(r_i_a);
        VR = VR + VRi;
        VR2 = VR2 + VRi^2;
        
	end
	
	Rm = R / K;
	Rs = sqrt((R2 - R^2/K)/(K-1));
	CiR = [Rm - d_gamma * Rs / sqrt(K), Rm + d_gamma * Rs / sqrt(K)];
	errR = 2 * d_gamma * Rs / sqrt(K) / Rm;

	Um = U / K;
	Us = sqrt((U2 - U^2/K)/(K-1));
	CiU = [Um - d_gamma * Us / sqrt(K), Um + d_gamma * Us / sqrt(K)];
	errU = 2 * d_gamma * Us / sqrt(K) / Um;

    Xm = X / K;
    Xs = sqrt((X2 - X.^2/K)/(K-1));
    CiX = [Xm - d_gamma * Xs / sqrt(K), Xm + d_gamma * Xs / sqrt(K)];
	errX = 2 * d_gamma * Xs / sqrt(K) / Xm;

    Vm = VR / K;
	Vs = sqrt((VR2 - VR^2/K)/(K-1));
	CiV = [Vm - d_gamma * Vs / sqrt(K), Vm + d_gamma * Vs / sqrt(K)];
	errV = 2 * d_gamma * Vs / sqrt(K) / Vm;

    Nm = NoJ / K;
    Ns=sqrt((NoJ2 - NoJ.^2/K)/(K-1));
    CiN = [Nm - d_gamma * Ns / sqrt(K), Nm + d_gamma * Ns / sqrt(K)];
	errN = 2 * d_gamma * Ns / sqrt(K) / Nm;

	
	if errR < MaxRelErr && errU < MaxRelErr && errX < MaxRelErr && errN < MaxRelErr && errV < MaxRelErr 
		break;
	else
		K = K + DK;
		newIters = DK;
	end
end

if errR < MaxRelErr && errU < MaxRelErr && errX < MaxRelErr && errN < MaxRelErr && errV < MaxRelErr 
	fprintf(1, "Maximum Relative Error reached in %d Iterations (Scenario 1)\n", K);
else
	fprintf(1, "Maximum Relative Error NOT REACHED in %d Iterations (Scenario 1)\n", K);
end	

fprintf(1, "Utilization in [%g, %g], with %g confidence. Relative Error: %g (Scenario 1)\n", CiU(1,1), CiU(1,2), gam, errU);
fprintf(1, "Resp. Time in [%g, %g], with %g confidence. Relative Error: %g (Scenario 1)\n", CiR(1,1), CiR(1,2), gam, errR);
fprintf(1, "Average number of jobs in the system in [%g, %g], with %g confidence. Relative Error: (Scenario 1) %g\n", CiN(1,1), CiN(1,2), gam, errN);
fprintf(1, "Throughput in [%g, %g], with %g confidence. Relative Error: (Scenario 1) %g\n", CiX(1,1), CiX(1,2), gam, errX);
fprintf(1, "Variance of the response time in [%g, %g], with %g confidence. Relative Error: (Scenario 1) %g\n", CiV(1,1), CiV(1,2), gam, errV);

%Scenario 2
K0 = 1000;
maxK = 20000;
M = 1000;
DK = 100;
MaxRelErr = 0.04;

gam = 0.95;
d_gamma = norminv((1+gam)/2);

K = K0;
tA = 0;
tC = 0;
U = 0;
U2 = 0;
X = 0;
X2 = 0;
NoJ = 0;   
NoJ2 = 0;
R = 0;
R2 = 0;
VR = 0;
VR2 = 0;

r_i_a = [];
newIters = K;

while K < maxK
	for i = 1:newIters
		Bi = 0;
		Wi = 0;
		tA0 = tA;
		for j = 1:M
			a_ji = exp_rdm();
			s_ji = unif_rdm();
			tC = max(tA, tC) + s_ji;
			ri = tC - tA;
            r_i_a(j) = ri;
			Rd((i-1)*M+j,1) = ri;
			tA = tA + a_ji;	
			Bi = Bi + s_ji;
			Wi = Wi + ri;
        end
		Ri = Wi / M;
		R = R + Ri;
		R2 = R2 + Ri^2;

		Ti = tC - tA0;
		Ui = Bi / Ti;
		U = U + Ui;
		U2 = U + Ui^2;

        Xi = M / Ti;
        X = X + Xi;
        X2 = X2 + Xi^2;

        Ni = Wi / Ti;
        NoJ = NoJ + Ni;
        NoJ2 = NoJ2 + Ni^2;

        VRi = var(r_i_a);
        VR = VR + VRi;
        VR2 = VR2 + VRi^2;
    end
	Rm = R / K;
	Rs = sqrt((R2 - R^2/K)/(K-1));
	CiR = [Rm - d_gamma * Rs / sqrt(K), Rm + d_gamma * Rs / sqrt(K)];
	errR = 2 * d_gamma * Rs / sqrt(K) / Rm;

	Um = U / K;
	Us = sqrt((U2 - U^2/K)/(K-1));
	CiU = [Um - d_gamma * Us / sqrt(K), Um + d_gamma * Us / sqrt(K)];
	errU = 2 * d_gamma * Us / sqrt(K) / Um;

    Xm = X / K;
    Xs = sqrt((X2 - X.^2/K)/(K-1));
    CiX = [Xm - d_gamma * Xs / sqrt(K), Xm + d_gamma * Xs / sqrt(K)];
	errX = 2 * d_gamma * Xs / sqrt(K) / Xm;

    Vm = VR / K;
	Vs = sqrt((VR2 - VR^2/K)/(K-1));
	CiV = [Vm - d_gamma * Vs / sqrt(K), Vm + d_gamma * Vs / sqrt(K)];
	errV = 2 * d_gamma * Vs / sqrt(K) / Vm;

    Nm = NoJ / K;
    Ns=sqrt((NoJ2 - NoJ.^2/K)/(K-1));
    CiN = [Nm - d_gamma * Ns / sqrt(K), Nm + d_gamma * Ns / sqrt(K)];
	errN = 2 * d_gamma * Ns / sqrt(K) / Nm;


	if errR < MaxRelErr && errU < MaxRelErr && errX < MaxRelErr && errN < MaxRelErr && errV < MaxRelErr 
		break;
	else
		K = K + DK;
		newIters = DK;
	end
end

if errR < MaxRelErr && errU < MaxRelErr && errX < MaxRelErr && errN < MaxRelErr && errV < MaxRelErr 
	fprintf(1, "\n\nMaximum Relative Error reached in %d Iterations (Scenario 2)\n", K);
else
	fprintf(1, "Maximum Relative Error NOT REACHED in %d Iterations (Scenario 2)\n", K);
end	

fprintf(1, "Utilization in [%g, %g], with %g confidence. Relative Error: (Scenario 2) %g \n", CiU(1,1), CiU(1,2), gam, errU);
fprintf(1, "Resp. Time in [%g, %g], with %g confidence. Relative Error: (Scenario 2) %g \n", CiR(1,1), CiR(1,2), gam, errR);
fprintf(1, "Average Number of Jobs in the system in [%g, %g], with %g confidence. Relative Error: (Scenario 2) %g\n", CiN(1,1), CiN(1,2), gam, errN);
fprintf(1, "Throughput in [%g, %g], with %g confidence. Relative Error: (Scenario 1) %g\n", CiX(1,1), CiX(1,2), gam, errX);
fprintf(1, "Variance of the Response Time in [%g, %g], with %g confidence. Relative Error: (Scenario 2) %g\n", CiV(1,1), CiV(1,2), gam, errV);


%Hyper-Exponential distribution Arrival Time Scenario 1
function h = hyper_rdm()
    lambda1 = 0.02;
    lambda2 = 0.2;
    p1 = 0.1;
    p2 = 1-p1;
    p = [p1,p2];
    l1l2 = [lambda1, lambda2];
    C = cumsum(p);
    for k=1:length(l1l2)
        if rand() <= C(k)
            h = -log(rand()) / l1l2(k);
            return;
        end
    end
end

%Exponential Service Time Scenario 1
function expon = exp_rdm()
    lambda = 0.1;
    expon = -log(rand()) / lambda;
    return;
end

%Erlang distribution Arrival Time Scenario 2
function erl = erl_rdm()
k_erlang = 10;
lambda_erlang = 1.5;
out_erlang = 1;
for i = 1:k_erlang
   out_erlang = out_erlang * rand();
end
   erl = -log(out_erlang) ./ lambda_erlang;
end


%Uniform distribution Service Time Scenario 2
    function u = unif_rdm()
    a = 5;
    b = 10;
    u = a + (b-a) * rand();
    return;
end


