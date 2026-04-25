-- Reviewed by Claude
-- variables reassigned
local Util = require(script.Parent.Parent.Shared.Util)
return function(p1)
	local typeConfig = {
		Transform = function(p12)
			return Util.MakeFuzzyFinder(p1:GetTypeNames())(p12)
		end,
		Validate = function(p1)
			return #p1 > 0, "No type with that name could be found."
		end,
		Autocomplete = function(p1)
			return p1
		end,
		Parse = function(p1)
			return p1[1]
		end
	}
	p1:RegisterType("type", typeConfig)
	p1:RegisterType("types", Util.MakeListableType(typeConfig))
end
