local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OtherTradeServerList = require(script.Parent.OtherTradeServerList)
local store = require(ReplicatedStorage.App.store)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
return RoactRodux.connect(function(p1, p2) --[[ Line: 11 ]]
	return p1.otherTradeServerListConfig
end, function(p1) --[[ Line: 13 | Upvalues: store (copy), GamepassSystem (copy), GamepassUtils (copy), MarketplaceService (copy), Players (copy), ReplicatedStorage (copy), TradeConsts (copy) ]]
	return {
		onJoinOtherTradeServer = function(p1) --[[ Name: onJoinOtherTradeServer | Line: 15 | Upvalues: store (ref), GamepassSystem (ref), GamepassUtils (ref), MarketplaceService (ref), Players (ref), ReplicatedStorage (ref), TradeConsts (ref) ]]
			store:dispatch({
				type = "setOtherTradeServerListVisible",
				visible = false
			})
			if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then
				ReplicatedStorage:FindFirstChild(TradeConsts.JOIN_OTHER_TRADE_SERVER_REMOTE_NAME):FireServer(p1)
			else
				local PassId = GamepassUtils.GetGamepassFromEnum(GamepassUtils.EnumGamepass.TradingVIP).PassId
				MarketplaceService:PromptGamePassPurchase(Players.LocalPlayer, PassId)
			end
		end
	}
end)(OtherTradeServerList)