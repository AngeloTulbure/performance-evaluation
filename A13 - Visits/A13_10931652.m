%% ANGELO MAXIMILIAN TULBURE 10931652 - A13

% Scenario 1 - close model

Z = 10;  %seconds

N = 10;  %fixed population

S_cpu = 20/1000;

S_disk = 10/1000;

S_ram = 3/1000;

S = [Z, S_cpu, S_disk, S_ram];

p_cpu_disk = 0.3;

p_cpu_ram = 0.6;

p_cpu_terminal = 0.1;

p_disk_cpu = 0.85;

p_disk_ram = 0.15;

p_ram_disk = 0.25;

p_ram_cpu = 0.75;

P = [0, 1, 0, 0;
     p_cpu_terminal, 0, p_cpu_disk, p_cpu_ram;
     0, p_disk_cpu, 0, p_disk_ram;
     0, p_ram_cpu, p_ram_disk, 0;
     ];

Pref1 = [[0; 0; 0; 0], P(:,2:4)];

lref1 = [1, 0, 0, 0];

v = lref1 * inv(eye(4) - Pref1);

D_terminal = v(1) * Z;
D_cpu = v(2) * S_cpu;
D_disk = v(3) * S_disk;
D_ram = v(4) * S_ram;

fprintf("\n Scenario 1\n");
fprintf(1, "Visit Terminal is: %g\n", v(1));
fprintf(1, "Visit CPU is: %g\n", v(2));
fprintf(1, "Visit Disk is: %g\n", v(3));
fprintf(1, "Visit RAM is: %g\n\n", v(4));

fprintf(1, "Demand Terminal is: %g\n", D_terminal);
fprintf(1, "Demand CPU is: %g\n", D_cpu);
fprintf(1, "Demand Disk is: %g\n", D_disk);
fprintf(1, "Demand RAM is: %g\n", D_ram);



% Scenario 2 - open model  
S_cpu = 20/1000;

S_disk = 10/1000;

S_ram = 3/1000;

S = [S_cpu, S_disk, S_ram];

lambda_IN = [0.3, 0, 0]; %jobs/sec

p_cpu_disk = 0.3;

p_cpu_ram = 0.6;

p_cpu_leave = 0.1;

p_disk_cpu = 0.8;

p_disk_leave = 0.05;

p_disk_ram = 0.15;

p_ram_disk = 0.25;

p_ram_cpu = 0.75;

P = [0, p_cpu_disk, p_cpu_ram;
     p_disk_cpu, 0, p_disk_ram;
     p_ram_cpu, p_ram_disk, 0;
    ];

lambda_0 = sum(lambda_IN);
l = lambda_IN/lambda_0;
v = l * inv((eye(3) - P));

D_cpu = v(1) * S_cpu;
D_disk = v(2) * S_disk;
D_ram = v(3) * S_ram;

X = lambda_0; %throughput of the sistem
X_cpu = v(1)*X;
X_disk = v(2)*X;
X_ram = v(3)*X;

fprintf("\n\nScenario 2\n");
fprintf(1, "Visit CPU is: %g\n", v(1));
fprintf(1, "Visit Disk is: %g\n", v(2));
fprintf(1, "Visit RAM is: %g\n\n", v(3));

fprintf(1, "Demand CPU is: %g\n", D_cpu);
fprintf(1, "Demand Disk is: %g\n", D_disk);
fprintf(1, "Demand RAM is: %g\n\n", D_ram);

fprintf(1, "Throughput CPU is: %g\n", X_cpu);
fprintf(1, "Throughput Disk is: %g\n", X_disk);
fprintf(1, "Throughput RAM is: %g\n\n", X_ram);


