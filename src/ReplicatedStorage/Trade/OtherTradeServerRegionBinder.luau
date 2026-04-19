-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:11
-- Luau version 6, Types version 3
-- Time taken: 0.002162 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage_upvr.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RegionUtils_upvr = require(ReplicatedStorage_upvr.Std.Region.RegionUtils)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local Players_upvr = game:GetService("Players")
local store_upvr = require(ReplicatedStorage_upvr.App.store)
function module_upvr.new(arg1) -- Line 17
    --[[ Upvalues[7]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: RegionUtils_upvr (readonly)
        [4]: ReplicatedStorage_upvr (readonly)
        [5]: Interval_upvr (readonly)
        [6]: Players_upvr (readonly)
        [7]: store_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    arg1.Parent = ReplicatedStorage_upvr
    local any_getPrism_result1_upvr = RegionUtils_upvr.getPrism(arg1.CFrame, arg1.Size)
    local var11_upvw = false
    any_new_result1.maid:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 24
        --[[ Upvalues[5]:
            [1]: Players_upvr (copied, readonly)
            [2]: RegionUtils_upvr (copied, readonly)
            [3]: any_getPrism_result1_upvr (readonly)
            [4]: var11_upvw (read and write)
            [5]: store_upvr (copied, readonly)
        ]]
        local Character = Players_upvr.LocalPlayer.Character
        if not Character then
        else
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart then return end
            local any_CastPoint_result1 = RegionUtils_upvr.CastPoint(any_getPrism_result1_upvr, HumanoidRootPart.Position)
            if any_CastPoint_result1 ~= var11_upvw then
                var11_upvw = any_CastPoint_result1
                store_upvr:dispatch({
                    type = "setOtherTradeServerListVisible";
                    value = any_CastPoint_result1;
                })
            end
        end
    end))
    return any_new_result1
end
return require(ReplicatedStorage_upvr.Std.Binder).new(require(ReplicatedStorage_upvr.Trade.TradeConsts).OTHER_TRADE_SERVER_LIST_REGION_TAG_NAME, module_upvr)