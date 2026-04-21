local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage_upvr.Std.BaseObject)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local DoorUtils_upvr = require(ReplicatedStorage_upvr.Door2.DoorUtils)
local CharacterUtils_upvr = require(ReplicatedStorage_upvr.Std.CharacterUtils)
local TransportJetConsts_upvr = require(ReplicatedStorage_upvr.TransportJet.TransportJetConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Confirmation_upvr = require(ReplicatedStorage_upvr.Module.Confirmation)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
function module_upvr.new(arg1) -- Line 28
    local any_new_result1_upvr_2 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr_2, module_upvr)
    local clone = ReplicatedStorage_upvr.TransportJet.Res.TransportJet:Clone()
    clone.Parent = workspace
    any_new_result1_upvr_2.visualModel = clone
    any_new_result1_upvr_2.maid:GiveTask(clone)
    any_new_result1_upvr_2.jetEngineSound = Audio_upvr.ObjectLocal(any_new_result1_upvr_2.visualModel.PrimaryPart, 9553468279, {
        Looped = true;
        RollOffMinDistance = 32;
        RollOffMaxDistance = 512;
        Volume = 0;
        DoNotPlay = true;
    })
    any_new_result1_upvr_2.maid:GiveTask(any_new_result1_upvr_2.jetEngineSound)
    any_new_result1_upvr_2.jetWindSound = Audio_upvr.ObjectLocal(any_new_result1_upvr_2.visualModel.PrimaryPart, 9553467792, {
        Looped = true;
        RollOffMinDistance = 64;
        RollOffMaxDistance = 512;
        Volume = 0;
        DoNotPlay = true;
    })
    any_new_result1_upvr_2.maid:GiveTask(any_new_result1_upvr_2.jetWindSound)
    local var17_upvw = false
    local RequestLaunch = clone:FindFirstChild("RequestLaunch")
    local tbl_2_upvr = {
        Part = RequestLaunch;
        ValidRoot = clone;
        Name = "Launch";
        Timed = false;
        Dist = 7;
        Callback = function(arg1_2, arg2) -- Line 52, Named "action"
            if arg2 then
                local any_getRootPart_result1_upvr = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
                if var17_upvw then return end
                var17_upvw = true
                local any_new_result1_upvr_3 = Confirmation_upvr.new(string.format("Fly across the map for $%s?", TransportJetConsts_upvr.LAUNCH_COST_CASH));
                any_new_result1_upvr_3.Maid:GiveTask(any_new_result1_upvr_3.OnYes:Connect(function() -- Line 62
                    arg1:FindFirstChild(TransportJetConsts_upvr.REQUEST_LAUNCH_REMOTE_NAME):FireServer()
                end))
                any_new_result1_upvr_3.Maid:GiveTask(function() -- Line 66
                    var17_upvw = false
                end)
                local Position_upvr = any_getRootPart_result1_upvr.Position
                any_new_result1_upvr_3.Maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 69
                    if 16 < (Position_upvr - any_getRootPart_result1_upvr.Position).Magnitude then
                        any_new_result1_upvr_3:Destroy()
                    end
                end))
                return true
            end
        end;
    }
    any_new_result1_upvr_2.maid:GiveTask(CircleAction_upvr.Add(tbl_2_upvr, RequestLaunch))
    local any_GetDoorOpen_result1_2 = any_new_result1_upvr_2:GetDoorOpen()
    any_new_result1_upvr_2:SetDoorOpen(any_GetDoorOpen_result1_2)
    tbl_2_upvr.Enabled = any_GetDoorOpen_result1_2
    any_new_result1_upvr_2.maid:GiveTask(arg1:GetAttributeChangedSignal(TransportJetConsts_upvr.DOOR_OPEN_ATTR_NAME):Connect(function() -- Line 90, Named "updateDoorOpen"
        local any_GetDoorOpen_result1 = any_new_result1_upvr_2:GetDoorOpen()
        any_new_result1_upvr_2:SetDoorOpen(any_GetDoorOpen_result1)
        tbl_2_upvr.Enabled = any_GetDoorOpen_result1
    end))
    any_new_result1_upvr_2.maid:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 98
        if any_new_result1_upvr_2:_isLocalStanding() then
            any_new_result1_upvr_2.shouldMovePlayer = true
        else
            any_new_result1_upvr_2.shouldMovePlayer = false
        end
    end))
    any_new_result1_upvr_2.lastCF = nil
    any_new_result1_upvr_2.realRoll = 0
    any_new_result1_upvr_2.maid:GiveTask(RxInstanceUtils_upvr.observeAttribute(arg1, TransportJetConsts_upvr.LAUNCHED_AT_ATTR_NAME, function() -- Line 109
        any_new_result1_upvr_2:_update()
    end))
    any_new_result1_upvr_2.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1, TransportJetConsts_upvr.PATH_POINTS_OBJ_NAME, function(arg1_3, arg2) -- Line 116
        if arg1_3 then
            arg2:GiveTask(arg1_3.Changed:Connect(function() -- Line 118
                any_new_result1_upvr_2:_update()
            end))
        end
        any_new_result1_upvr_2:_update()
    end))
    return any_new_result1_upvr_2
end
function module_upvr._isLocalStanding(arg1) -- Line 129
    local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
    local RaycastParams_new_result1 = RaycastParams.new()
    RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Whitelist
    RaycastParams_new_result1.FilterDescendantsInstances = arg1.visualModel:FindFirstChild("TransportFloors"):GetChildren()
    local var34
    if not any_getRootPart_result1 then
        return false
    end
    if workspace:Raycast(any_getRootPart_result1.Position, Vector3.new(0, -20, 0), RaycastParams_new_result1) == nil then
        var34 = false
    else
        var34 = true
    end
    return var34
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local BezierPath_upvr = require(ReplicatedStorage_upvr.Game.BezierPath)
local GraphUtils_upvr = require(ReplicatedStorage_upvr.Game.Cart.GraphUtils)
local zero_vector3_upvr = Vector3.new()
local CurrentCamera_upvr = workspace.CurrentCamera
local RunService_upvr = game:GetService("RunService")
function module_upvr._update(arg1) -- Line 140
    local any_new_result1 = Maid_upvr.new()
    arg1.maid.runningMaid = any_new_result1
    local SOME_2 = arg1.obj:FindFirstChild(TransportJetConsts_upvr.PATH_POINTS_OBJ_NAME)
    local var45_upvr
    if not SOME_2 then
    else
        local Value = SOME_2.Value
        if not Value then return end
        local any_new_result1_upvr = BezierPath_upvr.new()
        local tbl = {}
        var45_upvr = 1
        for i = 1, #Value:GetChildren(), var45_upvr do
            local var49 = i
            local SOME = Value:FindFirstChild(var49)
            if SOME == nil then
                var49 = false
            else
                var49 = true
            end
            assert(var49, "missing point")
            table.insert(tbl, SOME.Position)
        end
        if 0 >= #tbl then
            var45_upvr = false
        else
            var45_upvr = true
        end
        assert(var45_upvr, "no points for transport jet")
        any_new_result1_upvr:SetPoints(tbl)
        any_new_result1_upvr:SetNodeOffset(Value:GetAttribute(TransportJetConsts_upvr.NODE_OFFSET_START_ATTR_NAME) or 0, (Value:GetAttribute(TransportJetConsts_upvr.NODE_OFFSET_END_ATTR_NAME) or 0) + 1)
        local any_ApproximateLength_result1 = any_new_result1_upvr:ApproximateLength(10000)
        var45_upvr = {}
        local RUNWAY_LENGTH = TransportJetConsts_upvr.RUNWAY_LENGTH
        local TOP_SPEED = TransportJetConsts_upvr.TOP_SPEED
        table.insert(var45_upvr, {
            timeUntil = 10000000000;
            speedStart = 0;
            speedEnd = TOP_SPEED;
        })
        assert(GraphUtils_upvr.constrainLastTimeToReachTarget(var45_upvr, RUNWAY_LENGTH), "cannot constrain last time to reach target")
        table.insert(var45_upvr, {
            timeUntil = 10000000000;
            speedStart = TOP_SPEED;
            speedEnd = TOP_SPEED;
        })
        assert(GraphUtils_upvr.constrainLastTimeToReachTarget(var45_upvr, any_ApproximateLength_result1 - RUNWAY_LENGTH), "cannot constrain last time to reach target")
        table.insert(var45_upvr, {
            timeUntil = 10000000000;
            speedStart = TOP_SPEED;
            speedEnd = 0;
        })
        assert(GraphUtils_upvr.constrainLastTimeToReachTarget(var45_upvr, any_ApproximateLength_result1), "cannot constrain last time to reach target")
        GraphUtils_upvr.cap(var45_upvr)
        local timeUntil_upvr = var45_upvr[#var45_upvr - 1].timeUntil
        local var58_upvw
        local os_clock_result1_2_upvw = os.clock()
        local function setFlightElapsed_upvr(arg1_4) -- Line 187, Named "setFlightElapsed"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local os_clock_result1_3 = os.clock()
            local any_GetWorldPositionAt_result1, any_GetWorldPositionAt_result2_2 = any_new_result1_upvr:GetWorldPositionAt(GraphUtils_upvr.calculateDist(var45_upvr, arg1_4))
            local var72 = timeUntil_upvr - arg1_4
            local var73
            if var58_upvw then
                var73 = os_clock_result1_2_upvw
                local var74 = (any_GetWorldPositionAt_result1 - var58_upvw).Magnitude / (os_clock_result1_3 - var73)
                var73 = math.clamp(var74 / 100, 0, 1)
                arg1.jetEngineSound.Volume = var73 * 0.8
                var73 = math.clamp(var74 / 100, 0, 1) * 0.2
                arg1.jetEngineSound.PlaybackSpeed = var73 + 0.8
                var73 = math.clamp(var74 / 25, 0, 1)
                arg1.jetWindSound.Volume = var73 * 1
            end
            os_clock_result1_2_upvw = os_clock_result1_3
            var58_upvw = any_GetWorldPositionAt_result1
            if var72 < 1 then
                var73 = 0
            else
                var73 = math.acos(arg1.visualModel.PrimaryPart.CFrame.LookVector:Dot(any_GetWorldPositionAt_result2_2.Unit)) * 10
            end
            if var72 < 1 then
            else
            end
            var73 = CFrame.lookAt(zero_vector3_upvr, any_GetWorldPositionAt_result2_2) * CFrame.Angles(0, 0, arg1:StepRoll(var73, 0.01))
            local var75 = var73 + any_GetWorldPositionAt_result1
            var73 = arg1
            var73 = var73.shouldMovePlayer
            if var73 then
                var73 = CharacterUtils_upvr
                var73 = var73.getRootPart(Players_upvr.LocalPlayer.Character)
                if var73 and arg1.lastCF then
                    local var76 = var75 * arg1.lastCF:Inverse()
                    var73.CFrame = var76 * var73.CFrame
                    local any_ToObjectSpace_result1 = CurrentCamera_upvr.CFrame:ToObjectSpace(CurrentCamera_upvr.Focus)
                    CurrentCamera_upvr.CFrame = CurrentCamera_upvr.CFrame * any_ToObjectSpace_result1 * (var76 - var76.p) * any_ToObjectSpace_result1:Inverse()
                end
            end
            var73 = arg1
            var73.lastCF = var75
            var73 = arg1
            var73 = var73.visualModel:PivotTo
            var73(var75)
        end
        local any_getDuration_result1_upvr = DoorUtils_upvr.getDuration(arg1.visualModel:FindFirstChild("Door"))
        any_new_result1:GiveTask(task.delay(any_getDuration_result1_upvr + timeUntil_upvr * 0.5, function() -- Line 231
            Audio_upvr.ObjectLocal(arg1.visualModel.PrimaryPart, 9553470967)
        end))
        arg1.jetEngineSound.Volume = 0
        arg1.jetEngineSound:Play()
        arg1.jetWindSound.Volume = 0
        arg1.jetWindSound:Play()
        any_new_result1:GiveTask(function() -- Line 240
            arg1.jetEngineSound:Stop()
            arg1.jetWindSound:Stop()
        end)
        local var82_upvr = (os.clock()) + (arg1.obj:GetAttribute(TransportJetConsts_upvr.LAUNCHED_AT_ATTR_NAME) - workspace:GetServerTimeNow())
        local var83_upvw = false
        local var84_upvw = true
        any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 246
            local var89 = os.clock() - var82_upvr
            local var90
            local var91
            if var89 < var91 then
                var90 = 0
            else
                var91 = any_getDuration_result1_upvr + timeUntil_upvr
                if var91 < var89 then
                    var90 = timeUntil_upvr
                else
                    var91 = any_getDuration_result1_upvr
                    var90 = var89 - var91
                end
            end
            var91 = false
            if any_getDuration_result1_upvr < var89 then
                if var89 >= any_getDuration_result1_upvr + timeUntil_upvr then
                    var91 = false
                else
                    var91 = true
                end
            end
            if var91 ~= var83_upvw then
                var83_upvw = var91
                local ipairs_result1, ipairs_result2, ipairs_result3 = ipairs(arg1.visualModel:FindFirstChild("Turbines"):GetChildren())
                for _, v in ipairs_result1, ipairs_result2, ipairs_result3 do
                    v:SetAttribute("SpinnerEnabled", var83_upvw)
                    DoorUtils_upvr.getInnerModel(v):FindFirstChild("Turbine"):FindFirstChildWhichIsA("Attachment"):FindFirstChildWhichIsA("ParticleEmitter").Enabled = var83_upvw
                end
            end
            ipairs_result1 = false
            local var95 = ipairs_result1
            if any_getDuration_result1_upvr + 2 < var89 then
                if var89 >= any_getDuration_result1_upvr + timeUntil_upvr - 2 then
                    var95 = false
                else
                    var95 = true
                end
            end
            if var95 ~= var84_upvw then
                var84_upvw = var95
                DoorUtils_upvr.setOpen(arg1.visualModel:FindFirstChild("FrontLandingGear"), var84_upvw)
                DoorUtils_upvr.setOpen(arg1.visualModel:FindFirstChild("RearLandingGear"), var84_upvw)
            end
            setFlightElapsed_upvr(var90)
            if any_getDuration_result1_upvr * 2 + timeUntil_upvr < var89 then
                arg1:_stopRunning()
            end
        end))
    end
end
function module_upvr._stopRunning(arg1) -- Line 286
    arg1.maid.runningMaid = nil
end
function module_upvr.StepRoll(arg1, arg2, arg3) -- Line 289
    if arg2 ~= arg2 then
    end
    local var96 = arg1.realRoll or 0
    local var97 = var96 + (0 - var96) * arg3
    arg1.realRoll = var97
    return var97
end
function module_upvr.SetDoorOpen(arg1, arg2) -- Line 298
    local Door = arg1.visualModel:FindFirstChild("Door")
    DoorUtils_upvr.setOpen(Door, arg2)
    Audio_upvr.ObjectLocal(Door.PrimaryPart, 4487204926)
end
function module_upvr.GetDoorOpen(arg1) -- Line 303
    local var99
    if arg1.obj:GetAttribute(TransportJetConsts_upvr.DOOR_OPEN_ATTR_NAME) ~= true then
        var99 = false
    else
        var99 = true
    end
    return var99
end
return require(ReplicatedStorage_upvr.Std.Binder).new(TransportJetConsts_upvr.TAG_NAME, module_upvr)