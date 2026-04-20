local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local Players_upvr = game:GetService("Players")
local TradeConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeConsts)
return require(ReplicatedStorage_upvr.RoactRodux).connect(function(arg1, arg2) -- Line 11
    return arg1.otherTradeServerListConfig
end, function(arg1) -- Line 13
    return {
        onJoinOtherTradeServer = function(arg1_2) -- Line 15, Named "onJoinOtherTradeServer"
            store_upvr:dispatch({
                type = "setOtherTradeServerListVisible";
                visible = false;
            })
            if not GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.TradingVIP) then
                MarketplaceService_upvr:PromptGamePassPurchase(Players_upvr.LocalPlayer, GamepassUtils_upvr.GetGamepassFromEnum(GamepassUtils_upvr.EnumGamepass.TradingVIP).PassId)
            else
                ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.JOIN_OTHER_TRADE_SERVER_REMOTE_NAME):FireServer(arg1_2)
            end
        end;
    }
end)(require(script.Parent.OtherTradeServerList))