-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local store = require(ReplicatedStorage.App.store)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_OWNED_REMOTE_NAME).OnClientEvent:Connect(function(p1)
	local configTable = {}
	for k, v in pairs(p1) do
		if k ~= "CustomizationSlots" then
			configTable[k] = v
		end
	end
	for k in pairs(OwnershipConsts.COLOR_CATEGORY_TYPES) do
		configTable[k] = configTable.Color
	end
	configTable.Color = nil
	for k in pairs(OwnershipConsts.TEXTURE_CATEGORY_TYPES) do
		configTable[k] = configTable.Texture
	end
	store:dispatch({
		type = "setOwnedRaw",
		owned = configTable
	})
	store:dispatch({
		type = "setSavesRaw",
		saves = p1.CustomizationSlots
	})
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_EQUIPPED_REMOTE_NAME).OnClientEvent:Connect(function(p1)
	store:dispatch({
		type = "setEquippedRaw",
		equipped = p1
	})
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_FAVORITED_REMOTE_NAME).OnClientEvent:Connect(function(p1)
	store:dispatch({
		type = "setFavoritedRaw",
		favorited = p1
	})
end)
ReplicatedStorage:WaitForChild(GarageConsts.SET_IN_PHYSICAL_REMOTE_NAME).OnClientEvent:Connect(function(p1)
	store:dispatch({
		type = "setInPhysical",
		inPhysical = p1
	})
end)
local PopularSort = require(ReplicatedStorage.Garage.PopularSort)
ReplicatedStorage:WaitForChild(GarageConsts.FILL_POPULAR_SORT_REMOTE_NAME).OnClientEvent:Connect(function(p1)
	PopularSort.setRaw(p1)
end)
