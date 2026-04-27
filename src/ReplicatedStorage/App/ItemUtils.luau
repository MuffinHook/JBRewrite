local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local SafesConsts = require(ReplicatedStorage.Safes.SafesConsts)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local ConsumablesData = require(ReplicatedStorage.Consumables.ConsumablesData)
local Localization = require(ReplicatedStorage.Module.Localization)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local SAFE_DATA = SafesConsts.SAFE_DATA
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local function getVehicleDataForMake(make)
	for i, v in ipairs(VehicleData) do
		if v.Make == make then
			return v
		end
	end
end
local ItemSkinList = require(ReplicatedStorage.Game.ItemSkin.ItemSkinList)
local function getItemSkinForName(itemSkinName)
	for i, v in ipairs(ItemSkinList) do
		if v.Name == itemSkinName then
			return v
		end
	end
end
local module = {
	createVehicleItemTable = function(make)
		assert(typeof(make) == "string", "Incorrect make type passed")
		return {
			ItemType = PlayerDataConsts.VEHICLE_ITEM_TYPE,
			Make = make
		}
	end,
	createVehicleCustomizationItemTable = function(categoryName, itemName)
		if typeof(categoryName) ~= "string" then
			error("Incorrect categoryName type passed: " .. tostring(categoryName) .. ", " .. typeof(categoryName))
		end
		assert(typeof(itemName) == "string", "Incorrect itemName type passed")
		if not OwnershipConsts.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET[categoryName] then
			error("Tried to create vehicleCustomizationItemTable for category: " .. categoryName)
		end
		return {
			ItemType = PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE,
			CategoryName = categoryName,
			ItemName = itemName
		}
	end,
	createHomeItemItemTable = function(itemName)
		assert(typeof(itemName) == "string", "Incorrect itemName type passed")
		return {
			ItemType = PlayerDataConsts.HOME_ITEM_ITEM_TYPE,
			ItemName = itemName
		}
	end,
	createItemSkinTable = function(skinName)
		assert(typeof(skinName) == "string", "Incorrect skinName type passed")
		return {
			ItemType = PlayerDataConsts.ITEM_SKIN_ITEM_TYPE,
			SkinName = skinName
		}
	end,
	createSafeTable = function(typeEnum)
		assert(typeof(typeEnum) == "number", "Incorrect typeEnum type passed")
		return {
			ItemType = PlayerDataConsts.SAFE_ITEM_TYPE,
			TypeEnum = typeEnum
		}
	end,
	createConsumableTable = function(itemName)
		assert(typeof(itemName) == "string", "Incorrect itemName type passed")
		return {
			ItemType = PlayerDataConsts.CONSUMABLE_ITEM_TYPE,
			ItemName = itemName
		}
	end,
	getStoreData = function(itemTable)
		local ItemType = itemTable.ItemType
		if ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
			return getVehicleDataForMake(itemTable.Make)
		elseif ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
			return StoreData.GetItemByName(itemTable.CategoryName, itemTable.ItemName)
		elseif ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
			local ItemName = itemTable.ItemName
			local homeItemModel = ReplicatedStorage.Resource.HomeItem:FindFirstChild(ItemName)
			if homeItemModel then
				local module = {}
				for index, valueInstance in homeItemModel:GetChildren() do
					if valueInstance:IsA("ValueBase") then
						module[valueInstance.Name] = valueInstance.Value
					end
				end
				return module
			else
				warn("Missing homeItemModel for: " .. ItemName)
				return nil
			end
		else
			if ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
				return getItemSkinForName(itemTable.SkinName)
			end
			if ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
				return SAFE_DATA[itemTable.TypeEnum]
			end
			if ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
				return ConsumablesData[itemTable.ItemName]
			end
			error("Could not find store data for itemOwned, invalid itemType: " .. tostring(ItemType))
		end
	end
}
function module.getItemTablesForItemType(itemTable)
	local ItemType = itemTable.ItemType
	if ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
		local itemTables = {}
		for index, vehicleData in VehicleData do
			table.insert(itemTables, module.createVehicleItemTable(vehicleData.Make))
		end
		return itemTables
	end
	if ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		local CategoryName = itemTable.CategoryName
		local itemTables = {}
		for index, categoryItem in StoreData.GetCategoryByName(CategoryName).Items do
			table.insert(itemTables, module.createVehicleCustomizationItemTable(CategoryName, categoryItem.Name))
		end
		return itemTables
	end
	if ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
		local itemTables = {}
		for index, homeItem in ReplicatedStorage.Resource.HomeItem:GetChildren() do
			table.insert(itemTables, module.createHomeItemItemTable(homeItem.Name))
		end
		return itemTables
	end
	if ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
		local itemTables = {}
		for index, itemSkin in ItemSkinList do
			table.insert(itemTables, module.createItemSkinTable(itemSkin.Name))
		end
		return itemTables
	end
	if ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		local itemTables = {}
		for typeEnum in SafesConsts.TYPE_ENUM:GetEnumItems() do
			table.insert(itemTables, module.createSafeTable(typeEnum))
		end
		return itemTables
	end
	if ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
		local itemTables = {}
		for consumableName in ConsumablesData do
			table.insert(itemTables, module.createConsumableTable(consumableName))
		end
		return itemTables
	end
	error("Could not find item type data for itemOwned, invalid itemType: " .. tostring(ItemType))
end
function module.isTradeable(itemTable)
	local itemData = module.getStoreData(itemTable)
	assert(typeof(itemData) == "table", "itemData is not a table")
	return not itemData.NoTrade
end
function module.validateItemTableFormat(itemTable)
	if itemTable.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
		assert(typeof(itemTable.Make) == "string", "Invalid make given for vehicle")
	elseif itemTable.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		assert(typeof(itemTable.ItemName) == "string", "Invalid ItemName given for vehicle customization")
		local CategoryName = itemTable.CategoryName
		assert(typeof(CategoryName) == "string", "Invalid CategoryName given for vehicle customization")
		if not OwnershipConsts.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET[CategoryName] then
			error("Invalid CategoryName for vehicle customization: " .. CategoryName)
		end
	elseif itemTable.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
		assert(typeof(itemTable.ItemName) == "string", "Invalid ItemName given for home item")
	elseif itemTable.ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
		assert(typeof(itemTable.SkinName) == "string", "Invalid SkinName given for item skin")
	elseif itemTable.ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		assert(typeof(itemTable.TypeEnum) == "number", "Invalid TypeEnum given for item skin")
	elseif itemTable.ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
		local ItemName = itemTable.ItemName
		assert(typeof(ItemName) == "string", "Invalid ItemName type given for consumable")
		assert(ConsumablesData[ItemName], "Unknown consumable itemName")
	else
		error("Invalid ItemType: " .. itemTable.ItemType)
	end
end
function module.getStrippedItemTable(itemTable)
	local ItemType = itemTable.ItemType
	local module = {
		itemType = ItemType,
		uid = itemTable.Id,
		created = itemTable.CreationTime
	}
	if ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
		module.name = itemTable.Make
	elseif ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		module.subItemType = itemTable.CategoryName
		module.name = itemTable.ItemName
	elseif ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
		module.name = itemTable.ItemName
	elseif ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
		module.name = itemTable.SkinName
	elseif ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		module.name = SafesConsts.TYPE_ENUM:GetValueFromEnum(itemTable.TypeEnum)
	elseif ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
		module.name = itemTable.ItemName
	end
	return module
end
function module.getFullNameFromTable(itemTable)
	local nameParts = {}
	module.validateItemTableFormat(itemTable)
	local strippedItemTable = module.getStrippedItemTable(itemTable)
	table.insert(nameParts, strippedItemTable.itemType)
	if strippedItemTable.subItemType then
		table.insert(nameParts, strippedItemTable.subItemType)
	end
	table.insert(nameParts, strippedItemTable.name)
	return table.concat(nameParts, "."), strippedItemTable
end
function module.getTranslatedTitleFromItemTable(itemTable)
	local fullName, strippedItemTable = module.getFullNameFromTable(itemTable)
	local ItemType = itemTable.ItemType
	if ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
		return SafesConsts.SAFE_DATA[itemTable.TypeEnum].Title
	elseif ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE or (ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE or ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE) then
		return strippedItemTable.name
	else
		return Localization:FormatByKey(fullName)
	end
end
return module
