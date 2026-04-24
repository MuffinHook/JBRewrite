-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Localization = require(ReplicatedStorage.Module.Localization)
return {
	getCategoryTitle = function(p1)
		return Localization:FormatByKey(("tradecategory.%s"):format(p1))
	end
}
