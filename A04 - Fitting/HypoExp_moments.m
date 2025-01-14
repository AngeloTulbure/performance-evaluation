function F = HyperExp_moments(p)
	% p(1) -> lambda_1
	% p(2) -> lambda_2

	l1 = p(1);
	l2 = p(2);
	
	F = [];
	F(1) = 1 / l1 + 1 / l2;
	F(2) = 2*(1 / (l1.^2) + 1 / (l1*l2) + 1 ./ (l2.^2));
end