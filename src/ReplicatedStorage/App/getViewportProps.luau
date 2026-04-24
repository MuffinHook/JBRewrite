-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local ItemSkinUIUtils = require(ReplicatedStorage.Game.ItemSkin.UI.ItemSkinUIUtils)
local HomeItemUIUtils = require(ReplicatedStorage.Home.HomeItem.HomeItemUIUtils)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local SAFE_DATA = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
local ConsumablesData = require(ReplicatedStorage.Consumables.ConsumablesData)
local function updateVehicleCamera(p1, p2)
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1 * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, p2.BoundingBox.Size.Magnitude * 0.8)
end
local function getVehicleDataForMake(p1)
	for i, v in ipairs(VehicleData) do
		if v.Make == p1 then
			return v
		end
	end
end
return function(p1)
	assert(p1.ItemType, "missing ItemType")
	local localTable = {}
	if p1.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
		local CategoryName = p1.CategoryName
		local v1 = StoreData.GetCategoryByName(CategoryName)
		local ItemName = p1.ItemName
		local v2 = StoreData.GetItemByName(CategoryName, ItemName)
		if v2 and typeof(v2) == "table" then
			function localTable.getInst()
				return v1.GetInstance(v2)
			end
			localTable.getInstCompare = "VehCust" .. CategoryName .. ItemName
			localTable.updateCamera = v1.Update
			return localTable
		end
		warn("Missing vehCust for: " .. CategoryName .. "/" .. ItemName)
	else
		if p1.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
			local Make = p1.Make
			local v3 = nil
			for i, v in ipairs(VehicleData) do
				if v.Make == Make then
					v3 = v
					break
				end
			end
			function localTable.getInst()
				return getDefaultVehicleModel(Make, v3.Type)
			end
			localTable.getInstCompare = "Vehicle" .. Make
			localTable.updateCamera = updateVehicleCamera
		elseif p1.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
			local ItemName = p1.ItemName
			function localTable.getInst()
				return HomeItemUIUtils.getModel(ItemName)
			end
			localTable.updateCamera = HomeItemUIUtils.getUpdateCamera()
			localTable.getInstCompare = "HomeItem" .. ItemName
		elseif p1.ItemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
			local SkinName = p1.SkinName
			function localTable.getInst()
				return ItemSkinUIUtils.getModel(SkinName)
			end
			localTable.updateCamera = ItemSkinUIUtils.getUpdateCamera()
			localTable.getInstCompare = "ItemSkin" .. SkinName
		elseif p1.ItemType == PlayerDataConsts.SAFE_ITEM_TYPE then
			local TypeEnum = p1.TypeEnum
			localTable.image = "rbxassetid://" .. tostring(SAFE_DATA[TypeEnum].ImageId)
			localTable.getInstCompare = "Safe" .. tostring(TypeEnum)
		elseif p1.ItemType == PlayerDataConsts.CONSUMABLE_ITEM_TYPE then
			local ItemName = p1.ItemName
			localTable.image = "rbxassetid://" .. tostring(ConsumablesData[ItemName].ImageId)
			localTable.getInstCompare = "Consumable" .. ItemName
		else
			local v4 = error
			v4("Invalid ItemType: " .. tostring(p1.ItemType))
		end
		return localTable
	end
end