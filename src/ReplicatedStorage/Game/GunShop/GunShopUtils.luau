local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local Localization = require(ReplicatedStorage.Module.Localization)
local GunShopUtils = {
	mapCategoryData = {},
	allData = {},
	takesAmmo = {}
}
for i, itemData in ipairs(script.Parent.Data:GetChildren()) do
	GunShopUtils.mapCategoryData[itemData.Name] = require(itemData)
end
for k, categoryItems in pairs(GunShopUtils.mapCategoryData) do
	for i, itemData in ipairs(categoryItems) do
		table.insert(GunShopUtils.allData, itemData)
		if itemData.For then
			GunShopUtils.takesAmmo[itemData.For] = true
		end
	end
end
function GunShopUtils.getCategoryData(categoryName)
	local categoryData = GunShopUtils.mapCategoryData[categoryName]
	if not categoryData then
		error(("No data exists for category: %s"):format(categoryName))
	end
	return categoryData
end
function GunShopUtils.getAllData()
	return GunShopUtils.allData
end
function GunShopUtils.doesTakeAmmo(itemName)
	return GunShopUtils.takesAmmo[itemName]
end
function GunShopUtils.getDamage(itemName, damageMultiplier)
	local itemConfig = ItemDataUtils.getConfig(itemName)
	if itemConfig then
		if itemConfig.DamageFun then
			return itemConfig.DamageFun(damageMultiplier)
		else
			return assert(itemConfig.Damage)
		end
	else
		return nil
	end
end
function GunShopUtils.getMaxTotalAmmoForItem(itemName)
	if GunShopUtils.doesTakeAmmo(itemName) then
		return ItemDataUtils.getConfig(itemName).MagSize
	else
		return nil
	end
end
function GunShopUtils.getTranslatedTitleFromName(itemName)
	local translatedText, fallbackText = Localization:AttemptFormatByKey("Item2." .. itemName)
	return translatedText and fallbackText or itemName
end
return GunShopUtils
