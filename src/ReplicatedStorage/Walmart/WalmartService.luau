local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {
    init = function() -- Line 13, Named "init"
    end;
}
local Players_upvr = game:GetService("Players")
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local Binder_upvr = require(ReplicatedStorage_upvr.Std.Binder)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Region_upvr = require(ReplicatedStorage_upvr.Std.Region)
local RegionUtils_upvr = require(ReplicatedStorage_upvr.Std.Region.RegionUtils)
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
function module.setupModel() -- Line 23
    local WalmartBrand = ReplicatedStorage_upvr:WaitForChild("WalmartBrand", 5)
    if not WalmartBrand then
        warn("Could not find WalmartBrand model..")
    else
        WalmartBrand.Parent = workspace
        local WalmartGui_upvr = ReplicatedStorage_upvr:FindFirstChild("StarterGui"):FindFirstChild("WalmartGui")
        if not WalmartGui_upvr then
            warn("Could not find StarterGui/WalmartGui..")
            return
        end
        WalmartGui_upvr.Parent = Players_upvr.LocalPlayer:FindFirstChild("PlayerGui")
        WalmartGui_upvr.Background.Close.Activated:Connect(function() -- Line 43
            WalmartGui_upvr.Enabled = false
        end)
        WalmartGui_upvr.Background.Buy.Activated:Connect(function() -- Line 47
            GamepassUtils_upvr.PromptGamepass(GamepassUtils_upvr.EnumGamepass.Walmart)
        end)
        Binder_upvr.new("WalmartPurchaseRegion", function(arg1) -- Line 51
            local any_new_result1 = Maid_upvr.new()
            local any_new_result1_3_upvr = Maid_upvr.new()
            local any_new_result1_2_upvr = Region_upvr.new(RegionUtils_upvr.ConditionPlayer)
            any_new_result1_2_upvr:AddPart(arg1)
            any_new_result1:GiveTask(any_new_result1_2_upvr)
            any_new_result1:GiveTask(any_new_result1_2_upvr.OnObjAdded:Connect(function(arg1_2) -- Line 58
                any_new_result1_3_upvr:DoCleaning()
                if GamepassSystem_upvr.doesPlayerOwnCached(Players_upvr.LocalPlayer, GamepassUtils_upvr.EnumGamepass.Walmart) then
                else
                    WalmartGui_upvr.Enabled = true
                    any_new_result1_3_upvr:GiveTask(task.delay(2, function() -- Line 66
                    end))
                end
            end))
            any_new_result1:GiveTask(any_new_result1_2_upvr.OnObjRemoved:Connect(function(arg1_3) -- Line 70
                any_new_result1_3_upvr:DoCleaning()
                WalmartGui_upvr.Enabled = false
            end))
            any_new_result1:GiveTask(Interval_upvr.every(0.3333333333333333):Connect(function() -- Line 75
                any_new_result1_2_upvr:Update({Players_upvr.LocalPlayer})
            end))
            return any_new_result1
        end):Start()
        GamepassSystem_upvr.GetGamepassOwnedSignal(GamepassUtils_upvr.EnumGamepass.Walmart):Connect(function() -- Line 83
            WalmartGui_upvr.Enabled = false
        end)
    end
end
return module