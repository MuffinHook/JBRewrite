local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Localization = require(ReplicatedStorage.Module.Localization)
return {
	getCategoryTitle = function(categoryName)
		return Localization:FormatByKey(("GarageVehicle.Category%s"):format(categoryName))
	end
}
