local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local Players_upvr = game:GetService("Players")
function module_upvr.new(arg1) -- Line 15
    local any_new_result1_2_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_2_upvr, module_upvr)
    any_new_result1_2_upvr.motor = arg1:WaitForChild("Pivot"):WaitForChild("TrackingSpotlightMotor")
    any_new_result1_2_upvr._lastDt = os.clock()
    any_new_result1_2_upvr._maxDYaw = 0.6283185307179586
    any_new_result1_2_upvr._lastPitch = 0
    any_new_result1_2_upvr._lastYaw = 0
    any_new_result1_2_upvr._pitchSpring = Spring_upvr.new(any_new_result1_2_upvr._lastPitch, 0, 0.6, 15)
    any_new_result1_2_upvr._yawSpring = Spring_upvr.new(any_new_result1_2_upvr._lastYaw, 0, 0.6, 15)
    any_new_result1_2_upvr.maid:GiveTask(arg1:GetAttributeChangedSignal("TrackingSpotlightTargetUserId"):Connect(function() -- Line 33, Named "updateTarget"
        local TrackingSpotlightTargetUserId_2 = arg1:GetAttribute("TrackingSpotlightTargetUserId")
        local var9
        if TrackingSpotlightTargetUserId_2 then
            var9 = Players_upvr:GetPlayerByUserId(TrackingSpotlightTargetUserId_2)
        else
            var9 = nil
        end
        if var9 then
            any_new_result1_2_upvr:TrackPlayer(var9)
        else
            any_new_result1_2_upvr:StopTracking()
        end
    end))
    local TrackingSpotlightTargetUserId = arg1:GetAttribute("TrackingSpotlightTargetUserId")
    local var11
    if TrackingSpotlightTargetUserId then
        var11 = Players_upvr:GetPlayerByUserId(TrackingSpotlightTargetUserId)
    else
        var11 = nil
    end
    if var11 then
        any_new_result1_2_upvr:TrackPlayer(var11)
        return any_new_result1_2_upvr
    end
    any_new_result1_2_upvr:StopTracking()
    return any_new_result1_2_upvr
end
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
function module_upvr.TrackPlayer(arg1, arg2) -- Line 47
    local any_new_result1 = Maid_upvr.new()
    arg1.maid.trackingMaid = any_new_result1
    any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 50
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        arg1:StopTracking()
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end))
    any_new_result1:GiveTask(function() -- Line 81
        local any_getHumanoid_result1 = CharacterUtils_upvr.getHumanoid(arg2.Character)
        if not any_getHumanoid_result1 then
        else
            any_getHumanoid_result1:SetAttribute("IsInTrackingSpotlight", nil)
        end
    end)
    any_new_result1:GiveTask(function() -- Line 88
        arg1._lastPitch = 0
        arg1._lastYaw = 0
        arg1.motor.C1 = CFrame.new()
    end)
end
function module_upvr.StopTracking(arg1) -- Line 96
    arg1.maid.trackingMaid = nil
end
function module_upvr.MoveTowardsTarget(arg1, arg2) -- Line 99
    local os_clock_result1 = os.clock()
    local var21 = os_clock_result1 - arg1._lastDt
    arg1._lastDt = os_clock_result1
    local Top = arg1.obj:FindFirstChild("Top")
    local any_PointToObjectSpace_result1 = Top:FindFirstChild("Pivot").CFrame:PointToObjectSpace(Top:FindFirstChild("Tip").Position)
    local any_PointToObjectSpace_result1_2 = arg1.obj:FindFirstChild("Pivot").CFrame:PointToObjectSpace(arg2)
    local any_offsetLookAtTarget_result1, any_offsetLookAtTarget_result2 = GeomUtils_upvr.offsetLookAtTarget(any_PointToObjectSpace_result1.x, any_PointToObjectSpace_result1.y, nil, any_PointToObjectSpace_result1_2.x, any_PointToObjectSpace_result1_2.y, any_PointToObjectSpace_result1_2.z)
    arg1._lastPitch += math.clamp(GeomUtils_upvr.shortAngleDist(arg1._lastPitch, any_offsetLookAtTarget_result2), -arg1._maxDYaw * var21, arg1._maxDYaw * var21)
    arg1._lastYaw += math.clamp(GeomUtils_upvr.shortAngleDist(arg1._lastYaw, any_offsetLookAtTarget_result1), -arg1._maxDYaw * var21, arg1._maxDYaw * var21)
    arg1.motor.C1 = CFrame.Angles(0, arg1._yawSpring:SetTarget(arg1._lastYaw), 0) * CFrame.Angles(arg1._pitchSpring:SetTarget(arg1._lastPitch), 0, 0)
end
return require(ReplicatedStorage.Std.Binder).new("TrackingSpotlight", module_upvr)