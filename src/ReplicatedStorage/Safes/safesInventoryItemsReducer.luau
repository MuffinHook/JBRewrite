local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local SAFE_DATA = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
return Rodux.createReducer({}, {
	setSafesInventoryItems = function(state, action)
		assert(action.itemsOwned ~= nil, "missing itemsOwned")
		local inventoryItems = {}
		for itemTypeEnum, itemData in action.itemsOwned do
			local hasSafeData
			assert(itemData.Id, "missing Id")
			local TypeEnum = itemData.TypeEnum
			local safeTierData = SAFE_DATA[TypeEnum]
			hasSafeData = safeTierData ~= nil
			assert(hasSafeData, "missing safeTierData")
			table.insert(inventoryItems, {
				name = ("%s_%s"):format(TypeEnum, itemTypeEnum),
				typeEnum = TypeEnum,
				imageId = safeTierData.ImageId,
				itemOwnedId = itemData.Id
			})
		end
		return inventoryItems
	end
})
