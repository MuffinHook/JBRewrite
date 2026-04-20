local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local JetConsts_upvr = require(ReplicatedStorage.Game.Plane.JetConsts)
local var6_upvw
local random_state_upvr = Random.new()
local function _(arg1) -- Line 27, Named "RandomVector"
    return Vector3.new(arg1 * (random_state_upvr:NextNumber() * 2 - 1), arg1 * (random_state_upvr:NextNumber() * 2 - 1), arg1 * (random_state_upvr:NextNumber() * 2 - 1))
end
local module_upvr = {
    __ClassName = "Jet";
}
module_upvr.__index = module_upvr
local var9_upvw
function module_upvr.Init(arg1) -- Line 38
    var6_upvw = arg1.Event
    var9_upvw = arg1.em
end
local BaseUserControlledPlane_upvr = require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane)
function module_upvr.new(arg1) -- Line 41
    local setmetatable_result1_upvr = setmetatable({}, module_upvr)
    setmetatable_result1_upvr.Meta = arg1
    setmetatable_result1_upvr.Model = arg1.Model
    setmetatable_result1_upvr.Plane = BaseUserControlledPlane_upvr.new(arg1, {
        SUSPENSION_HEIGHT_FRONT = 6.5;
        SUSPENSION_HEIGHT_BACK = 5.5;
        HEIGHT_MAX = 2100;
        MAX_THRUST = 1400;
    })
    setmetatable_result1_upvr.Maid = setmetatable_result1_upvr.Plane.Maid
    setmetatable_result1_upvr:SetupSeats()
    setmetatable_result1_upvr.Seats = setmetatable_result1_upvr.Plane.Seats
    setmetatable_result1_upvr.Plane.OnTakeoff = function() -- Line 57, Named "OnTakeoff"
        Audio_upvr.ObjectLocal(setmetatable_result1_upvr.Plane.PlaneGui, 3378079535)
    end
    setmetatable_result1_upvr.MotorAileronRight = arg1.MotorAileronRight
    setmetatable_result1_upvr.MotorAileronLeft = arg1.MotorAileronLeft
    setmetatable_result1_upvr.MotorAileronTailLeft = arg1.MotorAileronTailLeft
    setmetatable_result1_upvr.MotorAileronTailRight = arg1.MotorAileronTailRight
    setmetatable_result1_upvr.Plane.WheelsConf = arg1.WheelsConf
    setmetatable_result1_upvr.MissilesConf = arg1.MissilesConf
    setmetatable_result1_upvr.MissilesConf.Idx = 1
    setmetatable_result1_upvr.MissilesConf.LastFire = 0
    setmetatable_result1_upvr.MissilesConf.Count = 0
    return setmetatable_result1_upvr
end
function module_upvr.SetupSeats(arg1) -- Line 74
    table.insert(arg1.Plane.Seats, {
        Part = assert(arg1.Model.Passenger);
        Occupied = false;
    })
end
local function _(arg1, arg2, arg3) -- Line 80, Named "ClampUnitVectorCone"
    local any_VectorToObjectSpace_result1 = arg1:VectorToObjectSpace(arg2)
    local arctangent = math.atan2(any_VectorToObjectSpace_result1.Y, any_VectorToObjectSpace_result1.X)
    local clamped = math.clamp(math.acos(any_VectorToObjectSpace_result1.Z), math.pi - arg3, math.pi + arg3)
    return arg1:VectorToWorldSpace(Vector3.new(math.sin(clamped) * math.cos(arctangent), math.sin(clamped) * math.sin(arctangent), math.cos(clamped)))
end
local function _(arg1, arg2) -- Line 91, Named "CanLaunchMissile"
    local MissilesConf = arg1.MissilesConf
    if os.clock() - MissilesConf.LastFire < 2 then
        return false
    end
    if MissilesConf.Count <= 0 then
        return false
    end
    return true
end
local CollectionService_upvr = game:GetService("CollectionService")
local function GetTargetPart_upvr(arg1) -- Line 105, Named "GetTargetPart"
    local Model_2 = arg1.Model
    local var32
    for _, v in CollectionService_upvr:GetTagged(JetConsts_upvr.SEEKING_LOCK_TAG_NAME), nil do
        if not v:IsDescendantOf(Model_2) then
            local var33 = v.Position - Model_2.PrimaryPart.Position
            if var33.Magnitude < 768 then
                if 0.9238795325112867 <= var33.Unit:Dot(Model_2.PrimaryPart.CFrame.LookVector) then
                end
            end
        end
    end
    return nil
end
local function _(arg1, arg2) -- Line 128, Named "attemptSetSightColor"
    local PlaneGui_4 = arg1.Plane.PlaneGui
    local os_clock_result1_2 = os.clock()
    if not arg1.lastSightsColorChange then
        arg1.lastSightsColorChange = 0
    end
    if os_clock_result1_2 - arg1.lastSightsColorChange < 0.1 then
    else
        if PlaneGui_4.Sights.ImageColor3 == arg2 then return end
        arg1.lastSightsColorChange = os_clock_result1_2
        PlaneGui_4.Sights.ImageColor3 = arg2
    end
end
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
local PartUtils_upvr = require(ReplicatedStorage.Std.PartUtils)
local NetObjPoolBinder_upvr = require(ReplicatedStorage.NetObjPool.NetObjPoolBinder)
local SeekingMissileBinder_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local function AttemptLaunchLocalMissile_upvr(arg1, arg2) -- Line 143, Named "AttemptLaunchLocalMissile"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local MissilesConf_2 = arg1.MissilesConf
    local var57
    if os.clock() - MissilesConf_2.LastFire < 2 then
        var57 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if MissilesConf_2.Count <= 0 then
        var57 = false
    else
        var57 = true
    end
    if var57 then
        local MissilesConf_4 = arg1.MissilesConf
        MissilesConf_4.LastFire = os.clock()
        local Idx = MissilesConf_4.Idx
        local var60 = MissilesConf_4.Parts[Idx]
        local var61_upvw
        if arg1.targetPart and JetConsts_upvr.SEEKING_LOCK_MIN_DURATION <= os.clock() - arg1.targetPartFoundAt then
            var61_upvw = arg1.targetPart
        end
        if not var61_upvw then
            local RaycastParams_new_result1 = RaycastParams.new()
            RaycastParams_new_result1.FilterDescendantsInstances = {arg1.Model, LocalPlayer_upvr.Character}
            if Raycast_upvr.collidable(var60.Position, var60.CFrame.LookVector, 999, RaycastParams_new_result1) then
                local var65_upvw
            end
        end
        if not var61_upvw and not var65_upvw then
            var65_upvw = var60.Position + var60.CFrame.LookVector * 4096
        end
        MissilesConf_4.Idx = Idx % MissilesConf_4.NumParts + 1
        task.delay(2, PartUtils_upvr.setPropertyWithRollback(var60, "Transparency", 1))
        local obj_2 = NetObjPoolBinder_upvr:Get(arg1.Model:FindFirstChild("JetDriverMissilePool")):Get().obj
        obj_2.Anchored = false
        obj_2.CFrame = var60.CFrame
        obj_2.Velocity = var60.Velocity
        SeekingMissileBinder_upvr:Promise(obj_2):andThen(function(arg1_3) -- Line 183
            table.insert(arg1_3.ignoreList, arg1.Model)
            if var61_upvw then
                arg1_3:SetTargetPart(var61_upvw)
            else
                arg1_3:SetTargetPos(var65_upvw)
            end
        end)
        MissilesConf_4.Count -= 1
        arg2.CameraSpring:Accelerate(Vector3.new(10 * (random_state_upvr:NextNumber() * 2 - 1), 10 * (random_state_upvr:NextNumber() * 2 - 1), 10 * (random_state_upvr:NextNumber() * 2 - 1)) + Vector3.new(0, 0, -50))
        local Color3_new_result1_2 = Color3.new(0, 1, 0)
        local PlaneGui_3 = arg1.Plane.PlaneGui
        local os_clock_result1 = os.clock()
        if not arg1.lastSightsColorChange then
            arg1.lastSightsColorChange = 0
        end
        if os_clock_result1 - arg1.lastSightsColorChange < 0.1 then
        elseif PlaneGui_3.Sights.ImageColor3 == Color3_new_result1_2 then
        else
            arg1.lastSightsColorChange = os_clock_result1
            PlaneGui_3.Sights.ImageColor3 = Color3_new_result1_2
        end
        var6_upvw:FireServer('b'.."yxngd4jcay":sub(3, 7):reverse():reverse():reverse():reverse():reverse().."".."".."s5q":sub(2, 2):reverse():reverse():reverse():reverse():reverse()..""..'q', obj_2)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local CurrentCamera_upvr = workspace.CurrentCamera
local Confirmation_upvr = require(ReplicatedStorage.Module.Confirmation)
local String_upvr = require(ReplicatedStorage.Std.String)
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RunUtils_upvr = require(ReplicatedStorage.App.RunUtils)
local UserInputService_upvr = game:GetService("UserInputService")
local function MountLocalPlayer_upvr(arg1, arg2, arg3) -- Line 198, Named "MountLocalPlayer"
    if not arg3.Driver then
    else
        local function HeartbeatAilerons_upvr(arg1_4) -- Line 202, Named "HeartbeatAilerons"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local Joystickx = arg1.Plane.Joystickx
            local Joysticky = arg1.Plane.Joysticky
            local InputYaw = arg1.Plane.InputYaw
            local var81 = (Joystickx * Joystickx + Joysticky * Joysticky) ^ 0.5
            local var82
            if var82 >= var81 or not (Joystickx / var81) then
                local var83 = Joystickx
            end
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var82 = Joysticky / var81
                return var82
            end
            if 1 >= var81 or not decompInlinedCondition() then
                var82 = Joysticky
            end
            arg1.MotorAileronRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (var82 + var83), 0, 0)
            arg1.MotorAileronLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (var82 - var83), 0, 0)
            arg1.MotorAileronTailRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * var83 + 0.3 * InputYaw, 0)
            arg1.MotorAileronTailLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * var83 + 0.3 * InputYaw, 0)
        end
        arg3.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_5) -- Line 221, Named "Heartbeat"
            HeartbeatAilerons_upvr(arg1_5)
        end))
        local PlaneGui_2_upvr = arg1.Plane.PlaneGui
        PlaneGui_2_upvr.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)
        arg3.Maid:GiveTask(Interval_upvr.every(0.3333333333333333):Connect(function() -- Line 230
            local var87
            if arg1.Plane.IsFlying then
                var87 = GetTargetPart_upvr(arg1)
            end
            if var87 ~= arg1.targetPart then
                arg1.targetPart = var87
                if var87 ~= nil then
                    arg1.targetPartFoundAt = os.clock()
                end
            end
        end))
        local const_number_upvw = 0
        local var90_upvw = true
        local var91_upvw = false
        arg3.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 246
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local targetPart = arg1.targetPart
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end))
        local var93_upvw = false
        local function OpenMissileBuy_upvr() -- Line 285, Named "OpenMissileBuy"
            local maximum = math.max(0, JetConsts_upvr.MISSILE_COUNT_MAX - arg1.MissilesConf.Count)
            if maximum == 0 then
            else
                if var93_upvw then return end
                var93_upvw = true
                arg1.Plane:SetControlsEnabled(false)
                local any_new_result1 = Confirmation_upvr.new("Buy %d heat seeking missiles for $%s?":format(maximum, String_upvr.comma(maximum * JetConsts_upvr.MISSILE_COST_PER)))
                any_new_result1.Maid:GiveTask(any_new_result1.OnYes:Connect(function() -- Line 300
                    var6_upvw:FireServer('y'.."wxbbdq5vb":sub(3, 8):reverse():reverse():reverse():reverse():reverse()..""..'k')
                end))
                any_new_result1.Maid:GiveTask(function() -- Line 303
                    var93_upvw = false
                    arg1.Plane:SetControlsEnabled(true)
                end)
            end
        end
        PlaneGui_2_upvr.Missiles.Visible = true
        local tbl = {
            priority = 500;
            image = "rbxassetid://4939737424";
            keyCodes = {Enum.KeyCode.G};
        }
        local function onPressed() -- Line 315
            OpenMissileBuy_upvr()
        end
        tbl.onPressed = onPressed
        arg3.Maid:GiveTask(ActionButtonService_upvr.add(tbl))
        local function _() -- Line 320, Named "attemptLaunchLocalMissile"
            if RunUtils_upvr.isTradeWorld() then
                return false
            end
            if arg1.MissilesConf.Count <= 0 then
                OpenMissileBuy_upvr()
                return false
            end
            AttemptLaunchLocalMissile_upvr(arg1, arg3)
        end
        arg3.Maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_6, arg2_2) -- Line 331, Named "InputBegan"
            if arg2_2 then
                return false
            end
            if arg1_6.UserInputType == Enum.UserInputType.MouseButton1 then
                if RunUtils_upvr.isTradeWorld() then return end
                if arg1.MissilesConf.Count <= 0 then
                    OpenMissileBuy_upvr()
                    return
                end
                AttemptLaunchLocalMissile_upvr(arg1, arg3)
            end
        end))
        arg3.Maid:GiveTask(ActionButtonService_upvr.add({
            priority = 500;
            noSink = true;
            image = "rbxassetid://4939736393";
            keyCodes = {Enum.KeyCode.F, Enum.KeyCode.ButtonX};
            onPressed = function() -- Line 346, Named "onPressed"
                if RunUtils_upvr.isTradeWorld() then
                else
                    if arg1.MissilesConf.Count <= 0 then
                        OpenMissileBuy_upvr()
                        return
                    end
                    AttemptLaunchLocalMissile_upvr(arg1, arg3)
                end
            end;
        }))
    end
end
local function MountThirdPlayer_upvr(arg1, arg2, arg3) -- Line 351, Named "MountThirdPlayer"
    local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(arg1.Model.PrimaryPart, 9553468279, {
        Looped = true;
        Volume = 0;
        Pitch = 1;
        RollOffMinDistance = 86;
        RollOffMaxDistance = 896;
    })
    arg3.Maid:GiveTask(any_ObjectLocal_result1_upvr)
    arg3.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 359
        local any_Dot_result1 = arg1.Model.PrimaryPart.Velocity:Dot(arg1.Model.PrimaryPart.CFrame.LookVector)
        any_ObjectLocal_result1_upvr.Volume = math.clamp(any_Dot_result1 / 300, 0, 1) * 0.4
        any_ObjectLocal_result1_upvr.PlaybackSpeed = math.clamp(any_Dot_result1 / 300, 0, 1) * 0.35 + 0.65
    end))
end
function module_upvr.MountPlayer(arg1, arg2, arg3) -- Line 367
    arg1.Plane:MountPlayer(arg2, arg3)
    if arg2 == LocalPlayer_upvr then
        MountLocalPlayer_upvr(arg1, arg2, arg3)
    else
        MountThirdPlayer_upvr(arg1, arg2, arg3)
    end
end
local function _(arg1, arg2) -- Line 376, Named "UnmountLocalPlayer"
    if arg2.Driver then
        arg1.Plane.PlaneGui.Missiles.Visible = false
    end
end
function module_upvr.UnmountSeat(arg1, arg2) -- Line 382
    if arg2.Player == LocalPlayer_upvr and arg2.Driver then
        arg1.Plane.PlaneGui.Missiles.Visible = false
    end
    return arg1.Plane:UnmountSeat(arg2)
end
function module_upvr.UpdateMissileUI(arg1, arg2, arg3) -- Line 388
    assert(arg2)
    arg1.MissilesConf.Count = arg2
    arg1.Plane.PlaneGui:FindFirstChild("Missiles").Body.Current.Count.Text = "%d/%d":format(arg2, arg3)
end
function module_upvr.Destroy(arg1) -- Line 395
    arg1.Plane:Destroy()
end
return module_upvr