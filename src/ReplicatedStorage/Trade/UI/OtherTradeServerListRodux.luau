local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OtherTradeServerList = require(script.Parent.OtherTradeServerList)
local store = require(ReplicatedStorage.App.store)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
return RoactRodux.connect(function(reduxState, dispatch)
	return reduxState.otherTradeServerListConfig
end, function(dispatch)
	return {
		onJoinOtherTradeServer = function(serverId)
			store:dispatch({
				type = "setOtherTradeServerListVisible",
				visible = false
			})
			if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then
				ReplicatedStorage:FindFirstChild(TradeConsts.JOIN_OTHER_TRADE_SERVER_REMOTE_NAME):FireServer(serverId)
			else
				local PassId = GamepassUtils.GetGamepassFromEnum(GamepassUtils.EnumGamepass.TradingVIP).PassId
				MarketplaceService:PromptGamePassPurchase(Players.LocalPlayer, PassId)
			end
		end
	}
end)(OtherTradeServerList)
