local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
    tradeInventorySetItemsOwned = require(ReplicatedStorage.Trade.InventoryReducerUtils).setItemsOwned;
})