-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local Localization = require(ReplicatedStorage.Module.Localization)
local t = {
	mapCategoryData = {},
	allData = {},
	takesAmmo = {}
}
for i, v in ipairs(script.Parent.Data:GetChildren()) do
	t.mapCategoryData[v.Name] = require(v)
end
for k, v in pairs(t.mapCategoryData) do
	for i, v2 in ipairs(v) do
		table.insert(t.allData, v2)
		if v2.For then
			t.takesAmmo[v2.For] = true
		end
	end
end
function t.getCategoryData(p1)
	local v1 = t.mapCategoryData[p1]
	if not v1 then
		error(("No data exists for category: %s"):format(p1))
	end
	return v1
end
function t.getAllData()
	return t.allData
end
function t.doesTakeAmmo(p1)
	return t.takesAmmo[p1]
end
function t.getDamage(p1, p2)
	local v1 = ItemDataUtils.getConfig(p1)
	if v1 then
		if v1.DamageFun then
			return v1.DamageFun(p2)
		else
			return assert(v1.Damage)
		end
	else
		return nil
	end
end
function t.getMaxTotalAmmoForItem(p1)
	if t.doesTakeAmmo(p1) then
		return ItemDataUtils.getConfig(p1).MagSize
	else
		return nil
	end
end
function t.getTranslatedTitleFromName(p1)
	local v1, v2 = Localization:AttemptFormatByKey("Item2." .. p1)
	return v1 and v2 or p1
end
return t
