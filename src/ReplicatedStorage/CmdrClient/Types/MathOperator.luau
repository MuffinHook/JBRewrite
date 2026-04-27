return function(cmdr)
	cmdr:RegisterType("mathOperator", cmdr.Cmdr.Util.MakeEnumType("Math Operator", {
		{
			Name = "+",
			Perform = function(left, right)
				return left + right
			end
		},
		{
			Name = "-",
			Perform = function(left, right)
				return left - right
			end
		},
		{
			Name = "*",
			Perform = function(left, right)
				return left * right
			end
		},
		{
			Name = "/",
			Perform = function(left, right)
				return left / right
			end
		},
		{
			Name = "**",
			Perform = function(left, right)
				return left ^ right
			end
		},
		{
			Name = "%",
			Perform = function(left, right)
				return left % right
			end
		}
	}))
end
