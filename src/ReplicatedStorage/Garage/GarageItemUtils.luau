local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local ItemUtils_upvr = require(ReplicatedStorage.App.ItemUtils)
function module_upvr.getVehicleCustomizationItemOwned(arg1, arg2) -- Line 6
    return ItemUtils_upvr.createVehicleCustomizationItemTable(module_upvr.translateToItemOwnedCategoryName(arg1), arg2)
end
local OwnershipConsts_upvr = require(ReplicatedStorage.Ownership.OwnershipConsts)
function module_upvr.translateToItemOwnedCategoryName(arg1) -- Line 10
    if OwnershipConsts_upvr.COLOR_CATEGORY_TYPES[arg1] then
        return "Color"
    end
    if OwnershipConsts_upvr.TEXTURE_CATEGORY_TYPES[arg1] then
        return "Texture"
    end
    return arg1
end
return module_upvr