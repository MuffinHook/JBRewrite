-- Reviewed by Claude
return function(p1)
	p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", {
		{
			Name = "+",
			Perform = function(p1, p2)
				return p1 + p2
			end
		},
		{
			Name = "-",
			Perform = function(p1, p2)
				return p1 - p2
			end
		},
		{
			Name = "*",
			Perform = function(p1, p2)
				return p1 * p2
			end
		},
		{
			Name = "/",
			Perform = function(p1, p2)
				return p1 / p2
			end
		},
		{
			Name = "**",
			Perform = function(p1, p2)
				return p1 ^ p2
			end
		},
		{
			Name = "%",
			Perform = function(p1, p2)
				return p1 % p2
			end
		}
	}))
end
