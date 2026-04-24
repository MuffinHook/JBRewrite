-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local SafesConsts = require(ReplicatedStorage.Safes.SafesConsts)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local ConsumablesData = require(ReplicatedStorage.Consumables.ConsumablesData)
local Localization = require(ReplicatedStorage.Module.Localization)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local SAFE_DATA = SafesConsts.SAFE_DATA
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local function getVehicleDataForMake(p1)
	for i, v in ipairs(VehicleData) do
		if v.Make == p1 then
			return v
		end
	end
end
local ItemSkinList = require(ReplicatedStorage.Game.ItemSkin.ItemSkinList)
local function getItemSkinForName(p1)
	for i, v in ipairs(ItemSkinList) do
		if v.Name == p1 then
			return v
		end
	end
end
local module = {
	createVehicleItemTable = function(p1)
		assert(typeof(p1) == "string", "Incorrect make type passed")
		return {
			ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
			Make = p1
		}
	end,
	createVehicleCustomizationItemTable = function(p1, p2)
		if typeof(p1) ~= "string" then
			error("Incorrect categoryName type passed: " .. tostring(p1) .. ", " .. typeof(p1))
		end
		assert(typeof(p2) == "string", "Incorrect itemName type passed")
		if not OwnershipConsts.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET[p1] then
			error("Tried to create vehicleCustomizationItemTable for category: " .. p1)
		end
		return {
			ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
			CategoryName = p1,
			ItemName = p2
		}
	end,
	createHomeItemItemTable = function(p1)
		assert(typeof(p1) == "string", "Incorrect itemName type passed")
		return {
			ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
			ItemName = p1
		}
	end,
	createItemSkinTable = function(p1)
		assert(typeof(p1) == "string", "Incorrect skinName type passed")
		return {
			ItemType = PlayerDataConsts.ITEM_SKIN_ITEM_TYPE,
			SkinName = p1
		}
	end,
	createSafeTable = function(p1)
		assert(typeof(p1) == "number", "Incorrect typeEnum type passed")
		return {
			ItemType = PlayerDataConsts.SAFE_ITEM_TYPE,
			TypeEnum = p1
		}
	end,
	createConsumableTable = function(p1)
		assert(typeof(p1) == "string", "Incorrect itemName type passed")
		return {
			ItemType = PlayerDataConsts.CONSUMABLE_ITEM_TYPE,
			ItemName = p1
		}
	end,
	getStoreData = function(p1)
		local ItemType = p1.ItemType
		if ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
			return getVehicleDataForMake(p1.Make)
		elseif ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
			return StoreData.GetItemByName(p1.CategoryName, p1.ItemName)
		elseif ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
			local ItemName = p1.ItemName
			local v1 = ReplicatedStorage.Resource.HomeItem:FindFirstChild(ItemName)
			if v1 then
				local module = {}
				for v2, v3 in v1:GetChildren() do
					if v3:IsA("ValueBase") then
						module[v3.Name] = v3.Value
					end
				end
				return module
			else
				warn("Missing homeItemModel for: " .. ItemName)
				return nil
			end
		else
			if ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
				return getItemSkinForName(p1.SkinName)
			end
			if ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
				return SAFE_DATA[p1.TypeEnum]
			end
			if ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
				return ConsumablesData[p1.ItemName]
			end
			error("Could not find store data for itemOwned, invalid itemType: " .. tostring(ItemType))
		end
	end
}
function module.getItemTablesForItemType(p1)
	local ItemType = p1.ItemType
	if ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
		local t2 = {}
		for v1, v2 in VehicleData do
			table.insert(t2, module.createVehicleItemTable(v2.Make))
		end
		return t2
	end
	if ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		local CategoryName = p1.CategoryName
		local t2 = {}
		for v3, v4 in StoreData.GetCategoryByName(CategoryName).Items do
			table.insert(t2, module.createVehicleCustomizationItemTable(CategoryName, v4.Name))
		end
		return t2
	end
	if ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
		local t2 = {}
		for v6, v7 in ReplicatedStorage.Resource.HomeItem:GetChildren() do
			table.insert(t2, module.createHomeItemItemTable(v7.Name))
		end
		return t2
	end
	if ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
		local t2 = {}
		for v9, v10 in ItemSkinList do
			table.insert(t2, module.createItemSkinTable(v10.Name))
		end
		return t2
	end
	if ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		local t2 = {}
		for v12 in SafesConsts.TYPE_ENUM:GetEnumItems() do
			table.insert(t2, module.createSafeTable(v12))
		end
		return t2
	end
	if ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
		local t2 = {}
		for v13 in ConsumablesData do
			table.insert(t2, module.createConsumableTable(v13))
		end
		return t2
	end
	error("Could not find item type data for itemOwned, invalid itemType: " .. tostring(ItemType))
end
function module.isTradeable(p1)
	local v1 = module.getStoreData(p1)
	assert(typeof(v1) == "table", "itemData is not a table")
	return not v1.NoTrade
end
function module.validateItemTableFormat(p1)
	if p1.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
		assert(typeof(p1.Make) == "string", "Invalid make given for vehicle")
	elseif p1.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		assert(typeof(p1.ItemName) == "string", "Invalid ItemName given for vehicle customization")
		local CategoryName = p1.CategoryName
		assert(typeof(CategoryName) == "string", "Invalid CategoryName given for vehicle customization")
		if not OwnershipConsts.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET[CategoryName] then
			error("Invalid CategoryName for vehicle customization: " .. CategoryName)
		end
	elseif p1.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
		assert(typeof(p1.ItemName) == "string", "Invalid ItemName given for home item")
	elseif p1.ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
		assert(typeof(p1.SkinName) == "string", "Invalid SkinName given for item skin")
	elseif p1.ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		assert(typeof(p1.TypeEnum) == "number", "Invalid TypeEnum given for item skin")
	elseif p1.ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
		local ItemName = p1.ItemName
		assert(typeof(ItemName) == "string", "Invalid ItemName type given for consumable")
		assert(ConsumablesData[ItemName], "Unknown consumable itemName")
	else
		error("Invalid ItemType: " .. p1.ItemType)
	end
end
function module.getStrippedItemTable(p1)
	local ItemType = p1.ItemType
	local module = {
		itemType = ItemType,
		uid = p1.Id,
		created = p1.CreationTime
	}
	if ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
		module.name = p1.Make
	elseif ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		module.subItemType = p1.CategoryName
		module.name = p1.ItemName
	elseif ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
		module.name = p1.ItemName
	elseif ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
		module.name = p1.SkinName
	elseif ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		module.name = SafesConsts.TYPE_ENUM:GetValueFromEnum(p1.TypeEnum)
	elseif ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
		module.name = p1.ItemName
	end
	return module
end
function module.getFullNameFromTable(p1)
	local t2 = {}
	module.validateItemTableFormat(p1)
	local v1 = module.getStrippedItemTable(p1)
	table.insert(t2, v1.itemType)
	if v1.subItemType then
		table.insert(t2, v1.subItemType)
	end
	table.insert(t2, v1.name)
	return table.concat(t2, "."), v1
end
function module.getTranslatedTitleFromItemTable(p1)
	local v1, v2 = module.getFullNameFromTable(p1)
	local ItemType = p1.ItemType
	if ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		return SafesConsts.SAFE_DATA[p1.TypeEnum].Title
	elseif ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE or (ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE or ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE) then
		return v2.name
	else
		return Localization:FormatByKey(v1)
	end
end
return module