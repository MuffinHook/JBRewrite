local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Localization = require(ReplicatedStorage.Module.Localization)
return {
	getCategoryTitle = function(categoryName)
		return Localization:FormatByKey(("tradecategory.%s"):format(categoryName))
	end
}
