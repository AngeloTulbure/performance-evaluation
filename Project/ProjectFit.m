%% ANGELO TULBURE - PROJECT A
% Recharging of an electric car on a highway 

clear all;

filenameTrace1 = 'TraceA-I.txt';
filenameTrace2 = 'TraceA-II.txt';
filenameTrace3 = 'TraceA-III.txt';
filenameTrace4 = 'TraceA-IV.txt';

S1 = importdata(filenameTrace1);   %Service Time Segment 1
S2 = importdata(filenameTrace2);   %Service Time Segment 2
S3 = importdata(filenameTrace3);   %Service Time Segment 3
S4 = importdata(filenameTrace4);   %Service Time Segment 4

DS(:,1) = S1;
DS(:,2) = S2;
DS(:,3) = S3;
DS(:,4) = S4;

sDs = sort(DS);

N = size(DS,1);

M1 = sum(DS) / N; 
fprintf(1, "First moment (mean): %g\n", M1);

M2 = sum(DS.^2) / N;
fprintf(1, "Second moment: %g\n", M2);

M3 = sum(DS.^3) / N;
fprintf(1, "Third moment: %g\n", M3);

sigma = std(DS);     %standard deviation

Cv = sigma ./ M1;
fprintf(1, "First moment (mean): %g\n", M1);

Xt1 = sDs(:,1);
Xt2 = sDs(:,2);
Xt3 = sDs(:,3);
Xt4 = sDs(:,4);

lambda = 1 ./ M1;
fprintf(1, "Lambda: %g\n", lambda);

t = [0:0.1:80];     %the range we want to plot the pdf

a = M1 - sqrt(12*(M2 - M1.^2)) / 2;    %left boundary
fprintf(1, "Uniform minimum (a): %g\n", a);
b = M1 + sqrt(12*(M2 - M1.^2)) / 2;    %right boundary
fprintf(1, "Uniform maximum (b): %g\n", b);

% Erlang stages (k)
k_erlang = round(1 ./ Cv.^2);
fprintf(1, "Erlang stages (k): %g\n", k_erlang);
lambda_erlang = k_erlang ./ M1;    
% Erlang rate (lambda)
fprintf(1, "Erlang rate (lambda): %g\n", lambda_erlang);

% Erlang distribution TRACE 1
tmp_erl_sum = zeros(1, length(t));
for i = 0:k_erlang(1)-1
    tmp_erl_sum = tmp_erl_sum + (1/factorial(i)) .* exp(-lambda_erlang(1) .* t) .* (lambda_erlang(1) .* t).^i;
end
Erlang_t1 = 1 - tmp_erl_sum;

par_hypo_t1 = mle(DS(:,1), 'pdf', @(X,l1,l2)HypoExp_pdf(X,[l1,l2]), 'Start', [1./(0.3.*M1(1)), 1./(0.7.*M1(1))]);    %maximum likely estimate
fprintf(1, "Hypo Exp t lambda1 lambda2 : %g\n", par_hypo_t1);

%We can't calculate the Hyper_exp because the Cv is < 1 (Cv(1) = 0.3159) 

% Weibull Distribution TRACE 1
% params(1) is k and params(2) is lambda
par_w_T1 = fsolve(@(params) ...
    [ ...
    M1(1) - params(2) * gamma(1 + 1 / params(1)), ...
    sigma(1)^2 - params(2)^2 * (gamma(1 + 2 / params(1)) - (gamma(1 + 1 / params(1)))^2) ...
    ], ...
    [1, 1]);
k_w_T1 = par_w_T1(1);
lambda_w_T1 = par_w_T1(2);
Weibull_distr_T1 = max(0, 1 - exp(-(t ./ lambda_w_T1) .^ k_w_T1));

% Pareto Distribution TRACE 1
par_p_T1 = fsolve(@(params) ...
    [ ...
    (params(1) > 1) * (M1(1) - params(1) * params(2) / (params(1) - 1)), ...
    (params(1) > 2) * (M2(1) - params(1) * params(2)^2 / ((params(1) - 1)^2 * (params(1) - 2))) ...
    ], ...
    [3, min(S1)]);
alpha_p_T1 = par_p_T1(1);
m_p_T1 = par_p_T1(2);
Pareto_distr_T1 = zeros(1, length(t));
for i = 1:length(t)
    if(t(i) > m_p_T1)
        Pareto_distr_T1(i) = 1 - (m_p_T1 / t(i)) .^ alpha_p_T1;
    else
        Pareto_distr_T1(i) = 0;
    end
end

% TRACE 1
figure(1);
plot(Xt1, [1:N]/N, "-");
hold on;
plot(t, Unif_cdf(t,[a(1),b(1)]), "-");
hold on;
plot(t, Exp_cdf(t,lambda(1)), "-");
hold on;
plot(t, Erlang_t1, "-");
hold on;
plot(t, HypoExp_cdf(t, par_hypo_t1), "-");
hold on;
plot(t, Weibull_distr_T1,"-");
hold on;
plot(t, Pareto_distr_T1, "-");
hold on;
title('CDF Comparison of the distributions Trace 1');
legend("Empirical", "Uniform", "Exponential", "Erlang","HypoExpo","Weibull", "Pareto");
grid on;

% Erlang distribution TRACE 2
tmp_erl_sum = zeros(1, length(t));
for i = 0:k_erlang(2)-1
    tmp_erl_sum = tmp_erl_sum + (1/factorial(i)) .* exp(-lambda_erlang(2) .* t) .* (lambda_erlang(2) .* t).^i;
end
Erlang_t2 = 1 - tmp_erl_sum;

par_hypo_t2 = mle(DS(:,2), 'pdf', @(X,l1,l2)HypoExp_pdf(X,[l1,l2]), 'Start', [1./(0.3.*M1(2)), 1./(0.7.*M1(2))]);    %maximum likely estimate
fprintf(1, "Hypo Exp t lambda1 lambda2 : %g\n", par_hypo_t2);

%We can't calculate the Hyper_exp because the Cv is < 1 (Cv(2) = 0.3323) 

% Weibull Distribution TRACE 2
% params(1) is k and params(2) is lambda
par_w_T2 = fsolve(@(params) ...
    [ ...
    M1(2) - params(2) * gamma(1 + 1 / params(1)), ...
    sigma(2)^2 - params(2)^2 * (gamma(1 + 2 / params(1)) - (gamma(1 + 1 / params(1)))^2) ...
    ], ...
    [1, 1]);
k_w_T2 = par_w_T2(1);
lambda_w_T2 = par_w_T2(2);
Weibull_distr_T2 = max(0, 1 - exp(-(t ./ lambda_w_T2) .^ k_w_T2));

% Pareto Distribution TRACE 2
par_p_T2 = fsolve(@(params) ...
    [ ...
    (params(1) > 1) * (M1(2) - params(1) * params(2) / (params(1) - 1)), ...
    (params(1) > 2) * (M2(2) - params(1) * params(2)^2 / ((params(1) - 1)^2 * (params(1) - 2))) ...
    ], ...
    [3, min(S2)]);
alpha_p_T2 = par_p_T2(1);
m_p_T2 = par_p_T2(2);
Pareto_distr_T2 = zeros(1, length(t));
for i = 1:length(t)
    if(t(i) > m_p_T2)
        Pareto_distr_T2(i) = 1 - (m_p_T2 / t(i)) .^ alpha_p_T2;
    else
        Pareto_distr_T2(i) = 0;
    end
end

% TRACE 2
figure(2);
plot(Xt2, [1:N]/N, "-");
hold on;
plot(t, Unif_cdf(t,[a(2),b(2)]), "-");
hold on;
plot(t, Exp_cdf(t,lambda(2)), "-");
hold on;
plot(t, Erlang_t2, "-");
hold on;
plot(t, HypoExp_cdf(t, par_hypo_t2), "-");
hold on;
plot(t, Weibull_distr_T2,"-");
hold on;
plot(t, Pareto_distr_T2, "-");
hold on;
title('CDF Comparison of the distributions Trace 2');
legend("Empirical", "Uniform", "Exponential", "Erlang", "HypoExpo","Weibull", "Pareto");
grid on;

t = [0:1:150]; 

% Erlang distribution TRACE 3
tmp_erl_sum = zeros(1, length(t));
for i = 0:k_erlang(3)-1
    tmp_erl_sum = tmp_erl_sum + (1/factorial(i)) .* exp(-lambda_erlang(3) .* t) .* (lambda_erlang(3) .* t).^i;
end
Erlang_t3 = 1 - tmp_erl_sum;

par_hypo_t3 = mle(DS(:,3), 'pdf', @(X,l1,l2)HypoExp_pdf(X,[l1,l2]), 'Start', [1./(0.3.*M1(3)), 1./(0.7.*M1(3))]);    %maximum likely estimate
fprintf(1, "Hypo Exp t lambda1 lambda2 : %g\n", par_hypo_t3);

%We can't calculate the Hyper_exp because the Cv is < 1 (Cv(3) = 0.4090) 

% Weibull Distribution TRACE 3
% params(1) is k and params(2) is lambda
par_w_T3 = fsolve(@(params) ...
    [ ...
    M1(3) - params(2) * gamma(1 + 1 / params(1)), ...
    sigma(3)^2 - params(2)^2 * (gamma(1 + 2 / params(1)) - (gamma(1 + 1 / params(1)))^2) ...
    ], ...
    [1, 1]);
k_w_T3 = par_w_T3(1);
lambda_w_T3 = par_w_T3(2);
Weibull_distr_T3 = max(0, 1 - exp(-(t ./ lambda_w_T3) .^ k_w_T3));

% Pareto Distribution TRACE 3
par_p_T3 = fsolve(@(params) ...
    [ ...
    (params(1) > 1) * (M1(3) - params(1) * params(2) / (params(1) - 1)), ...
    (params(1) > 2) * (M2(3) - params(1) * params(2)^2 / ((params(1) - 1)^2 * (params(1) - 2))) ...
    ], ...
    [3, min(S3)]);
alpha_p_T3 = par_p_T3(1);
m_p_T3 = par_p_T3(2);
Pareto_distr_T3 = zeros(1, length(t));
for i = 1:length(t)
    if(t(i) > m_p_T3)
        Pareto_distr_T3(i) = 1 - (m_p_T3 / t(i)) .^ alpha_p_T3;
    else
        Pareto_distr_T3(i) = 0;
    end
end

% TRACE 3
figure(3);
plot(Xt3, [1:N]/N, "-");
hold on;
plot(t, Unif_cdf(t,[a(3),b(3)]), "-");
hold on;
plot(t, Exp_cdf(t,lambda(3)), "-");
hold on;
plot(t, Erlang_t3, "-");
hold on;
plot(t, HypoExp_cdf(t, par_hypo_t3), "-");
hold on;
plot(t, Weibull_distr_T3,"-");
hold on;
plot(t, Pareto_distr_T3, "-");
hold on;
title('CDF Comparison of the distributions Trace 3');
%legend("Empirical","Erlang");
legend("Empirical", "Uniform", "Exponential", "Erlang", "HypoExpo","Weibull", "Pareto");
grid on;

t = [0:0.1:80]; 

% Erlang distribution TRACE 4
tmp_erl_sum = zeros(1, length(t));
for i = 0:k_erlang(4)-1
    tmp_erl_sum = tmp_erl_sum + (1/factorial(i)) .* exp(-lambda_erlang(4) .* t) .* (lambda_erlang(4) .* t).^i;
end
Erlang_t4 = 1 - tmp_erl_sum;

par_hypo_t4 = mle(DS(:,4), 'pdf', @(X,l1,l2)HypoExp_pdf(X,[l1,l2]), 'Start', [1./(0.3.*M1(4)), 1./(0.7.*M1(4))]);    %maximum likely estimate
fprintf(1, "Hypo Exp t lambda1 lambda2 : %g\n", par_hypo_t4);

%We can't calculate the Hyper_exp because the Cv is < 1 (Cv(4) = 0.2892) 

% Weibull Distribution TRACE 4
% params(1) is k and params(2) is lambda
par_w_T4 = fsolve(@(params) ...
    [ ...
    M1(4) - params(2) * gamma(1 + 1 / params(1)), ...
    sigma(4)^2 - params(2)^2 * (gamma(1 + 2 / params(1)) - (gamma(1 + 1 / params(1)))^2) ...
    ], ...
    [1, 1]);
k_w_T4 = par_w_T4(1);
lambda_w_T4 = par_w_T4(2);
Weibull_distr_T4 = max(0, 1 - exp(-(t ./ lambda_w_T4) .^ k_w_T4));

% Pareto Distribution TRACE 4
par_p_T4 = fsolve(@(params) ...
    [ ...
    (params(1) > 1) * (M1(4) - params(1) * params(2) / (params(1) - 1)), ...
    (params(1) > 2) * (M2(4) - params(1) * params(2)^2 / ((params(1) - 1)^2 * (params(1) - 2))) ...
    ], ...
    [3, min(S4)]);
alpha_p_T4 = par_p_T4(1);
m_p_T4 = par_p_T4(2);
Pareto_distr_T4 = zeros(1, length(t));
for i = 1:length(t)
    if(t(i) > m_p_T4)
        Pareto_distr_T4(i) = 1 - (m_p_T4 / t(i)) .^ alpha_p_T4;
    else
        Pareto_distr_T4(i) = 0;
    end
end

% TRACE 4
figure(4);
plot(Xt4, [1:N]/N, "-");
hold on;
plot(t, Unif_cdf(t,[a(4),b(4)]), "-");
hold on;
plot(t, Exp_cdf(t,lambda(4)), "-");
hold on;
plot(t, Erlang_t4, "-");
hold on;
plot(t, HypoExp_cdf(t, par_hypo_t4), "-");
hold on;
plot(t, Weibull_distr_T4,"-");
hold on;%
plot(t, Pareto_distr_T4, "-");
hold on;
title('CDF Comparison of the distributions Trace 4');
legend("Empirical", "Uniform", "Exponential", "Erlang", "HypoExpo","Weibull", "Pareto");
grid on;

