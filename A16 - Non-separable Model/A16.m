%% ANGELO TULBURE - A16

S1 = 40;  %sec      %Terminals
S2 = 50/1000;       %AppServer
S3 = 2/1000;        %StorageCtrl
S4 = 80/1000;       %DBMS
S5 = 80/1000;       %Disk1
S6 = 120/1000;      %Disk2

N = 80;
 
p12 = 1;
p21 = 0.1;
p23 = 0.4;
p24 = 0.5;
p35 = 0.6;
p36 = 0.4;
p42 = 1;
p52 = 1;
p62 = 1;

S = [0, S2, S3, S4, S5, S6];

P = [0, p12, 0, 0, 0, 0;
     p21, 0, p23, p24, 0, 0;
     0, 0, 0, 0, p35, p36;
     0, p42, 0, 0, 0, 0;
     0, p52, 0, 0, 0, 0;
     0, p62, 0, 0, 0, 0;
     ];

Pref1 = [[0; 0; 0; 0; 0; 0], P(:,2:6)];

lref1 = [1, 0, 0, 0, 0, 0];

v = lref1 * inv(eye(6) - Pref1);

D = v .* S;

X = 0;
Z = S1;
rk = 0;

for k =1:6
    Q_k(k) = 0;
end

for n = 1:N
    for k = 1:6
        if k == 1
        rk = D(1);
        else
        rk = D .* (1 + Q_k);
        end
    end
       R_k = sum(rk);
       X = n / (Z + R_k);
    for k = 1:6             
        Q_k = X * rk;
    end
end

U = X .* D;
%R = R_k;         %equivalent (N/X)-Z;
R = (N / X) - Z;

fprintf(1, "The Throughput of the system (X) is: %f\n", X);
fprintf(1, "The Average System Response Time (R) is: %f\n", R);
fprintf(1, "The Utilization of the Application Server is: %f\n", U(2));
fprintf(1, "The Utilization of the Storage Control is: %f\n", U(3));
fprintf(1, "The Utilization of the DBMS is: %f\n", U(4));
fprintf(1, "The Utilization of Disk1 is: %f\n", U(5));
fprintf(1, "The Utilization of Disk2 is: %f\n", U(6));
