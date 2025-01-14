%% ANGELO MAXIMILIAN TULBURE 10931652 - A07
clear all;

s = 1;

Cmax = 100000;
dt = 0;

timer = 0; %minutes

trace = [timer, s];

Win = 0;
Lose = 0;
Games = 0;


RT = [];  %response time
Rti = 1; 
PlayLen = 0;

while Games < Cmax
	if s == 1  % ENTRANCE
		prob = rand();   
		if(prob < 0.7)
           prob = rand();
           tW = -log(rand() * rand() * rand() * rand()) / 1.5;  %Erlang
           tL = -log(rand()) / 0.5;  %Exponential
           if(prob < 0.8)
		      ns = 2;
			  dt = tW;
			  timer = timer + dt;
           else
			ns = 4;            
            dt = tL;
            timer = timer + dt;
           end
         else  % first multiplexer p = 0.3
             prob = rand();  
             a = 3;
             b = 6;
             lambda = 0.25;
             tW = a + (b-a) * rand();      %Uniform
             tL = -log(rand()) / lambda;   %Exponential
             if(prob < 0.3)
			    ns = 3;
			    dt = tW;
			    timer = timer + dt;
             else
			    ns = 4;            
                dt = tL;
                timer = timer + dt;
     	     end
        end
        PlayLen = PlayLen + dt;
    end

if s == 2   % C1 path
		prob = rand();   
		if(prob < 0.5)
           prob = rand();
           lambda_erl = 2;
           lambda_ex = 0.4;
           tW = -log(rand() * rand() * rand()) / lambda_erl;  %Erlang
           tL = -log(rand()) / lambda_ex;    %Exponential
           if(prob < 0.25)
			ns = 3;
			dt = tW;
			timer = timer + dt;
           else
			ns = 4;     %LAVA         
            dt = tL;
            timer = timer + dt;
           end
 else 
      prob = rand();  
      lambda1 = 0.15;
      lambda2 = 0.2;
      tW = -log(rand()) / lambda1;   %Exponential winning
      tL = -log(rand()) / lambda2;   %Exponential losing
      if(prob < 0.6)
	     ns = 3;
	     dt = tW;
		 timer = timer + dt;
      else
	     ns = 4;    %LAVA         
         dt = tL;
         timer = timer + dt;
      end
   end
   PlayLen = PlayLen + dt;
end


if s == 3   % C2 path
      prob = rand();
      lambda_erl = 4;
      tW = -log(rand()*rand()*rand()*rand()*rand()) / lambda_erl;  %Erlang Win
      tL = -log(rand()*rand()*rand()*rand()*rand()) / lambda_erl;  %Erlang Lose
      if(prob < 0.6)
      ns = 5;   %WIN
      dt = tW;
      timer = timer + dt;
      else
	  ns = 4;  %LAVA            
      dt = tL;
      timer = timer + dt;
      end
      PlayLen = PlayLen + dt;   
end
     

if s == 5    %WIN - EXIT
    timer = timer + 5;
    ns = 1;   %restart the game
    Win = Win + 1;
	Games = Games + 1;
	RT(Rti, 1) = PlayLen;
	Rti = Rti + 1;
	PlayLen = 0;
end


if s == 4   %LAVA 
   timer = timer + 5;
   ns = 1;
   Lose = Lose + 1;
   Games = Games + 1;
   RT(Rti, 1) = PlayLen;
   Rti = Rti + 1;
   PlayLen = 0;
end

s = ns;
trace(end + 1, :) = [timer, s];
end
 
	
Pwin = Win / Games;
AveGame = mean(RT);
X = Cmax / timer * 60;

fprintf(1, "Probability of winning: %g\n", Pwin);
fprintf(1, "Average duration of a game : %g\n", AveGame);
fprintf(1, "Throughput of the system (games/hours) : %g\n", X);
fprintf(1, "Number of simulations : %g\n", Cmax);


