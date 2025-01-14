function F = Unif_cdf(x, p)
	a = p(1);
	b = p(2);
	
	F = max(0, min(1, (x>a) .* (x<b) .* (x - a) / (b - a) + (x >= b)));
end