local Util = require(script.Parent.Parent.Shared.Util)
local v1 = Enum.UserInputType:GetEnumItems()
for k, v in pairs(Enum.KeyCode:GetEnumItems()) do
	v1[#v1 + 1] = v
end
local t = {
	Transform = function(p1) --[[ Name: Transform | Line: 10 | Upvalues: Util (copy), v1 (copy) ]]
		return Util.MakeFuzzyFinder(v1)(p1)
	end,
	Validate = function(p1) --[[ Name: Validate | Line: 16 ]]
		return #p1 > 0
	end,
	Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 20 | Upvalues: Util (copy) ]]
		return Util.GetNames(p1)
	end,
	Parse = function(p1) --[[ Name: Parse | Line: 24 ]]
		return p1[1]
	end
}
return function(p1) --[[ Line: 29 | Upvalues: t (copy), Util (copy) ]]
	p1:RegisterType("userInput", t)
	p1:RegisterType("userInputs", Util.MakeListableType(t))
end