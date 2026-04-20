local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local C4Consts_upvr = require(script.Parent.C4Consts)
local function closestPointToPart_upvr(arg1, arg2) -- Line 14, Named "closestPointToPart"
    local any_PointToObjectSpace_result1 = arg2.CFrame:PointToObjectSpace(arg1)
    return arg2.CFrame * Vector3.new(math.clamp(any_PointToObjectSpace_result1.X, -arg2.Size.X * 0.5, arg2.Size.X * 0.5), math.clamp(any_PointToObjectSpace_result1.Y, -arg2.Size.Y * 0.5, arg2.Size.Y * 0.5), math.clamp(any_PointToObjectSpace_result1.Z, -arg2.Size.Z * 0.5, arg2.Size.Z * 0.5))
end
local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.__ClassName = "C4"
setmetatable(module_upvr, BaseObject_upvr)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr.new(arg1) -- Line 27
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr._maid = Maid_upvr.new()
    any_new_result1_upvr.maid = any_new_result1_upvr._maid
    any_new_result1_upvr._obj = arg1
    any_new_result1_upvr.obj = arg1
    any_new_result1_upvr._stickRemote = arg1:WaitForChild(C4Consts_upvr.STICK_REMOTE_NAME)
    any_new_result1_upvr._detonateRemote = arg1:WaitForChild(C4Consts_upvr.DETONATE_REMOTE_NAME)
    any_new_result1_upvr._stuckValue = arg1:WaitForChild(C4Consts_upvr.STUCK_VALUE_NAME)
    any_new_result1_upvr._maid:GiveTask(any_new_result1_upvr._stuckValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line 44
        if any_new_result1_upvr._stuckValue.Value then
            Audio_upvr.ObjectLocal(any_new_result1_upvr._obj.PrimaryPart, 6036721389, {
                TimePosition = 0.1;
            })
            Audio_upvr.ObjectLocal(any_new_result1_upvr._obj.PrimaryPart, 6036730402, {
                RollOffMaxDistance = 24;
                RollOffMinDistance = 8;
                Volume = 0.3;
                Looped = true;
            })
        end
    end))
    any_new_result1_upvr._creatorIdValue = arg1:WaitForChild(C4Consts_upvr.CREATOR_ID_VALUE_NAME)
    any_new_result1_upvr._detonatedValue = arg1:WaitForChild(C4Consts_upvr.DETONATED_VALUE_NAME)
    any_new_result1_upvr._locallyDetonated = false
    return any_new_result1_upvr
end
function module_upvr.GetStuck(arg1) -- Line 68
    local _locallyStuck = arg1._locallyStuck
    if not _locallyStuck then
        _locallyStuck = arg1._stuckValue
        _locallyStuck = _locallyStuck.Value
    end
    return _locallyStuck
end
function module_upvr.GetCreator(arg1) -- Line 71
    return Players_upvr:GetPlayerByUserId(arg1._creatorIdValue.Value)
end
function module_upvr.Detonate(arg1, arg2) -- Line 76
    arg1._detonateRemote:FireServer(arg2)
    arg1._locallyDetonated = true
    Promise_upvr.delay(1):andThen(function() -- Line 81
        arg1._locallyDetonated = arg1._detonatedValue.Value
    end)
end
function module_upvr.GetDetonated(arg1) -- Line 85
    local _locallyDetonated = arg1._locallyDetonated
    if not _locallyDetonated then
        _locallyDetonated = arg1._detonatedValue
        _locallyDetonated = _locallyDetonated.Value
    end
    return _locallyDetonated
end
function module_upvr.SetVelocity(arg1, arg2) -- Line 88
    if arg2 == nil then
    else
    end
    assert(true)
    arg1._obj.PrimaryPart.Velocity = arg2
end
function module_upvr.SetRotVelocity(arg1, arg2) -- Line 93
    if arg2 == nil then
    else
    end
    assert(true)
    arg1._obj.PrimaryPart.RotVelocity = arg2
end
function module_upvr.IsListening(arg1) -- Line 98
    local var18
    if arg1._maid.attach == nil then
        var18 = false
    else
        var18 = true
    end
    return var18
end
local LocalPlayer_upvr = Players_upvr.LocalPlayer
function module_upvr.ListenForAttach(arg1) -- Line 101
    if arg1:GetStuck() then
    else
        arg1._maid.attach = arg1._obj.PrimaryPart.Touched:Connect(function(arg1_2) -- Line 105
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            if arg1_2:IsDescendantOf(arg1._obj) then
            else
                if LocalPlayer_upvr.Character and arg1_2:IsDescendantOf(LocalPlayer_upvr.Character) then return end
                if not arg1_2.CanCollide then return end
                arg1._locallyStuck = true
                arg1._maid.attach = nil
                Promise_upvr.delay(1):andThen(function() -- Line 118
                    arg1._locallyStuck = arg1._stuckValue.Value
                end)
                local RaycastParams_new_result1 = RaycastParams.new()
                local tbl = {}
                tbl[1] = arg1_2
                RaycastParams_new_result1.FilterDescendantsInstances = tbl
                RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Whitelist
                local PrimaryPart = arg1._obj.PrimaryPart
                local var25 = closestPointToPart_upvr(PrimaryPart.Position, arg1_2) - PrimaryPart.Position
                local var26
                local workspace_Raycast_result1 = workspace:Raycast(PrimaryPart.Position - var25.Unit * 5, var25.Unit * 10, RaycastParams_new_result1)
                if workspace_Raycast_result1 then
                    PrimaryPart.CFrame = CFrame.new(Vector3.new(), workspace_Raycast_result1.Normal) * CFrame.Angles(0, 0, math.random() * 2 * math.pi) + workspace_Raycast_result1.Position
                    var26 = PrimaryPart.CFrame:ToObjectSpace(arg1_2.CFrame)
                else
                    var26 = PrimaryPart.CFrame:ToObjectSpace(arg1_2.CFrame)
                end
                local Anchored = arg1_2.Anchored
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                if Anchored then
                    PrimaryPart.Anchored = true
                else
                    assert(not arg1._tempJoint)
                    local WeldConstraint_upvr = Instance.new("WeldConstraint")
                    WeldConstraint_upvr.Name = C4Consts_upvr.TEMP_WELD_NAME
                    WeldConstraint_upvr.Part0 = PrimaryPart
                    WeldConstraint_upvr.Part1 = arg1_2
                    WeldConstraint_upvr.Parent = PrimaryPart
                    Promise_upvr.delay(0.1):andThen(function() -- Line 161
                        WeldConstraint_upvr:Destroy()
                    end)
                end
                WeldConstraint_upvr = arg1
                WeldConstraint_upvr = WeldConstraint_upvr._stickRemote:FireServer
                WeldConstraint_upvr(arg1_2, var26)
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            end
        end)
    end
end
return module_upvr