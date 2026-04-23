return function(p1) --[[ Line: 1 ]]
	p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", {
		{
			Name = "+",
			Perform = function(p1, p2) --[[ Name: Perform | Line: 7 ]]
				return p1 + p2
			end
		},
		{
			Name = "-",
			Perform = function(p1, p2) --[[ Name: Perform | Line: 13 ]]
				return p1 - p2
			end
		},
		{
			Name = "*",
			Perform = function(p1, p2) --[[ Name: Perform | Line: 19 ]]
				return p1 * p2
			end
		},
		{
			Name = "/",
			Perform = function(p1, p2) --[[ Name: Perform | Line: 25 ]]
				return p1 / p2
			end
		},
		{
			Name = "**",
			Perform = function(p1, p2) --[[ Name: Perform | Line: 31 ]]
				return p1 ^ p2
			end
		},
		{
			Name = "%",
			Perform = function(p1, p2) --[[ Name: Perform | Line: 37 ]]
				return p1 % p2
			end
		}
	}))
end