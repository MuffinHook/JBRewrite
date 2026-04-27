local Util = require(script.Parent.Parent.Shared.Util)
return function(typeRegistry)
	local commandTypeSpec = {
		Transform = function(input)
			return Util.MakeFuzzyFinder(typeRegistry:GetCommandNames())(input)
		end,
		Validate = function(commandInput)
			return #commandInput > 0, "No command with that name could be found."
		end,
		Autocomplete = function(commandInput)
			return commandInput
		end,
		Parse = function(commandInput)
			return commandInput[1]
		end
	}
	typeRegistry:RegisterType("command", commandTypeSpec)
	typeRegistry:RegisterType("commands", Util.MakeListableType(commandTypeSpec))
end
