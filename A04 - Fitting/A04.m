%% ANGELO TULBURE - A04
clear all;

filename1 = 'Trace1.csv';
filename2 = 'Trace2.csv';

S1 = csvread(filename1);   %Service Time file 1
S2 = csvread(filename2);   %Service Time file 2

DS(:,1) = S1(:,1);
DS(:,2) = S2(:,1);

sDs = sort(DS);
N = size(DS,1);

M1 = sum(DS)/N; 
fprintf(1, "First moment (mean): %g\n", M1);

M2 = sum(DS.^2)/N;
fprintf(1, "Second moment: %g\n", M2);

M3 = sum(DS.^3)/N;
fprintf(1, "Third moment: %g\n", M3);

Sigma = std(DS);     %standard deviation

Cv = Sigma ./ M1;
fprintf(1, "First moment (mean): %g\n", M1);

Xt1 = sDs(:,1);

Xt2 = sDs(:,2);

lambda = 1 ./ M1;
fprintf(1, "Lambda: %g\n", lambda);

t1 = [0:60];   %the range we want to plot the pdf
t2 = [0:700];   %the range we want to plot the pdf

a = M1 - sqrt(12*(M2 - M1.^2)) / 2;  %left boundary
fprintf(1, "Uniform minimum (a): %g\n", a);
b = M1 + sqrt(12*(M2 - M1.^2)) / 2;  %right boundary
fprintf(1, "Uniform maximum (b): %g\n", b);

% Erlang stages (k)
k_earlang = round(1 ./ Cv.^2);
fprintf(1, "Erlang stages (k): %g\n", k_earlang);
lambda_erlang = k_earlang ./ M1;    
% Erlang rate (lambda)
fprintf(1, "Erlang rate (lambda): %g\n", lambda_erlang);

tmp_erl_t1 = 0; 
for i = 0:k_earlang(1)-1
    tmp_erl_t1 = tmp_erl_t1 + (1/factorial(i)) .* exp(-lambda_erlang(1) .* t1) .* (lambda_erlang(1) .* t1).^i;
end
Earlang_t1 = 1 - tmp_erl_t1;


% Weibull distribution 
%Trace 1
sample_mean = mean(DS(:,1));
sample_variance = var(DS(:,1));
% Create a function that calculates the equations for the method of moments
eqn1 = @(params) [params(2) * gamma(1 + 1 / params(1)) - sample_mean;
                  params(2)^2 * (gamma(1 + 2 / params(1)) - (gamma(1 + 1 / params(1)))^2) - sample_variance];
% Initial guesses for k and lambda
initial_guesses = [1, 1];
% Use fsolve to estimate shape (k_w) and scale (lambda_w)
estimated_params = fsolve(eqn1, initial_guesses);
k_w_t1 = estimated_params(1);
fprintf(1, "Weibull shape t1 (k): %g\n", k_w_t1);
lambda_w_t1 = estimated_params(2);
fprintf(1, "Weibull scale t1 (lambda): %g\n", lambda_w_t1);
Weibull_t1 = 1 - exp(-t1/lambda_w_t1).^k_w_t1; 

%Trace 2
sample_mean = mean(DS(:,2));
sample_variance = var(DS(:,2));
% Create a function that calculates the equations for the method of moments
eqn2 = @(params) [params(2) * gamma(1 + 1 / params(1)) - sample_mean;
                  params(2)^2 * (gamma(1 + 2 / params(1)) - (gamma(1 + 1 / params(1)))^2) - sample_variance];
% Initial guesses for k and lambda
initial_guesses = [1, 1];
% Use fsolve to estimate shape (k_w) and scale (lambda_w)
estimated_params = fsolve(eqn2, initial_guesses);
k_w_t2 = estimated_params(1);
fprintf(1, "Weibull shape t2 (k): %g\n", k_w_t2);
lambda_w_t2 = estimated_params(2);
Weibull_t2 = 1 - exp(-t2/lambda_w_t2).^k_w_t2; 
fprintf(1, "Weibull scale t2 (lambda): %g\n", lambda_w_t2);

% Pareto distribution
sample_mean_t1 = M1(1);
sample_variance_t1 = M2(1);
Pareto_distr_t1 = fsolve(@(params) ...
    [(params(1) > 1 ) * (sample_mean_t1 - params(1) * params(2) / (params(1) - 1)), ...
     (params(1) > 2 ) * (sample_variance_t1 - params(1) * params(2)^2 /((params(1) - 1)^2 * (params(1) - 2))) ...
    ], ...
    [3, Xt1(1)]);
a_p_t1 = Pareto_distr_t1(1);
fprintf(1, "Pareto shape t1 (a): %g\n", a_p_t1);
m_w_t1 = Pareto_distr_t1(2);
fprintf(1, "Pareto scale t1 (m): %g\n", m_w_t1);
Pareto_distr_t1 = zeros(1,length(t1));
for i = 1:length(t1)
    if(t1(i) < m_w_t1)
        Pareto_distr_t1(i) = 0;
    else
        Pareto_distr_t1(i) = 1 - (m_w_t1 / t1(i)) .^ a_p_t1;
    end
end

sample_mean_t2 = M1(2);
sample_variance_t2 = M2(2);
Pareto_distr_t2 = fsolve(@(params) ...
    [(params(1) > 1 ) * (sample_mean_t2 - params(1) * params(2) / (params(1) - 1) ), ...
     (params(1) > 2 ) * (sample_variance_t2 - params(1) * params(2)^2 /((params(1) - 1)^2 * (params(1) - 2))) ...
    ], ...
    [3, Xt2(1)]);
a_p_t2 = Pareto_distr_t2(1);
fprintf(1, "Pareto shape t2 (a): %g\n", a_p_t2);
m_w_t2 = Pareto_distr_t2(2);
fprintf(1, "Pareto scale t2 (m): %g\n", m_w_t2);
Pareto_distr_t2 = zeros(1,length(t2));
for i = 1:length(t2)
    if(t2(i) < m_w_t2)
        Pareto_distr_t2(i) = 0;
    else
        Pareto_distr_t2(i) = 1 - (m_w_t2 / t2(i)) .^ a_p_t2;
    end
end

par_hypo_t1 = mle(DS(:,1), 'pdf', @(X,l1,l2)HypoExp_pdf(X,[l1,l2]), 'Start', [1./(0.3.*M1(1)), 1./(0.7.*M1(1))]);    %maximum likely estimate
fprintf(1, "Hypo Exp t1 lambda1 lambda2 : %g\n", par_hypo_t1);

par_hyper_t2 = mle(DS(:,2), 'pdf', @(X,l1,l2,p1)HyperExp_pdf(X,[l1,l2,p1]), 'Start', [0.8./M1(1), 1.2./M1(1), 0.4]);
fprintf(1, "Hyper Exp t2 l1 l2 p_1: %g\n", par_hyper_t2);

figure(1);
plot(Xt1, [1:N]/N, ".");
hold on;
plot(t1, Unif_cdf(t1,[a(1),b(1)]), "-");
hold on;
plot(t1, Exp_cdf(t1,lambda(1)), "-");
hold on;
plot(t1, Earlang_t1, "-");
hold on;
plot(t1, Weibull_t1, "-");
hold on;
plot(t1, Pareto_distr_t1, "-");
hold on;
plot(t1, HypoExp_cdf(t1, par_hypo_t1), "-");
hold on;
title('CDF Comparison of the distribution Trace 1');
legend("Dataset", "Uniform", "Exponential", "Earlang", "Weibull", "Pareto","HypoExpo");
grid on;


figure(2);
plot(Xt2, [1:N]/N, ".");
hold on;
plot(t2, Unif_cdf(t2,[a(2),b(2)]),"-");
hold on;
plot(t2, Exp_cdf(t2,lambda(2)),"-");
hold on;
plot(t2, Weibull_t2,"-");
hold on;
plot(t2, Pareto_distr_t2, "-");
hold on;
plot(t2, HyperExp_cdf(t2, par_hyper_t2),"-");
hold on;
title('CDF Comparison of the distribution Trace 2');
legend("Dataset","Uniform","Exponential","Weibull","Pareto","HyperExpo");
grid on;

