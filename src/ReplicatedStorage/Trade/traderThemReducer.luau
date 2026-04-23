local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local TradeReducerUtils = require(script.Parent.TradeReducerUtils)
return Rodux.createReducer(TradeReducerUtils.getDefaults(), {
	updateTraderThem = TradeReducerUtils.update
})