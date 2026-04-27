local Util = require(script.Parent.Parent.Shared.Util)
local validInputTypes = Enum.UserInputType:GetEnumItems()
for k, v in pairs(Enum.KeyCode:GetEnumItems()) do
	validInputTypes[#validInputTypes + 1] = v
end
local userInputType = {
	Transform = function(input)
		return Util.MakeFuzzyFinder(validInputTypes)(input)
	end,
	Validate = function(input)
		return #input > 0
	end,
	Autocomplete = function(input)
		return Util.GetNames(input)
	end,
	Parse = function(input)
		return input[1]
	end
}
return function(cmdr)
	cmdr:RegisterType("userInput", userInputType)
	cmdr:RegisterType("userInputs", Util.MakeListableType(userInputType))
end
