-- Reviewed by Claude
-- variables reassigned
local Util = require(script.Parent.Parent.Shared.Util)
local keyPatterns = { "^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$" }
return function(cmdrConfig)
	local typeConfig = {
		Autocomplete = function(inputValue)
			return cmdrConfig.Cmdr.Util.MakeFuzzyFinder(cmdrConfig.Cmdr.Util.DictionaryKeys(cmdrConfig:GetStore("vars_used") or {}))(inputValue)
		end,
		Validate = function(inputKey)
			for i, v in ipairs(keyPatterns) do
				if inputKey:match(v) then
					return true
				end
			end
			return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
		end,
		Parse = function(inputKey)
			return inputKey
		end
	}
	cmdrConfig:RegisterType("storedKey", typeConfig)
	cmdrConfig:RegisterType("storedKeys", Util.MakeListableType(typeConfig))
end
