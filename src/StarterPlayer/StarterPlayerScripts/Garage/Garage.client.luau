local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local store = require(ReplicatedStorage.App.store)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_OWNED_REMOTE_NAME).OnClientEvent:Connect(function(ownershipData)
	local configTable = {}
	for configKey, configValue in pairs(ownershipData) do
		if configKey ~= "CustomizationSlots" then
			configTable[configKey] = configValue
		end
	end
	for categoryKey in pairs(OwnershipConsts.COLOR_CATEGORY_TYPES) do
		configTable[categoryKey] = configTable.Color
	end
	configTable.Color = nil
	for textureKey in pairs(OwnershipConsts.TEXTURE_CATEGORY_TYPES) do
		configTable[textureKey] = configTable.Texture
	end
	store:dispatch({
		type = "setOwnedRaw",
		owned = configTable
	})
	store:dispatch({
		type = "setSavesRaw",
		saves = ownershipData.CustomizationSlots
	})
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_EQUIPPED_REMOTE_NAME).OnClientEvent:Connect(function(equippedData)
	store:dispatch({
		type = "setEquippedRaw",
		equipped = equippedData
	})
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_FAVORITED_REMOTE_NAME).OnClientEvent:Connect(function(favoritedData)
	store:dispatch({
		type = "setFavoritedRaw",
		favorited = favoritedData
	})
end)
ReplicatedStorage:WaitForChild(GarageConsts.SET_IN_PHYSICAL_REMOTE_NAME).OnClientEvent:Connect(function(inPhysicalStatus)
	store:dispatch({
		type = "setInPhysical",
		inPhysical = inPhysicalStatus
	})
end)
local PopularSort = require(ReplicatedStorage.Garage.PopularSort)
ReplicatedStorage:WaitForChild(GarageConsts.FILL_POPULAR_SORT_REMOTE_NAME).OnClientEvent:Connect(function(popularSortData)
	PopularSort.setRaw(popularSortData)
end)
