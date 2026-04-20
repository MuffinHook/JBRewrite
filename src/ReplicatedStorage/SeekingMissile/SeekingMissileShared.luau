local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeekingMissileUtils_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileUtils)
local module_upvr = {}
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_upvr._init(arg1) -- Line 14
    arg1._throttle = 1
    arg1.forwardDrag = SeekingMissileUtils_upvr.getForwardDrag(arg1.obj)
    arg1.lateralDrag = SeekingMissileUtils_upvr.getLateralDrag(arg1.obj)
    arg1.ignoreList = {arg1.obj}
    arg1.raycastParams = RaycastParams.new()
    arg1.raycastParams.FilterDescendantsInstances = arg1.ignoreList
    arg1._lastTargetPosition = nil
    arg1._seeking = false
    arg1._onFireExplodeRemote = Signal_upvr.new()
    arg1.maid:GiveTask(arg1._onFireExplodeRemote)
    arg1.onExploded = Signal_upvr.new()
    arg1.maid:GiveTask(arg1.onExploded)
    arg1.flagApplyingThrust = false
    arg1.onApplyingThrustChanged = Signal_upvr.new()
    arg1.maid:GiveTask(arg1.onApplyingThrustChanged)
end
function module_upvr._getTargetPosition(arg1) -- Line 36
    local any_getTargetPos_result1 = SeekingMissileUtils_upvr.getTargetPos(arg1.obj)
    local Value_2 = arg1.targetPartObj.Value
    if Value_2 then
        any_getTargetPos_result1 = Value_2.Position
    end
    return any_getTargetPos_result1
end
local RunService_upvr = game:GetService("RunService")
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
function module_upvr._run(arg1) -- Line 46
    arg1.lastDistance = math.huge
    arg1.lastDistanceImprovement = 0
    local var11_upvw = 0
    local os_clock_result1_upvr = os.clock()
    local Position_upvw = arg1.obj.Position
    local var14_upvw = false
    local var15_upvw = false
    local var16_upvw = false
    arg1.runMaid:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 57
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local any__getTargetPosition_result1 = module_upvr._getTargetPosition(arg1)
        local var19
        if any__getTargetPosition_result1 == nil then
            var19 = false
        else
            var19 = true
        end
        assert(var19, "missing targetPosition")
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var19 = arg1
        var19._lastTargetPosition = any__getTargetPosition_result1
        var19 = arg1.obj.CFrame:VectorToObjectSpace(arg1.obj.AssemblyLinearVelocity)
        local var20 = any__getTargetPosition_result1 - any__getTargetPosition_result1
        var11_upvw = (var11_upvw * 24 + var20.Magnitude / arg1_2) / 25
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end))
    arg1.alignOrientation.MaxTorque = 10000000000000
    arg1.runMaid:GiveTask(function() -- Line 214
        arg1.vectorForce.Force = Vector3.new()
        arg1.alignOrientation.MaxTorque = 0
    end)
end
function module_upvr._explode(arg1) -- Line 219
    if arg1._didExplode then
    else
        arg1._didExplode = true
        local Value = arg1.targetPartObj.Value
        local var23
        if Value then
            var23 = Value.CFrame:PointToObjectSpace(arg1.obj.Position)
        end
        arg1.onExploded:Fire(arg1.obj.Position, Value, var23)
        task.defer(arg1.runMaid.DoCleaning, arg1.runMaid)
    end
end
function module_upvr._detectHit(arg1) -- Line 232
    if arg1._didExplode then
    else
        arg1.runMaid:GiveTask(arg1.obj.Touched:Connect(function(arg1_3) -- Line 236
            if 0.5 < arg1_3.Transparency then
            else
                for _, v in arg1.ignoreList do
                    if arg1_3:IsDescendantOf(v) then
                        return false
                    end
                end
                module_upvr._explode(arg1)
            end
        end))
    end
end
function module_upvr._enableSeeking(arg1) -- Line 251
    arg1._seeking = true
end
return module_upvr