local TradeReducerUtils = require(script.Parent.TradeReducerUtils)
return require(game:GetService("ReplicatedStorage").Rodux).createReducer(TradeReducerUtils.getDefaults(), {
    updateTraderMe = TradeReducerUtils.update;
    addTraderMeOfferItem = TradeReducerUtils.addItem;
    removeTraderMeOfferItem = TradeReducerUtils.removeItem;
    removeTraderMeOfferItemByIndex = TradeReducerUtils.removeItemByIndex;
})