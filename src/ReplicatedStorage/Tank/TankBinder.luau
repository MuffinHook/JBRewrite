local Players_upvr = game:GetService("Players")
local CurrentCamera_upvr = workspace.CurrentCamera
local RunService_upvr = game:GetService("RunService")
local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
local AccelTween_upvr = require(ReplicatedStorage.Std.AccelTween)
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local var13_upvr = require(ReplicatedStorage.Std.Enumer)({"Wheel", "Front", "Gear"})
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_2_upvr.new(arg1, arg2) -- Line 33
    local module = {}
    setmetatable(module, module_2_upvr)
    module.obj = arg1
    module.manifest = arg2
    module._maid = Maid_upvr.new()
    module._onGunnerSeatLeft = Signal_upvr.new()
    module._gunnerMaid = Maid_upvr.new()
    module._maid:GiveTask(module._gunnerMaid)
    module._lastShoot = 0
    module.mobileInputObject = nil
    module._flagBrakelightsEnabled = false
    module:_handleIdleUpdate()
    module:_listenSeats("Seat")
    module:_listenSeats("Passenger")
    module:_listenNetwork()
    return module
end
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_2_upvr._listenSeats(arg1, arg2) -- Line 55
    arg1._maid:GiveTask(RxInstanceUtils_upvr.observeChildrenNamed(arg1.obj, arg2, function(arg1_2, arg2_2) -- Line 56
        arg2_2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_2, "PlayerName", function(arg1_3, arg2_3) -- Line 58
            arg1:_handlePlayerNameChanged(arg1_2, arg1_3, arg2_3)
            arg2_3:GiveTask(arg1_3.Changed:Connect(function() -- Line 60
                arg1:_handlePlayerNameChanged(arg1_2, arg1_3, arg2_3)
            end))
        end))
    end))
end
function module_2_upvr._handlePlayerNameChanged(arg1, arg2, arg3, arg4) -- Line 67
    local SOME = Players_upvr:FindFirstChild(arg3.Value)
    if SOME then
        local any_new_result1_6 = Maid_upvr.new()
        arg4.seatMaid = any_new_result1_6
        arg1:_handleSeated(SOME, any_new_result1_6, arg2)
    else
        arg4.seatMaid = nil
    end
end
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
function module_2_upvr._getMouseLocation(arg1) -- Line 79
    if InputUtils_upvr.isTouch() then
        local ViewportSize = CurrentCamera_upvr.ViewportSize
        return Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5)
    end
    return UserInputService_upvr:GetMouseLocation()
end
function module_2_upvr._transformLocalMousePosition(arg1, arg2) -- Line 90
    return arg2
end
function module_2_upvr._getIgnoreList(arg1) -- Line 93
    return {arg1.obj}
end
function module_2_upvr._projectMouseLocationToWorld(arg1, arg2) -- Line 96
    local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(arg2.x, arg2.y)
    arg1.raycastParams.FilterDescendantsInstances = arg1:_getIgnoreList()
    local any_collidable_result1_2 = Raycast_upvr.collidable(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction, 999, arg1.raycastParams)
    local var28
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var28 = any_collidable_result1_2.Position
        return var28
    end
    if not any_collidable_result1_2 or not decompInlinedCondition() then
        var28 = any_ViewportPointToRay_result1.Origin + any_ViewportPointToRay_result1.Direction * 999
    end
    return arg1:_transformLocalMousePosition(var28), any_ViewportPointToRay_result1.Direction
end
function module_2_upvr._getMouseWorldPosition(arg1) -- Line 105
    return arg1:_projectMouseLocationToWorld(arg1:_getMouseLocation())
end
function module_2_upvr._flip(arg1) -- Line 108
    local PrimaryPart = arg1.obj.PrimaryPart
    local LookVector = PrimaryPart.CFrame.LookVector
    arg1.obj:SetPrimaryPartCFrame(CFrame.fromMatrix(PrimaryPart.Position, LookVector:Cross(Vector3.new(0, 1, 0)).Unit, Vector3.new(0, 1, 0), -LookVector))
end
function module_2_upvr._handleSeated(arg1, arg2, arg3, arg4) -- Line 115
    if arg4.Name == "Seat" then
        arg1:_handleSeatedDriver(arg2, arg3)
    end
    arg3:GiveTask(arg1._onGunnerSeatLeft:Connect(function(arg1_4) -- Line 121
        arg1:_checkIfThisPlayerIsGunner(arg2, arg3)
    end))
    arg1:_checkIfThisPlayerIsGunner(arg2, arg3)
end
local TankUtils_upvr = require(script.Parent.TankUtils)
function module_2_upvr._checkIfThisPlayerIsGunner(arg1, arg2, arg3) -- Line 126
    local any_getGunner_result1 = TankUtils_upvr.getGunner(arg1.obj)
    if any_getGunner_result1 ~= arg2 then
    elseif any_getGunner_result1 and any_getGunner_result1 ~= arg1._currentGunner then
        arg1._currentGunner = any_getGunner_result1
        arg1:_handleSeatedGunner(any_getGunner_result1, arg3)
    end
end
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local MilitaryTurretUtils_upvr = require(ReplicatedStorage.Game.MilitaryTurret.MilitaryTurretUtils)
local Time_upvr = require(ReplicatedStorage.Module.Time)
function module_2_upvr._handleSeatedGunner(arg1, arg2, arg3) -- Line 139
    local var37_upvr
    if arg2 ~= Players_upvr.LocalPlayer then
        var37_upvr = false
    else
        var37_upvr = true
    end
    local any_new_result1_8_upvr = Maid_upvr.new()
    arg1._maid.gunnerMaid = any_new_result1_8_upvr
    arg3:GiveTask(function() -- Line 143
        if arg1._maid.gunnerMaid ~= any_new_result1_8_upvr then
        else
            arg1._currentGunner = nil
            arg1._maid.gunnerMaid = nil
            arg1._onGunnerSeatLeft:Fire(nil)
        end
    end)
    local any_ObjectLocal_result1_upvr_3 = Audio_upvr.ObjectLocal(arg1.obj.PrimaryPart, 8206012878, {
        Volume = 0;
        Pitch = 1;
        Looped = true;
    })
    any_new_result1_8_upvr:GiveTask(function() -- Line 153
        Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr_3, 0, 0.5):andThen(function() -- Line 154
            any_ObjectLocal_result1_upvr_3:Destroy()
        end)
    end)
    local RaycastParams_new_result1 = RaycastParams.new()
    RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Blacklist
    RaycastParams_new_result1.FilterDescendantsInstances = arg1:_getIgnoreList()
    RaycastParams_new_result1.IgnoreWater = true
    arg1.raycastParams = RaycastParams_new_result1
    local gunMotor_2_upvr = arg1.manifest.gunMotor
    if not arg1._lastPitch then
        arg1._lastPitch = 0
    end
    if not arg1._lastYaw then
        arg1._lastYaw = 0
    end
    if not arg1._pitchAccel then
        arg1._pitchAccel = AccelTween_upvr.new(20)
    end
    if not arg1._yawAccel then
        arg1._yawAccel = AccelTween_upvr.new(15)
    end
    if not arg1._kickSpring then
        arg1._kickSpring = Spring_upvr.new(0, 0, 0.5, 15)
    end
    local var46_upvw = false
    local topMotor_upvr = arg1.manifest.topMotor
    local os_clock_result1_upvw = os.clock()
    any_new_result1_8_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 187
        if var37_upvr then
            if var46_upvw then
                local var50 = topMotor_upvr.Part1.CFrame * topMotor_upvr.C0:Inverse()
                local any__getMouseWorldPosition_result1 = arg1:_getMouseWorldPosition()
                local any_PointToObjectSpace_result1_2 = var50:PointToObjectSpace(any__getMouseWorldPosition_result1)
                local arctangent = math.atan2(-any_PointToObjectSpace_result1_2.x, -any_PointToObjectSpace_result1_2.z)
                local any_PointToObjectSpace_result1 = var50 * CFrame.Angles(0, arctangent, 0) * gunMotor_2_upvr.C0:Inverse():PointToObjectSpace(any__getMouseWorldPosition_result1)
                arg1._lastYaw += MilitaryTurretUtils_upvr.shortAngleDist(arg1._lastYaw, arctangent)
                arg1._lastPitch = math.clamp(math.atan2(any_PointToObjectSpace_result1.y, -any_PointToObjectSpace_result1.z), -0.2617993877991494, 0.5235987755982988)
            end
            local os_clock_result1 = os.clock()
            if 0.06666666666666667 < os_clock_result1 - os_clock_result1_upvw then
                os_clock_result1_upvw = os_clock_result1
                arg1.manifest.replicateRingRemote:FireServer(arg1._lastYaw, arg1._lastPitch)
            end
        end
        if arg1._yawAccel.t ~= arg1._lastYaw then
            arg1._yawAccel.t = arg1._lastYaw
        end
        if arg1._pitchAccel.t ~= arg1._lastPitch then
            arg1._pitchAccel.t = arg1._lastPitch
        end
        any_ObjectLocal_result1_upvr_3.Volume = (math.clamp(math.abs(arg1._yawAccel.v) / 4, 0, 1) * 0.9 + 0.1) * 0.8
        topMotor_upvr.C1 = topMotor_upvr.C0:Inverse() * CFrame.Angles(0, arg1._yawAccel.p, 0) * topMotor_upvr.C0
        gunMotor_2_upvr.C1 = gunMotor_2_upvr.C0:Inverse() * CFrame.Angles(arg1._pitchAccel.p, 0, 0) * CFrame.new(0, 0, arg1._kickSpring:Update()) * gunMotor_2_upvr.C0
    end))
    if var37_upvr then
        local function shoot_upvr() -- Line 231, Named "shoot"
            local var56
            if arg1.obj:GetAttribute("TankDisabled") ~= true then
                var56 = false
            else
                var56 = true
            end
            if var56 then
            else
                local var57
                if Players_upvr.LocalPlayer:GetAttribute("MissileCount") <= 0 and not Players_upvr.LocalPlayer.Character:GetAttribute("TankRoyaleAlive") then
                    VehicleUtils_upvr.promptMissileBuy()
                    return false
                end
                local os_clock_result1_3 = os.clock()
                if os_clock_result1_3 - arg1._lastShoot < 1 / arg1.obj:GetAttribute("MissileLaunchHz") then return end
                arg1._lastShoot = os_clock_result1_3
                local Part0 = gunMotor_2_upvr.Part0
                local CFrame = Part0.CFrame
                var57 = CFrame.p
                local any_collidable_result1 = Raycast_upvr.collidable(var57, CFrame.LookVector, 999, arg1.raycastParams)
                local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var57 = any_collidable_result1.Position
                    return var57
                end
                if not any_collidable_result1 or not decompInlinedCondition_2() then
                    var57 = CFrame.p + CFrame.LookVector * 999
                end
                local any_GetNowSync_result1 = Time_upvr.GetNowSync()
                arg1:_launchMissile(CFrame * CFrame.new(0, 0, -14), Part0.Velocity, var57, any_GetNowSync_result1)
                arg1.manifest.shootRemote:FireServer(arg1._yawAccel.p, arg1._pitchAccel.p, var57, any_GetNowSync_result1)
            end
        end
        local tbl_4 = {
            priority = 350;
            image = "rbxassetid://4939740665";
            keyCodes = {Enum.KeyCode.F, Enum.KeyCode.ButtonX};
        }
        local function onPressed() -- Line 267
            shoot_upvr()
        end
        tbl_4.onPressed = onPressed
        any_new_result1_8_upvr:GiveTask(ActionButtonService_upvr.add(tbl_4))
        any_new_result1_8_upvr:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_5, arg2_4) -- Line 272
            if arg2_4 then
            else
                if arg1_5.UserInputType == Enum.UserInputType.MouseButton1 then
                    var46_upvw = true
                    return
                end
                if arg1_5.UserInputType == Enum.UserInputType.Touch then
                    arg1._mobileInputObject = arg1_5
                end
            end
        end))
        any_new_result1_8_upvr:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_6, arg2_5) -- Line 282
            if arg2_5 then
            else
                if arg1_6.UserInputType == Enum.UserInputType.MouseButton1 then
                    var46_upvw = false
                    return
                end
                if arg1_6.UserInputType ~= Enum.UserInputType.Touch or arg1._mobileInputObject ~= arg1_6 then
                end
            end
        end))
        local tbl = {
            priority = 975;
            image = "rbxassetid://4939736720";
            touchIsToggle = true;
            keyCodes = {Enum.KeyCode.Q, Enum.KeyCode.ButtonL1};
        }
        local function onPressed() -- Line 299
            arg1._mobileInputObject = nil
            var46_upvw = true
        end
        tbl.onPressed = onPressed
        function tbl.onReleased() -- Line 303
            var46_upvw = false
        end
        any_new_result1_8_upvr:GiveTask(ActionButtonService_upvr.add(tbl))
    end
end
function module_2_upvr._updateTreads(arg1, arg2, arg3) -- Line 309
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local tbl_3 = {}
    local tbl_2 = {}
    local var91
    for _, v in ipairs(arg2.Wheels) do
        local _isRight = v._isRight
        local any_Update_result1, any_Update_result2, any_Update_result3 = v:Update(arg3, 0)
        v.wheelMotor.C1 = CFrame.new(0, any_Update_result1, 0) * CFrame.Angles(any_Update_result2, 0, 0)
        ;({})[v.PartNode] = any_Update_result1
        tbl_3[v.PartNode] = v.treadType
        tbl_2[v.PartNode] = v.fakeTreadMotor
        if v.fakeTreadMotor then
            local fakeTreadMotor = v.fakeTreadMotor
            fakeTreadMotor.C1 = CFrame.new(0, any_Update_result1, 0)
        end
        if _isRight then
            var91 += any_Update_result3
        else
        end
    end
    var91 /= 0 + 1
    local ipairs_result1_4, ipairs_result2, ipairs_result3_3 = ipairs(arg2.Wheels)
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if tbl_3[any_Update_result1] == var13_upvr.Gear then
        local _ = tbl_2[any_Update_result1].Part0.Top.WorldPosition
    elseif tbl_3[any_Update_result1] == var13_upvr.Front then
    end
    local Magnitude = (fakeTreadMotor - tbl_2[any_Update_result1].Part0.Bottom.WorldPosition).Magnitude
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    v.treadMotor.C1 = _isRight.CFrame:ToObjectSpace(CFrame.lookAt(fakeTreadMotor, tbl_2[any_Update_result1].Part0.Bottom.WorldPosition, arg1.obj.PrimaryPart.CFrame.UpVector) * CFrame.new(0, 0, -Magnitude * 0.5))
    local Part0_2 = v.treadMotor.Part0
    Part0_2.Size = Vector3.new(Part0_2.Size.X, Part0_2.Size.Y, Magnitude)
    if not v._isRight or not var91 then
    end
    for _, v_2 in ipairs(v.treadTex) do
        v_2.OffsetStudsV = v.treadTex[1].OffsetStudsV - (0 + any_Update_result3) / (0 + 1)
        local _
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [260.2147483650]
    if Magnitude == CFrame.lookAt(fakeTreadMotor, tbl_2[any_Update_result1].Part0.Bottom.WorldPosition, arg1.obj.PrimaryPart.CFrame.UpVector) * CFrame.new(0, 0, -Magnitude * 0.5) then
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if Magnitude == CFrame.lookAt(fakeTreadMotor, tbl_2[any_Update_result1].Part0.Bottom.WorldPosition, arg1.obj.PrimaryPart.CFrame.UpVector) * CFrame.new(0, 0, -Magnitude * 0.5) then
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            if Magnitude == CFrame.lookAt(fakeTreadMotor, tbl_2[any_Update_result1].Part0.Bottom.WorldPosition, arg1.obj.PrimaryPart.CFrame.UpVector) * CFrame.new(0, 0, -Magnitude * 0.5) then
            end
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if Magnitude == CFrame.lookAt(fakeTreadMotor, tbl_2[any_Update_result1].Part0.Bottom.WorldPosition, arg1.obj.PrimaryPart.CFrame.UpVector) * CFrame.new(0, 0, -Magnitude * 0.5) then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function _(arg1, arg2, arg3) -- Line 391, Named "getUpdateRate"
    if arg1 < arg2 then
        return 0
    end
    return (arg1 - arg2) / (arg3 - arg2)
end
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
function module_2_upvr._handleIdleUpdate(arg1) -- Line 397
    local any_new_result1_2 = Maid_upvr.new()
    arg1._maid.lqMaid = any_new_result1_2
    local os_clock_result1_upvw_2 = os.clock()
    local any__buildWheelWorld_result1_upvr = arg1:_buildWheelWorld(any_new_result1_2, false)
    any_new_result1_2:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 402
        local os_clock_result1_4 = os.clock()
        local var113 = os_clock_result1_4 - os_clock_result1_upvw_2
        local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
        if not any_getRootPart_result1 then
        else
            local Position = any_getRootPart_result1.Position
            local Magnitude_2 = (Position - arg1.obj.PrimaryPart.Position).Magnitude
            if Magnitude_2 < 0 then
                Position = 0
            else
                Position = (Magnitude_2 - 0) / 256
            end
            if var113 < Position then return end
            os_clock_result1_upvw_2 = os_clock_result1_4
            arg1:_updateTreads(any__buildWheelWorld_result1_upvr, var113)
        end
    end))
end
local DrivingControls_upvr = require(ReplicatedStorage.DrivingControls.DrivingControls)
function module_2_upvr._handleSeatedDriver(arg1, arg2, arg3) -- Line 418
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    arg1._maid.lqMaid = nil
    arg3:GiveTask(function() -- Line 420
        arg1:_handleIdleUpdate()
    end)
    local var119
    if arg2 ~= Players_upvr.LocalPlayer then
        var119 = false
    else
        var119 = true
    end
    if var119 then
        local any_new_result1_3_upvw = DrivingControls_upvr.new()
        arg3:GiveTask(any_new_result1_3_upvw)
        local obj_upvr = arg1.obj
        arg3:GiveTask(function() -- Line 431
            VehicleUtils_upvr.setBrakelightsEnabled(obj_upvr, false)
        end)
    end
    obj_upvr = arg1:_buildWheelWorld(arg3, var119)
    local var123_upvr = obj_upvr
    local any_ObjectLocal_result1_upvr_2 = Audio_upvr.ObjectLocal(arg1.obj.PrimaryPart, 9058406725, {
        Volume = 0;
        Pitch = 1;
        Looped = true;
    })
    arg3:GiveTask(function() -- Line 446
        Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr_2, 0, 0.5):andThen(function() -- Line 447
            any_ObjectLocal_result1_upvr_2:Destroy()
        end)
    end)
    local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(arg1.obj.PrimaryPart, 8206014264, {
        Volume = 0;
        Pitch = 1;
        Looped = true;
    })
    arg3:GiveTask(function() -- Line 453
        Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 0, 0.5):andThen(function() -- Line 454
            any_ObjectLocal_result1_upvr:Destroy()
        end)
    end)
    local any_new_result1_7_upvr = AccelTween_upvr.new(500)
    local any_new_result1_4_upvr = AccelTween_upvr.new(2000)
    local var135_upvw = 0
    local any_GetEffWheelCount_result1_upvr = var123_upvr:GetEffWheelCount()
    arg3:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_7) -- Line 461
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var145
        if any_new_result1_3_upvw then
            local var146 = true
            var145 = arg1
            var145 = var145.obj:GetAttribute("TankDisabled")
            if var145 ~= true then
                var146 = VehicleUtils_upvr.GetLocalVehiclePacket().LockMovement
            end
            var145 = any_new_result1_3_upvw:GetForwardBackward()
            if var146 then
                var145 = 0
            end
            if any_new_result1_7_upvr.t ~= var145 then
                any_new_result1_7_upvr.t = var145
                any_new_result1_7_upvr.v = 0
            end
            local any_GetLeftRight_result1 = any_new_result1_3_upvw:GetLeftRight()
            if var146 then
                any_GetLeftRight_result1 = 0
            end
            if any_new_result1_4_upvr.t ~= any_GetLeftRight_result1 then
                any_new_result1_4_upvr.t = any_GetLeftRight_result1
                any_new_result1_4_upvr.v = 0
            end
            if any_new_result1_7_upvr.p < 0 then
            end
            if math.abs(any_new_result1_7_upvr.p) < 0.1 then
                var135_upvw += math.sign(0 - var135_upvw) * 75 * arg1_7
            else
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                var135_upvw += math.sign(0 - var135_upvw) * 30 * arg1_7
            end
            local maximum = math.max(var135_upvw, 0)
            var135_upvw = maximum
            if var145 >= 0.000001 then
                maximum = false
            else
                maximum = true
            end
            if arg1._flagBrakelightsEnabled ~= maximum then
                arg1._flagBrakelightsEnabled = maximum
                VehicleUtils_upvr.setBrakelightsEnabled(arg1.obj, maximum)
            end
        end
        for _, v_3 in ipairs(var123_upvr.Wheels) do
            local var152
            if any_new_result1_3_upvw then
                local p = any_new_result1_7_upvr.p
                local p_2 = any_new_result1_4_upvr.p
                var152 = Vector3.new()
                if 0.001 <= math.abs(p) then
                    var152 += Vector3.new(0, 0, -var135_upvw * p) / any_GetEffWheelCount_result1_upvr
                end
                if 0.001 <= math.abs(p_2) then
                    local var155 = -10
                    if v_3._isRight then
                        var155 = 1
                    else
                        var155 = -1
                    end
                    var152 += Vector3.new(0, 0, var155 * p_2 * var155) / any_GetEffWheelCount_result1_upvr
                end
                v_3:SetExternalGroundAccel(var152)
            end
        end
    end))
    arg3:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_8) -- Line 525
        local any__updateTreads_result1, any__updateTreads_result2 = arg1:_updateTreads(var123_upvr, arg1_8)
        any_ObjectLocal_result1_upvr.Volume = (math.clamp((math.abs(any__updateTreads_result1) + math.abs(any__updateTreads_result2)) * 0.5 / arg1_8 / 10, 0, 1) * 0.9 + 0.1) * 0.8
        local absolute = math.abs(arg1.obj.PrimaryPart.Velocity:Dot(arg1.obj.PrimaryPart.CFrame.LookVector))
        any_ObjectLocal_result1_upvr_2.Volume = (math.clamp(absolute / 90, 0, 1) * 0.6 + 0.4) * 1
        any_ObjectLocal_result1_upvr_2.PlaybackSpeed = math.clamp(absolute / 100, 0, 1) * 0.4 + 0.8
    end))
    if var119 then
        local tbl_5 = {
            priority = 850;
            image = "rbxassetid://4939737424";
            keyCodes = {Enum.KeyCode.V, Enum.KeyCode.ButtonR1};
        }
        local os_clock_result1_2_upvw = os.clock()
        function tbl_5.onPressed() -- Line 545
            local os_clock_result1_5 = os.clock()
            if os_clock_result1_5 - os_clock_result1_2_upvw < 1 then
            else
                os_clock_result1_2_upvw = os_clock_result1_5
                arg1:_flip()
            end
        end
        arg3:GiveTask(ActionButtonService_upvr.add(tbl_5))
    end
end
function module_2_upvr._listenNetwork(arg1) -- Line 556
    arg1._maid:GiveTask(arg1.manifest.replicateRingRemote.OnClientEvent:Connect(function(arg1_9, arg2) -- Line 557
        arg1._lastYaw = arg1_9
        arg1._lastPitch = arg2
    end))
    arg1._maid:GiveTask(arg1.manifest.shootRemote.OnClientEvent:Connect(function(arg1_10, arg2, arg3, arg4) -- Line 561
        local topMotor = arg1.manifest.topMotor
        local gunMotor = arg1.manifest.gunMotor
        arg1._lastYaw = arg1_10
        arg1._lastPitch = arg2
        arg1:_launchMissile(topMotor.Part1.CFrame * topMotor.C0:Inverse() * CFrame.Angles(0, arg1_10, 0) * gunMotor.C0:Inverse() * CFrame.Angles(arg2, 0, 0) * CFrame.new(0, 0, -14) * CFrame.new(0, 0, -14), gunMotor.Part0.Velocity, arg3, arg4)
    end))
end
local Missile_upvr = require(ReplicatedStorage.Game.Missile)
function module_2_upvr._launchMissile(arg1, arg2, arg3, arg4, arg5) -- Line 582
    Missile_upvr.LaunchMissile(arg2, arg3, arg4, arg5, "TankMissile", 0, arg1:_getIgnoreList())
    arg1.obj.PrimaryPart:ApplyImpulseAtPosition(-arg2.LookVector * arg1.obj.PrimaryPart.AssemblyMass * 30, arg2.p)
    arg1._kickSpring:Accelerate(80)
    Audio_upvr.ObjectLocal(arg1.obj.PrimaryPart, 8206015084, {
        Volume = 0.6;
    })
    for _, v_4 in ipairs(arg1.obj:FindFirstChild("Top"):FindFirstChild("Gun"):FindFirstChild("ParticlePart"):GetChildren()) do
        if v_4:IsA("ParticleEmitter") then
            v_4:Emit(10)
        end
    end
end
local WheelWorld_upvr = require(ReplicatedStorage.Module.Wheel.WheelWorld)
local Wheel_upvr = require(ReplicatedStorage.Module.Wheel.Wheel)
function module_2_upvr._buildWheelWorld(arg1, arg2, arg3) -- Line 595
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_new_result1 = WheelWorld_upvr.new()
    any_new_result1:SetModel(arg1.obj)
    arg2:GiveTask(any_new_result1)
    for _, v_5 in ipairs(arg1.obj:FindFirstChild("Wheels"):GetChildren()) do
        local any_ToObjectSpace_result1 = arg1.obj.PrimaryPart.CFrame:ToObjectSpace(v_5.CFrame)
        local var206
        if 0 >= any_ToObjectSpace_result1.x then
        else
        end
        var206 = 0
        if any_ToObjectSpace_result1.z >= var206 then
        else
        end
        var206 = v_5
        local any_new_result1_5 = Wheel_upvr.new(var206, not arg3)
        var206 = var13_upvr
        var206 = var206.Wheel
        if v_5.Name == "Front" then
            var206 = var13_upvr.Front
        elseif v_5.Name == "Gear" then
            var206 = var13_upvr.Gear
        end
        any_new_result1_5.treadType = var206
        any_new_result1_5._isRight = true
        any_new_result1_5:SetSpringConstants(2, 6)
        any_new_result1_5:SetHorizontalFriction(6)
        any_new_result1_5:SetForwardFriction(2)
        any_new_result1_5:SetForwardFriction2(0.01)
        any_new_result1_5:SetVisualRadius(1.6384999999999998)
        local var208
        if var206 == var13_upvr.Wheel then
            var208 = 5.3
            any_new_result1_5:SetSuspensionHeight(var208)
        else
            var208 = 3.3
            any_new_result1_5:SetSuspensionHeight(var208)
        end
        any_new_result1_5:SetVersion(2)
        if arg3 then
            if var206 ~= var13_upvr.Wheel then
            else
            end
            any_new_result1_5:SetApplyForces(true)
        end
        any_new_result1:AddWheel(any_new_result1_5)
        any_new_result1_5.wheelMotor = v_5:FindFirstChild("WheelMotor")
        any_new_result1_5.fakeTreadMotor = v_5:FindFirstChild("FakeTreadMotor")
        any_new_result1_5.treadMotor = v_5:FindFirstChild("TreadMotor")
        any_new_result1_5.treadToTarget = v_5:FindFirstChild("_TrackToWheel").Value
        any_new_result1_5.treadTex = {any_new_result1_5.treadMotor.Part0:FindFirstChild("TreadTex0"), any_new_result1_5.treadMotor.Part0:FindFirstChild("TreadTex1")}
        if any_new_result1_5.fakeTreadMotor then
            for _, v_6 in ipairs(any_new_result1_5.fakeTreadMotor.Part0.Parent:GetChildren()) do
                if v_6.Name == "Tread" then
                    for _, v_7 in ipairs(v_6:GetChildren()) do
                        if v_7:IsA("Texture") then
                            table.insert(any_new_result1_5.treadTex, v_7)
                        end
                    end
                end
            end
        end
    end
    return any_new_result1
end
function module_2_upvr.Destroy(arg1) -- Line 654
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return require(ReplicatedStorage.ManifestBinder).new("Tank", {
    topMotor = "BoundingBox/TopMotor";
    gunMotor = "BoundingBox/GunMotor";
    shootRemote = "ShootRemote";
    replicateRingRemote = "ReplicateRingRemote";
}, module_2_upvr)