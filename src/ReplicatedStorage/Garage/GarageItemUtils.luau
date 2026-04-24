-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local t = {}
function t.getVehicleCustomizationItemOwned(p1, p2)
	return ItemUtils.createVehicleCustomizationItemTable(t.translateToItemOwnedCategoryName(p1), p2)
end
function t.translateToItemOwnedCategoryName(p1)
	if OwnershipConsts.COLOR_CATEGORY_TYPES[p1] then
		return "Color"
	elseif OwnershipConsts.TEXTURE_CATEGORY_TYPES[p1] then
		return "Texture"
	else
		return p1
	end
end
return t
