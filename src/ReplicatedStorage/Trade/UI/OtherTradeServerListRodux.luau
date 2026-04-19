-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMiGm90aGVyVHJhZGVTZXJ2ZXJMaXN0Q29uZmlnBHR5cGUHdmlzaWJsZR5zZXRPdGhlclRyYWRlU2VydmVyTGlzdFZpc2libGUIZGlzcGF0Y2gNRG9lc1BsYXllck93bgxFbnVtR2FtZXBhc3MKVHJhZGluZ1ZJUBNHZXRHYW1lcGFzc0Zyb21FbnVtBlBhc3NJZAtMb2NhbFBsYXllchZQcm9tcHRHYW1lUGFzc1B1cmNoYXNlI0pPSU5fT1RIRVJfVFJBREVfU0VSVkVSX1JFTU9URV9OQU1FDkZpbmRGaXJzdENoaWxkCkZpcmVTZXJ2ZXIWb25Kb2luT3RoZXJUcmFkZVNlcnZlcgRnYW1lEk1hcmtldHBsYWNlU2VydmljZQpHZXRTZXJ2aWNlB1BsYXllcnMRUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQZzY3JpcHQGUGFyZW50FE90aGVyVHJhZGVTZXJ2ZXJMaXN0A0FwcAVzdG9yZQhHYW1lcGFzcw5HYW1lcGFzc1N5c3RlbQ1HYW1lcGFzc1V0aWxzClJvYWN0Um9kdXgFVHJhZGULVHJhZGVDb25zdHMHY29ubmVjdAAEAwIAAAAAA00CAMwAAAAAggICAAEDAQALAAEYAAAADAAAAAAHAQcAAAA1+wEAAOIDAgBvBAMAMAQDcQAAAACpBAAAMAQDoAEAAAC8AQFMBAAAAJ8BAwH7AQEATQEBGwUAAAD7AgIATQICjQYAAABNAgI8BwAAAJ8BAgIrARQA+wICAE0CAq4IAAAA+wMCAE0DA40GAAAATQMDPAcAAACfAgICTQICkAkAAAD7AwMA+wUEAE0FBTEKAAAAUgYCALwDA+MLAAAAnwMEAYIAAQD7AgUA+wQGAE0EBIAMAAAAvAICAw0AAACfAgMCUgQAALwCAmsOAAAAnwIDAYIAAQAPAwIDAwUCAAEDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8ADxABGAAAAQAAAQAA/gAABAAAAAAAAAAAAQEAAAAAAAAAAAAAAQAAAAAAAAABAgAAAAAAAAEAAAABEAAAAAADAQcAAAAM4gEBAMACAgASAgAAEgIBABICAgASAgMAEgIEABICBQASAgYAMAIB/wAAAACCAQIAAwMQBQEABgEBAQ0AARgAAQAAAAAAAAAAAAAOAAAAAAwAAAECAEyjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAUAvAICFgMAAACfAgMCpAMHAAAAYECkBAkAAACAQE0EBCQKAAAATQQEnQsAAACfAwICpAQHAAAAYEBNBQLBDAAAAE0FBX4NAAAAnwQCAqQFBwAAAGBATQYCvQ4AAABNBgaODwAAAJ8FAgKkBgcAAABgQE0HAr0OAAAATQcHPhAAAACfBgICpAcHAAAAYEBNCAItEQAAAJ8HAgKkCAcAAABgQE0JArsSAAAATQkJkRMAAACfCAICTQkH5xQAAADAChUAwAsWABIABAASAAUAEgAGABIAAAASAAEAEgACABIACACfCQMCUgoDAJ8JAgCCCQAAFwMRBAAAAEADEgMTAxQDFQMWBAAAYEADFwQAAIBAAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgYABgICAAIBAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAQAAAAAAAAIAAAIAAAAAAAAA/hMAAAEAAAAAA6fQjIebUDZTDZCHlLNVuP/XyJvzlRTmhg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:32
-- Luau version 6, Types version 3
-- Time taken: 0.002421 seconds

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
    --[[ Upvalues[7]:
        [1]: store_upvr (readonly)
        [2]: GamepassSystem_upvr (readonly)
        [3]: GamepassUtils_upvr (readonly)
        [4]: MarketplaceService_upvr (readonly)
        [5]: Players_upvr (readonly)
        [6]: ReplicatedStorage_upvr (readonly)
        [7]: TradeConsts_upvr (readonly)
    ]]
    return {
        onJoinOtherTradeServer = function(arg1_2) -- Line 15, Named "onJoinOtherTradeServer"
            --[[ Upvalues[7]:
                [1]: store_upvr (copied, readonly)
                [2]: GamepassSystem_upvr (copied, readonly)
                [3]: GamepassUtils_upvr (copied, readonly)
                [4]: MarketplaceService_upvr (copied, readonly)
                [5]: Players_upvr (copied, readonly)
                [6]: ReplicatedStorage_upvr (copied, readonly)
                [7]: TradeConsts_upvr (copied, readonly)
            ]]
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