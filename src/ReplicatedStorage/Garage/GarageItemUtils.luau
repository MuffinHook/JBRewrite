local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local GarageItemUtils = {}
function GarageItemUtils.getVehicleCustomizationItemOwned(categoryName, isOwned)
	return ItemUtils.createVehicleCustomizationItemTable(GarageItemUtils.translateToItemOwnedCategoryName(categoryName), isOwned)
end
function GarageItemUtils.translateToItemOwnedCategoryName(categoryName)
	if OwnershipConsts.COLOR_CATEGORY_TYPES[categoryName] then
		return "Color"
	elseif OwnershipConsts.TEXTURE_CATEGORY_TYPES[categoryName] then
		return "Texture"
	else
		return categoryName
	end
end
return GarageItemUtils
