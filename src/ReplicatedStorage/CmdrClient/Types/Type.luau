local Util = require(script.Parent.Parent.Shared.Util)
return function(typeRegistry)
	local typeConfig = {
		Transform = function(input)
			return Util.MakeFuzzyFinder(typeRegistry:GetTypeNames())(input)
		end,
		Validate = function(input)
			return #input > 0, "No type with that name could be found."
		end,
		Autocomplete = function(input)
			return input
		end,
		Parse = function(input)
			return input[1]
		end
	}
	typeRegistry:RegisterType("type", typeConfig)
	typeRegistry:RegisterType("types", Util.MakeListableType(typeConfig))
end
