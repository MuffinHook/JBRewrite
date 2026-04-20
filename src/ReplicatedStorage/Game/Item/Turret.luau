local ReplicatedStorage = game:GetService("ReplicatedStorage")
local R15IKv2_upvr = require(ReplicatedStorage.Module.R15IKv2)
local CurrentCamera_upvr = workspace.CurrentCamera
local Gun_upvr = require(script.Parent.Gun)
local function _() -- Line 13, Named "RandomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local module_upvr = {
    __ClassName = "Turret";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr.new(arg1, arg2, arg3) -- Line 21
    local any_new_result1_upvr = Gun_upvr.new(arg1, arg2)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.Maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg2, "TurretValue", function(arg1_2, arg2_2) -- Line 27
        arg2_2:GiveTask(RxInstanceUtils_upvr.observeProperty(arg1_2, "Value", function(arg1_3, arg2_3) -- Line 29
            any_new_result1_upvr.Model = arg1_3
            arg2_3:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_3, "BarrelMotor", function(arg1_4) -- Line 32
                any_new_result1_upvr.BarrelMotor = arg1_4
            end))
            arg2_3:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_3, "VerticalMotor", function(arg1_5) -- Line 37
                any_new_result1_upvr.VerticalMotor = arg1_5
            end))
            arg2_3:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_3, "HorizontalMotor", function(arg1_6) -- Line 42
                any_new_result1_upvr.HorizontalMotor = arg1_6
            end))
            arg2_3:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_3, "Flare", function(arg1_7, arg2_4) -- Line 47
                arg2_4:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_7, "ParticleEmitter", function(arg1_8) -- Line 49
                    any_new_result1_upvr.FlareEmitter = arg1_8
                end))
            end))
            arg2_3:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_3, "Tips", function(arg1_9, arg2_5) -- Line 56
                arg2_5:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1_9, function() -- Line 57
                    any_new_result1_upvr.Tips = arg1_9:GetChildren()
                end))
            end))
            if any_new_result1_upvr.Local then
                any_new_result1_upvr.Maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_3, "UpdateHeatRemote", function(arg1_10) -- Line 67
                    any_new_result1_upvr._updateHeatRemote = arg1_10
                end))
            end
        end))
    end))
    any_new_result1_upvr:Setup()
    any_new_result1_upvr:DefaultDisableCamLock()
    return any_new_result1_upvr
end
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local RunService_upvr = game:GetService("RunService")
function module_upvr.Setup(arg1) -- Line 83
    arg1.IgnoreList = {arg1.Character, arg1.Model, workspace.Items}
    arg1.LastShoot = 0
    arg1.LastPlayerImpact = 0
    arg1.SpringThirdMousePosition = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.9, 30)
    if arg1.Local then
        arg1.SpringCamera = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.6, 75)
    end
    arg1.SpringSpin = Spring_upvr.new(0, 0, 0.6, 7)
    arg1.SpinTotal = 0
    arg1.MouseDown = false
    if not arg1.Tips then
        arg1.Tips = {}
    end
    arg1.TipIndex = 1
    arg1:SetupBulletEmitter()
    if arg1.Local then
        arg1:SetupCrossHair()
    end
    arg1:SetupShoot()
    arg1.IK = R15IKv2_upvr.BuildPacketArms(arg1.Character)
    arg1:UpdateMousePosition()
    arg1.Maid:GiveTask(RunService_upvr.RenderStepped:Connect(function(arg1_11) -- Line 115
        arg1:RenderStepped(arg1_11)
    end))
    arg1.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 118
        arg1:Stepped()
    end))
end
module_upvr.ApplySkin = false
module_upvr.Reload = false
function module_upvr.BulletEmitterOnLocalHitPlayer(arg1, ...) -- Line 127
    local tick_result1_2 = tick()
    if 0.1 < tick_result1_2 - arg1.LastPlayerImpact then
        arg1.LastPlayerImpact = tick_result1_2
        Gun_upvr.BulletEmitterOnLocalHitPlayer(arg1, ...)
    end
end
function module_upvr.TransformLocalMousePosition(arg1, arg2) -- Line 136
    return arg1.SpringThirdMousePosition:SetTarget(arg2)
end
function module_upvr.UpdateArmJoints(arg1) -- Line 139
    local IK = arg1.IK
    local Model = arg1.Model
    IK.RightArm = Model.RightArm.Position
    IK.LeftArm = Model.LeftArm.Position
    R15IKv2_upvr.Arms(IK)
end
function module_upvr.UpdateCamera(arg1) -- Line 151
    local os_clock_result1 = os.clock()
    local var27 = os_clock_result1 - (arg1._lastCameraUpdate or os_clock_result1)
    arg1._lastCameraUpdate = os_clock_result1
    local any_Update_result1 = arg1.SpringCamera:Update()
    local var29 = CurrentCamera_upvr
    var29.CFrame *= CFrame.Angles(0, any_Update_result1.X * var27 * 60, 0) * CFrame.Angles(any_Update_result1.Y * var27 * 60, 0, 0)
end
function module_upvr.RenderStepped(arg1, arg2) -- Line 160
    arg1:UpdateMousePosition()
    if arg1.Local then
        arg1:UpdateCrossHair()
        arg1:UpdateCamera()
    end
end
function module_upvr.Shoot(arg1) -- Line 170
    local var30 = arg1.Tips[arg1.TipIndex]
    arg1.Tip = var30
    arg1.BulletEmitter:Emit(var30.Position, var30.CFrame.lookVector, arg1.Config.BulletSpeed)
    arg1.TipIndex = arg1.TipIndex % #arg1.Tips + 1
    if arg1.Local then
        arg1.CrossHair.Spring:Accelerate(200)
        arg1.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * math.clamp(20 / (arg1.Model.Back.Position - CurrentCamera_upvr.CFrame.p).Magnitude, 0.1, 1) * 0.15 * 15)
    end
end
function module_upvr.ShootCheckConditions(arg1) -- Line 185
    return true
end
function module_upvr.AnimateBarrel(arg1, arg2, arg3) -- Line 188
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if not arg1.Model then
    else
        local tick_result1 = tick()
        if arg1.Sound then
            arg1.Sound.Volume = arg3
        end
        local MaxHeat = arg1.Config.MaxHeat
        local var33
        if 0.6 <= arg3 and var33 < MaxHeat then
            if not arg1.FlareEmitter.Enabled then
                arg1.FlareEmitter.Enabled = true
            end
            if 1 / (10 + 30 * arg3) < tick_result1 - arg1.LastShoot then
                var33 += arg2
                if MaxHeat <= var33 then
                    var33 += 3
                    arg1:InputEnded({
                        UserInputType = Enum.UserInputType.MouseButton1;
                    })
                end
                arg1.LastShoot = tick_result1
                if arg1.Local then
                    arg1:_attemptShoot()
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
            if arg1.FlareEmitter.Enabled then
                arg1.FlareEmitter.Enabled = false
            end
            if 0 < var33 then
                var33 -= arg2
            end
            if var33 < 0 then
                var33 = 0
            end
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        arg1.Model.Barrel.Color = arg1.Config.ColorNormal:Lerp(arg1.Config.ColorHeat, math.clamp(var33, 0, MaxHeat) / MaxHeat)
        arg1.Model:SetAttribute("Heat", var33)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
end
function module_upvr.Stepped(arg1) -- Line 234
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var35
    if not arg1.Model then
    else
        if not arg1.HorizontalMotor then return end
        if not arg1.BarrelMotor then return end
        if not arg1.VerticalMotor then return end
        local tick_result1_3 = tick()
        local var37 = tick_result1_3 - (arg1.LastUpdate or tick_result1_3)
        arg1.LastUpdate = tick_result1_3
        local any_PointToObjectSpace_result1 = arg1.Model.Root.CFrame:PointToObjectSpace(arg1.MousePosition)
        local x = any_PointToObjectSpace_result1.x
        local z = any_PointToObjectSpace_result1.z
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var35 = math.atan(x / z)
            return var35
        end
        if z >= 0 or not decompInlinedCondition() then
            var35 = math.pi - math.atan(-x / z)
        end
        local var43 = z * math.cos(var35) + x * math.sin(var35)
        local var44 = any_PointToObjectSpace_result1.y - arg1.Model.AxisV.Position.Y + arg1.Model.Root.Position.Y
        if var43 >= 0 or not math.atan(-var44 / var43) then
        end
        var35 = (var35 + math.pi) % (-math.pi*2) - math.pi
        local clamped_2 = math.clamp(math.atan(var44 / var43), -0.47123889803846897, 0.6283185307179586)
        local clamped = math.clamp(clamped_2, -0.25132741228718347, 0.3141592653589793)
        arg1.JointWaist.Transform = CFrame.Angles(-clamped * 0.1, 0, 0)
        arg1.JointNeck.Transform = CFrame.Angles(clamped, 0, 0)
        local any_Update_result1_2 = arg1.SpringSpin:Update()
        local var48 = arg1.SpinTotal + var37 * any_Update_result1_2
        if (-math.pi*2) < var48 then
            var48 -= (-math.pi*2)
        end
        arg1.SpinTotal = var48
        arg1.BarrelMotor.C1 = CFrame.Angles(0, 0, -16 * var48)
        arg1.VerticalMotor.C1 = CFrame.Angles(clamped_2, 0, 0)
        arg1.HorizontalMotor.C1 = CFrame.Angles(0, var35, 0)
        arg1:UpdateArmJoints()
        arg1:AnimateBarrel(var37, any_Update_result1_2)
    end
end
function module_upvr.Heartbeat(arg1) -- Line 286
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 287
    local var51 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var51 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var51 = false
            else
                var51 = true
            end
        end
    end
    if var51 then
        if arg1.Model:GetAttribute("Heat") < arg1.Config.MaxHeat then
            arg1.SpringSpin:SetTarget(1)
            arg1.MouseDown = true
            if not arg1.Sound then
                local Sound_2 = Instance.new("Sound")
                Sound_2.SoundId = "rbxassetid://2198390391"
                Sound_2.Volume = 0
                Sound_2.Looped = true
                Sound_2.Parent = arg1.Model.Barrel
                Sound_2:Play()
                arg1.Sound = Sound_2
            end
        end
        if arg1.Local then
            arg1:BroadcastInputBegan(arg2)
        end
    end
end
function module_upvr.InputEnded(arg1, arg2, arg3) -- Line 312
    local var55 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var55 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var55 = false
            else
                var55 = true
            end
        end
    end
    if var55 then
        arg1.SpringSpin:SetTarget(0)
        arg1.MouseDown = false
        delay(0.5, function() -- Line 320
            if arg1.Sound and not arg1.MouseDown then
                arg1.Sound:Destroy()
                arg1.Sound = nil
            end
        end)
        if arg1.Local then
            arg1:BroadcastInputEnded(arg2)
        end
    end
end
function module_upvr.Unequip(arg1) -- Line 331
    if arg1.FlareEmitter then
        arg1.FlareEmitter.Enabled = false
    end
    if arg1.Model and arg1.Model:FindFirstChild("Barrel") then
        arg1.Model.Barrel.Color = arg1.Config.ColorNormal
    end
    if arg1.HorizontalMotor then
        arg1.HorizontalMotor.C1 = CFrame.new()
    end
    if arg1.VerticalMotor then
        arg1.VerticalMotor.C1 = CFrame.new()
    end
    if arg1.BarrelMotor then
        arg1.BarrelMotor.C1 = CFrame.new()
    end
    arg1.SpinTotal = 0
    if arg1.Local and arg1._updateHeatRemote then
        arg1._updateHeatRemote:FireServer(arg1.Model:GetAttribute("Heat"))
    end
    if arg1.Sound then
        arg1.Sound:Destroy()
        arg1.Sound = nil
    end
end
return module_upvr