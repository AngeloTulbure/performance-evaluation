function F = MM_HyperExp(p)
	global M1
	global M2
	% p(1) -> lambda_1
	% p(2) -> lambda_2
	
	F = HypoExp_moments(p);
	F(1) = F(1) ./ M1 - 1;
	F(2) = F(2) ./ M2 - 1;
end