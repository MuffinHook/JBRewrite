-- Reviewed by Claude
local Util = require(script.Parent.Parent.Shared.Util)
local v1 = Enum.UserInputType:GetEnumItems()
for k, v in pairs(Enum.KeyCode:GetEnumItems()) do
	v1[#v1 + 1] = v
end
local t = {
	Transform = function(p1)
		return Util.MakeFuzzyFinder(v1)(p1)
	end,
	Validate = function(p1)
		return #p1 > 0
	end,
	Autocomplete = function(p1)
		return Util.GetNames(p1)
	end,
	Parse = function(p1)
		return p1[1]
	end
}
return function(p1)
	p1:RegisterType("userInput", t)
	p1:RegisterType("userInputs", Util.MakeListableType(t))
end
