local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local InventoryReducerUtils = require(ReplicatedStorage.Trade.InventoryReducerUtils)
return Rodux.createReducer({}, {
	tradeInventorySetItemsOwned = InventoryReducerUtils.setItemsOwned
})