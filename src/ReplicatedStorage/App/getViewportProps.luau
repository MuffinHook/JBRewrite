local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local ItemSkinUIUtils = require(ReplicatedStorage.Game.ItemSkin.UI.ItemSkinUIUtils)
local HomeItemUIUtils = require(ReplicatedStorage.Home.HomeItem.HomeItemUIUtils)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local SAFE_DATA = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
local ConsumablesData = require(ReplicatedStorage.Consumables.ConsumablesData)
local function updateVehicleCamera(model, boundingBox)
	local animationTime = os.clock() / 2
	model.CFrame = CFrame.Angles(0, animationTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(animationTime * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, boundingBox.BoundingBox.Size.Magnitude * 0.8)
end
local function getVehicleDataForMake(make)
	for i, vehicleDataEntry in ipairs(VehicleData) do
		if vehicleDataEntry.Make == make then
			return vehicleDataEntry
		end
	end
end
return function(itemConfig)
	assert(itemConfig.ItemType, "missing ItemType")
	local localTable = {}
	if itemConfig.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		local CategoryName = itemConfig.CategoryName
		local categoryData = StoreData.GetCategoryByName(CategoryName)
		local ItemName = itemConfig.ItemName
		local itemData = StoreData.GetItemByName(CategoryName, ItemName)
		if itemData and typeof(itemData) == "table" then
			function localTable.getInst()
				return categoryData.GetInstance(itemData)
			end
			localTable.getInstCompare = "VehCust" .. CategoryName .. ItemName
			localTable.updateCamera = categoryData.Update
			return localTable
		end
		warn("Missing vehCust for: " .. CategoryName .. "/" .. ItemName)
	else
		if itemConfig.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
			local Make = itemConfig.Make
			local vehicleData = nil
			for i, vehicleDataEntry in ipairs(VehicleData) do
				if vehicleDataEntry.Make == Make then
					vehicleData = vehicleDataEntry
					break
				end
			end
			function localTable.getInst()
				return getDefaultVehicleModel(Make, vehicleData.Type)
			end
			localTable.getInstCompare = "Vehicle" .. Make
			localTable.updateCamera = updateVehicleCamera
		elseif itemConfig.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
			local ItemName = itemConfig.ItemName
			function localTable.getInst()
				return HomeItemUIUtils.getModel(ItemName)
			end
			localTable.updateCamera = HomeItemUIUtils.getUpdateCamera()
			localTable.getInstCompare = "HomeItem" .. ItemName
		elseif itemConfig.ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
			local SkinName = itemConfig.SkinName
			function localTable.getInst()
				return ItemSkinUIUtils.getModel(SkinName)
			end
			localTable.updateCamera = ItemSkinUIUtils.getUpdateCamera()
			localTable.getInstCompare = "ItemSkin" .. SkinName
		elseif itemConfig.ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
			local TypeEnum = itemConfig.TypeEnum
			localTable.image = "rbxassetid://" .. tostring(SAFE_DATA[TypeEnum].ImageId)
			localTable.getInstCompare = "Safe" .. tostring(TypeEnum)
		elseif itemConfig.ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
			local ItemName = itemConfig.ItemName
			localTable.image = "rbxassetid://" .. tostring(ConsumablesData[ItemName].ImageId)
			localTable.getInstCompare = "Consumable" .. ItemName
		else
			local errorFunction = error
			errorFunction("Invalid ItemType: " .. tostring(itemConfig.ItemType))
		end
		return localTable
	end
end
