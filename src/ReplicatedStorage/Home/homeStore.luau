local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
return Rodux.Store.new(Rodux.combineReducers({
	cash = require(ReplicatedStorage.App.cashReducer),
	items = require(ReplicatedStorage.Home.Reducer.itemsReducer),
	visible = require(ReplicatedStorage.Home.Reducer.visibleReducer),
	inventory = require(ReplicatedStorage.Home.Reducer.inventoryReducer),
	equipped = require(ReplicatedStorage.Home.Reducer.equippedReducer),
	quantityPlaced = require(ReplicatedStorage.Home.Reducer.quantityPlacedReducer),
	savedSettings = require(ReplicatedStorage.Home.Reducer.savedSettingsReducer),
	home = require(ReplicatedStorage.Home.Reducer.homeReducer)
}))
