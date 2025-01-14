%% ANGELO TULBURE - A03

clear all;

filename1 = 'Trace1.csv';
filename2 = 'Trace2.csv';
filename3 = 'Trace3.csv';

IA_1 = csvread(filename1);
IA_2 = csvread(filename2);
IA_3 = csvread(filename3);

DS(:,1) = IA_1(:,1);
DS(:,2) = IA_2(:,1);
DS(:,3) = IA_3(:,1);

plot(DS);
sDs = sort(DS);
N = size(DS,1);
plot(sDs, [1:N]/N, ".")


M1 = sum(DS)/N; 
fprintf(1, "First moment (mean): %g\n", M1);
M2 = sum(DS.^2)/N; 
fprintf(1, "Second moment: %g\n", M2);
M3 = sum(DS.^3)/N;
fprintf(1, "Third moment: %g\n", M3);
M4 = sum(DS.^4)/N; 
fprintf(1, "Fourth moment: %g\n", M4);

C2 = sum ((DS - M1) .^2) / N;
fprintf(1, "Second centered moment (Variance): %g\n", C2); 
C3 = sum ((DS - M1) .^3) / N;
fprintf(1, "Third centered moment: %g\n", C3);
C4 = sum ((DS - M1) .^4) / N;
fprintf(1, "Fourth centered moment: %g\n", C4);

Sigma = sqrt(C2); 
fprintf(1, "Standard deviation: %g\n", Sigma);

Cv = Sigma ./ M1; 
fprintf(1, "Coefficient of Variation: %g\n", Cv);

S3 = sum (((DS - M1) ./ Sigma).^3) / N; 
fprintf(1, "3° standardized moment : %g\n", S3);

S4 = sum (((DS - M1) ./ Sigma).^4) / N;
fprintf(1, "4° standardized moment : %g\n", S4);   

exKurt = S4 - 3; 
fprintf(1, "Excess Kurtosis: %g\n", exKurt);

var(DS);

skew = skewness(DS);
fprintf(1, "3° standardized moment (Skewness): %g\n", skew);

kurtosis_var = kurtosis(DS);  
fprintf(1, "Kurtosis: %g\n", kurtosis_var);


%first_quartile = sDs(N/4, :);
h25 = (N-1) * 0.25 + 1; 
ih25 = floor(h25);
d25 = h25 - ih25;   
fq25 = sDs(ih25,:) + (sDs(ih25+1,:) - sDs(ih25,:)) * d25;
%fprintf(1, "First quartile : %g\n", first_quartile);
fprintf(1, "First quartile : %g\n", fq25);
figure(1);
plot(sDs, [1:25000]/25000, ".");    % approximated CDF of the corresponding distribution
legend('Trace 1','Trace 2', 'Trace 3')
ylabel('Cumulative Probability');
title('approximated CDF of the corresponding distribution');
grid on;
%title("approximated CDF of the corresponding distribution")

%median = sDs(N/2, :);
%fprintf(1, "Second quartile: %g\n", median);
h5 = (N-1) * 0.5 + 1;  
ih5 = floor(h5);
d5 = h5 - ih5; 
fq5 = sDs(ih5,:) + (sDs(ih5+1,:) - sDs(ih5,:)) * d5;
fprintf(1, "Second quartile (median) : %g\n", fq5);


%third_quartile = sDs(3*N/4, :);
%fprintf(1, "Third quartile: %g\n", third_quartile);
h75 = (N-1) * 0.75 + 1;  
ih75 = floor(h75);
d75 = h75 - ih75; 
fq75 = sDs(ih75,:) + (sDs(ih75+1,:) - sDs(ih75,:)) * d75;
fprintf(1, "Third quartile : %g\n", fq75);


S_i = zeros(100,3);   %lags from m=1 to m=100
for i=1:100
  S_i(i,:) = sum((DS(1:end-i,:)-M1) .* (DS(i+1:end,:)-M1))/(N-i); 
  %fprintf(1, "Cross covariance: %g\n", S_i(i,:));
end

 
PC = S_i ./ C2;   %Pearson Correlation
%fprintf(1, "Pearson Coefficient : %g\n", PC); 
figure(2)
plot([1:100], PC, "-");    %Pearson Correlation Coefficient for lags m=1 to m=100
ylabel('Pearson Correlation Coefficient')
legend('Trace 1','Trace 2', 'Trace 3')
title("Pearson Correlation Coefficient for lags m=1 to m=100")


