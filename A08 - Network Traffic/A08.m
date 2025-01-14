%% ANGELO TULBURE - A08

clear all;

lm = 0.33;    %low to medium
mh = 0.4;     %medium to high
ml = 0.6;     %medium to low
hm = 1;       %high to medium
to_d = 0.05;   %everyone to down
from_d = 6;    %down to everyone
p1 = 0.6;     %down to low
p2 = 0.3;     %down to medium
p3 = 0.1;     %down to high
dl = from_d * p1;   %down to low
dm = from_d * p2;   %down to medium
dh = from_d * p3;   %down to high 

%s1=LOW, s2=MEDIUM, s3=HIGH, s4=DOWN

%       s1     s2    s3      s4
Q = [-lm-to_d,  lm,  0,  to_d;            %s1
        ml, -ml-mh-to_d,   mh  , to_d;    %s2
        0 ,   hm, -hm-to_d, to_d;         %s3
        dl,  dm,  dh, -dl-dm-dh, ];       %s4

Tmax = 8;
fprintf("Infinitesimal generator\n");
fprintf("\t\tLOW   MEDIUM    HIGH \t   DOWN\n");
disp(Q);

pM = [0, 1, 0, 0];
[t, Sol] = ode45(@(t,x) Q'*x, [0 Tmax], pM');
figure(1);
plot(t, Sol, "-");
hold on;
title('State probabilities starting from the MEDIUM traffic state');
legend("LOW", "MEDIUM", "HIGH", "DOWN");
grid on;

pD = [0, 0, 0, 1];
[t, Sol] = ode45(@(t,x) Q'*x, [0 Tmax], pD');
figure(2);
plot(t, Sol, "-");
title('State probabilities starting from the DOWN traffic state');
legend("LOW", "MEDIUM", "HIGH", "DOWN");
grid on;
