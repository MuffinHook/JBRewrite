local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.new(arg1, arg2) -- Line 17
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.manifest = arg2
    any_new_result1_upvr.maid:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 23
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        any_new_result1_upvr:_hook()
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if any_new_result1_upvr.maid.running then
            any_new_result1_upvr.maid.running = nil
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end))
    return any_new_result1_upvr
end
function module_upvr._isLocalColliding(arg1) -- Line 36
    local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
    local RaycastParams_new_result1 = RaycastParams.new()
    RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Whitelist
    RaycastParams_new_result1.FilterDescendantsInstances = {arg1.manifest.floor}
    local var12
    if not any_getRootPart_result1 then
        return false
    end
    if workspace:Raycast(any_getRootPart_result1.Position, Vector3.new(0, -20, 0), RaycastParams_new_result1) == nil then
        var12 = false
    else
        var12 = true
    end
    return var12
end
local RunService_upvr = game:GetService("RunService")
function module_upvr._hook(arg1) -- Line 47
    local floor_upvr = arg1.manifest.floor
    local CFrame_upvw = floor_upvr.CFrame
    arg1.maid.running = RunService_upvr.Heartbeat:Connect(function() -- Line 50
        local any_getRootPart_result1_2 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
        local CFrame = floor_upvr.CFrame
        any_getRootPart_result1_2.CFrame = CFrame * CFrame_upvw:Inverse() * any_getRootPart_result1_2.CFrame
        CFrame_upvw = CFrame
    end)
end
return require(ReplicatedStorage.ManifestBinder).new("Elevator", {
    floor = "Car/InnerModel/Floor";
}, module_upvr)