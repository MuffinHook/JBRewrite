local TradeReducerUtils = require(script.Parent.TradeReducerUtils)
return require(game:GetService("ReplicatedStorage").Rodux).createReducer(TradeReducerUtils.getDefaults(), {
    updateTraderThem = TradeReducerUtils.update;
})