local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunShopConsts_upvr = require(script.Parent.GunShopConsts)
local module_upvr = {
    onAnyOwned = require(ReplicatedStorage.Std.Signal).new();
    itemsValue = nil;
}
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
local Region_upvr = require(ReplicatedStorage.Std.Region)
local RegionUtils_upvr = require(ReplicatedStorage.Std.Region.RegionUtils)
local CollectionService_upvr = game:GetService("CollectionService")
local RunService_upvr = game:GetService("RunService")
function module_upvr.init() -- Line 23
    waitForChild_upvr(LocalPlayer_upvr, GunShopConsts_upvr.ITEMS_VALUE_NAME):andThen(function(arg1) -- Line 25
        module_upvr.itemsValue = arg1
        arg1.ChildAdded:Connect(function(arg1_2) -- Line 28
            module_upvr.onAnyOwned:Fire(arg1_2.Name)
        end)
    end):catch(warn)
    local GunShopUI_upvr = require(script.Parent.GunShopUI)
    local any_new_result1_upvr = Region_upvr.new(RegionUtils_upvr.ConditionPlayer)
    any_new_result1_upvr.OnObjAdded:Connect(function() -- Line 37
        if not GunShopUI_upvr.isOpen() then
            GunShopUI_upvr.open()
        end
    end)
    any_new_result1_upvr.OnObjRemoved:Connect(function() -- Line 42
        if GunShopUI_upvr.isOpen() then
            GunShopUI_upvr.close()
        end
    end)
    local function updatePrisms() -- Line 49
        any_new_result1_upvr.Prisms = {}
        for _, v in ipairs(CollectionService_upvr:GetTagged("GunShopRegion")) do
            any_new_result1_upvr:AddPart(v)
        end
    end
    updatePrisms()
    CollectionService_upvr:GetInstanceAddedSignal("GunShopRegion"):Connect(updatePrisms)
    CollectionService_upvr:GetInstanceRemovedSignal("GunShopRegion"):Connect(updatePrisms)
    local tick_result1_upvw = tick()
    RunService_upvr.Heartbeat:Connect(function() -- Line 62
        local tick_result1 = tick()
        if tick_result1 - tick_result1_upvw < 0.5 then
        else
            tick_result1_upvw = tick_result1
            any_new_result1_upvr:Update({LocalPlayer_upvr}, true)
        end
    end)
end
function module_upvr.doesPlayerOwn(arg1) -- Line 71
    local var25
    if LocalPlayer_upvr:WaitForChild(GunShopConsts_upvr.ITEMS_VALUE_NAME):FindFirstChild(arg1) == nil then
        var25 = false
    else
        var25 = true
    end
    return var25
end
return module_upvr