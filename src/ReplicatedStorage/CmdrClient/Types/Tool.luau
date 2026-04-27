local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Util = require(ReplicatedStorage.CmdrClient.Shared.Util)
local toolFuzzyFinder = Util.MakeFuzzyFinder((TableUtils.map(ReplicatedStorage.Resource.ItemSystem.Models:GetChildren(), function(model)
	return model.Name
end)))
local toolType = {
	Transform = function(text)
		return toolFuzzyFinder(text)
	end,
	Validate = function(results)
		return #results > 0, "No valid vehicle makes with that name could be found."
	end,
	Autocomplete = function(suggestions)
		return suggestions
	end,
	Parse = function(results)
		return results[1]
	end
}
return function(registry)
	registry:RegisterType("tool", toolType)
	registry:RegisterType("tools", Util.MakeListableType(toolType))
end
