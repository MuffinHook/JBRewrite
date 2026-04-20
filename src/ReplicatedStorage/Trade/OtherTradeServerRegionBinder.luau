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
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    arg1.Parent = ReplicatedStorage_upvr
    local any_getPrism_result1_upvr = RegionUtils_upvr.getPrism(arg1.CFrame, arg1.Size)
    local var11_upvw = false
    any_new_result1.maid:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 24
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