function F = HyperExp_momentsEquation(p)
	global M1
	global M2
	global M3
	% p(1) -> lambda_1
	% p(2) -> lambda_2
	% p(3) -> p_1
	
	F = HyperExp_moments(p);
	F(1) = F(1) / M1 - 1;
	F(2) = F(2) / M2 - 1;
	F(3) = F(3) / M3 - 1;
end