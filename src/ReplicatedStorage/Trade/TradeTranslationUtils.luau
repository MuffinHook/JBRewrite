local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Localization = require(ReplicatedStorage.Module.Localization)
return {
	getCategoryTitle = function(p1) --[[ Name: getCategoryTitle | Line: 5 | Upvalues: Localization (copy) ]]
		return Localization:FormatByKey(("tradecategory.%s"):format(p1))
	end
}