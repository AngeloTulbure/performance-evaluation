function F = HyperExp_moments(p)
	% p(1) -> lambda_1
	% p(2) -> lambda_2
	% p(3) -> p_1
	l1 = p(1);
	l2 = p(2);
	p1 = p(3);
	
	F = [];
	F(1) =   (p1 / l1   + (1-p1) / l2);
	F(2) = 2*(p1 / l1^2 + (1-p1) / l2^2);
	F(3) = 6*(p1 / l1^3 + (1-p1) / l2^3);
end