local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ConstraintUtils_upvr = require(ReplicatedStorage.Std.ConstraintUtils)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local var5_upvw
local function GetMass_upvr(arg1) -- Line 21, Named "GetMass"
    local var13
    for _, v in ipairs(arg1:GetChildren()) do
        if v:IsA("BasePart") then
            var13 += v:GetMass()
        end
        var13 += GetMass_upvr(v)
    end
    return var13
end
local zero_cframe_upvr = CFrame.new()
local function FromAxisAngle_upvr(arg1) -- Line 33, Named "FromAxisAngle"
    local x = arg1.x
    local y = arg1.y
    local z = arg1.z
    local var18 = (x * x + y * y + z * z) ^ 0.5
    if 0.00001 < var18 then
        local var19 = math.sin(var18 * 0.5) / var18
        return CFrame.new(0, 0, 0, var19 * x, var19 * y, var19 * z, math.cos(var18 * 0.5))
    end
    return zero_cframe_upvr
end
local module_upvr_2 = {
    __ClassName = "Boat";
}
module_upvr_2.__index = module_upvr_2
function module_upvr_2.Init() -- Line 47
    var5_upvw = require(LocalPlayer_upvr.PlayerScripts:WaitForChild("PlayerModule"))
end
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr_2.new(arg1, arg2) -- Line 50
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr.Config = arg1
    module_upvr.Meta = arg2
    module_upvr.Maid = Maid_upvr.new()
    module_upvr.maid = module_upvr.Maid
    module_upvr.BornAt = tick()
    module_upvr.WaterHeight = 0
    module_upvr.Model = arg2.Model
    module_upvr.Skeleton = module_upvr.Model.Skeleton
    module_upvr.PartBase = module_upvr.Skeleton:FindFirstChild("Base")
    module_upvr.Force = module_upvr.PartBase.VectorForce
    module_upvr.AlignOrientation = module_upvr.PartBase.AlignOrientation
    module_upvr:SetupSeats()
    local var25_upvw = false
    module_upvr.maid:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 70
        local any_GetAreTiresPopped_result1 = module_upvr:GetAreTiresPopped()
        if any_GetAreTiresPopped_result1 ~= var25_upvw then
            module_upvr.Model:FindFirstChild("Visual"):FindFirstChild("Body"):FindFirstChild("Smoke").Enabled = any_GetAreTiresPopped_result1
        end
        var25_upvw = any_GetAreTiresPopped_result1
    end))
    return module_upvr
end
function module_upvr_2.Setup(arg1) -- Line 81
    arg1.SpringForward = Spring_upvr.new(0, 0, 1, 10)
    arg1.SpringAccel = Spring_upvr.new(0, 0, 1, 5)
    arg1.SpringHeading = Spring_upvr.new(0, 0, 1, 20)
end
function module_upvr_2.SetupSeats(arg1) -- Line 86
    local var27
    if arg1.Seats ~= nil then
        var27 = false
    else
        var27 = true
    end
    assert(var27)
    local tbl_3 = {}
    var27 = {}
    var27.Part = assert(arg1.Model.Seat)
    var27.Driver = true
    tbl_3[1] = var27
    arg1.Seats = tbl_3
end
function module_upvr_2.MountLocalCamera(arg1, arg2) -- Line 95
    local Player_upvr = arg2.Player
    assert(Player_upvr)
    local CameraMaxZoomDistance_upvr = Player_upvr.CameraMaxZoomDistance
    arg2.Maid:GiveTask(function() -- Line 99
        Player_upvr.CameraMaxZoomDistance = CameraMaxZoomDistance_upvr
    end)
    Player_upvr.CameraMaxZoomDistance = 120
end
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
local RunService_upvr = game:GetService("RunService")
function module_upvr_2.MountPlayer(arg1, arg2, arg3) -- Line 105
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg2 == nil then
    else
    end
    assert(true)
    if arg3 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true)
    if arg2 ~= LocalPlayer_upvr then
    else
    end
    arg3.Local = true
    arg3.Character = assert(arg2.Character)
    arg3.Humanoid = assert(arg3.Character:FindFirstChild("Humanoid"))
    arg3.JointNeck = arg3.Character.Head.Neck
    arg3.JointWaist = arg3.Character.UpperTorso.Waist
    arg3.JointNeckC0 = arg3.JointNeck.C0
    arg3.JointWaistC0 = arg3.JointWaist.C0
    arg3.Maid:GiveTask(function() -- Line 120
        ConstraintUtils_upvr.setJointC0(arg3.JointNeck, arg3.JointNeckC0)
        ConstraintUtils_upvr.setJointC0(arg3.JointWaist, arg3.JointWaistC0)
    end)
    CharacterUtil_upvr.setHumanoidEnabled(arg3.Humanoid, false)
    arg3.Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
    arg3.Maid:GiveTask(function() -- Line 127
        CharacterUtil_upvr.setHumanoidEnabled(arg3.Humanoid, true)
        arg3.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end)
    if arg3.Driver then
        arg1.AlignOrientation.Enabled = true
        arg1.AlignOrientation.CFrame = arg1.Model:GetPivot()
        if arg3.Local then
            arg1:MountLocalCamera(arg3)
            arg1:SetupLocalDriverInputs(arg3)
        end
        arg3.Maid:GiveTask(function() -- Line 140
            arg1.AlignOrientation.Enabled = false
            if arg1.ForceFront ~= nil then
                arg1.ForceFront.Force = Vector3.new()
            end
        end)
        arg3.SpringWaistRotation = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.9, 20)
        arg3.SpringNeckRotation = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.9, 20)
        arg3.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 153
            if arg1.Model ~= nil then
                arg1:HeartbeatDriver(arg3)
            end
        end))
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr_2.UnmountSeat(arg1, arg2) -- Line 160
    if arg2 == nil then
    else
    end
    assert(true)
    if arg2.Occupied ~= true then
    else
    end
    assert(true)
    arg2.Local = nil
end
function module_upvr_2.UpdateCharacterJoints(arg1, arg2) -- Line 165
    ConstraintUtils_upvr.setJointC0(arg2.JointWaist, arg2.JointWaistC0 * FromAxisAngle_upvr(arg2.SpringWaistRotation:Update()))
    ConstraintUtils_upvr.setJointC0(arg2.JointNeck, arg2.JointNeckC0 * FromAxisAngle_upvr(arg2.SpringNeckRotation:Update()))
end
local tbl_2_upvr = {
    [Enum.KeyCode.A] = 2;
    [Enum.KeyCode.D] = 4;
    [Enum.KeyCode.ButtonR2] = 1;
    [Enum.KeyCode.ButtonL2] = 3;
}
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
function module_upvr_2.UpdateInput(arg1) -- Line 180
    local var40 = arg1.WASD[1] - arg1.WASD[3]
    local var41 = arg1.WASD[2] - arg1.WASD[4]
    if InputUtils_upvr.isTouch() then
        local clamped = math.clamp(var5_upvw:GetControls():GetMoveVector().X, -1, 1)
        var41 = -clamped * math.abs(clamped)
    end
    arg1.Forward = var40
    arg1.Heading = var41
    arg1.SpringForwardp = arg1.SpringForward:SetTarget(var40)
    arg1.SpringHeadingp = arg1.SpringHeading:SetTarget(var41)
    arg1.SpringAccelp = arg1.SpringAccel:SetTarget(arg1.Forward)
end
function module_upvr_2.UpdateThirdInput(arg1) -- Line 197
    error("TODO: Implement")
end
function module_upvr_2.CalculateSway(arg1) -- Line 200
    local var43 = tick() - arg1.BornAt
    local var44 = -125925.51356 + arg1.BornAt
    local var45 = -51235.65816 + arg1.BornAt
    local absolute = math.abs(arg1.SpringForwardp)
    arg1.SwayX = (math.cos(var43 * 1.1 + var44) * 0.1 * (0.5 * (1 - arg1.SpringForwardp) + 0.5) + math.noise(var43, var44) * 0.05) * (1 - absolute)
    arg1.SwayY = (math.sin(var43 * 0.8 + var45) * 0.4 + math.noise(var43, var45) * 0.1) * (1 - absolute)
end
local BoatConsts_upvr = require(ReplicatedStorage.Game.Boat.BoatConsts)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
function module_upvr_2.GetAreTiresPopped(arg1) -- Line 214
    local Name = arg1.Model.Name
    if workspace:GetServerTimeNow() >= (arg1.Model:GetAttribute(BoatConsts_upvr.TIRES_POPPED_AT_ATTR_NAME) or 0) + VehicleUtils_upvr.getVehicleCombatConfig(Name).DisableDuration then
        Name = false
    else
        Name = true
    end
    return Name
end
function module_upvr_2.UpdatePhysics(arg1) -- Line 221
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var50
    if not arg1.BuoyancySensor then
        local BuoyancySensor = Instance.new("BuoyancySensor")
        BuoyancySensor.Parent = arg1.PartBase
        arg1.BuoyancySensor = BuoyancySensor
        arg1.maid.sensor = BuoyancySensor
    end
    local TouchingSurface = BuoyancySensor.TouchingSurface
    arg1.AlignOrientation.Enabled = TouchingSurface
    local CFrame = arg1.PartBase.CFrame
    local any_VectorToObjectSpace_result1 = CFrame:VectorToObjectSpace(arg1.PartBase.Velocity)
    if 0 < arg1.SpringAccelp then
        var50 = arg1.Config
        var50 = var50.SpeedForward
    else
        var50 = arg1.Config.SpeedForward * 0.5
    end
    if arg1:GetAreTiresPopped() then
    end
    if not TouchingSurface then
    end
    arg1.Force.Force = Vector3.new(0, 0, -arg1.SpringAccelp * var50) * 0.05 * 0.25 * arg1.PartBase.AssemblyMass * 10 + -Vector3.new(any_VectorToObjectSpace_result1.X * 3, 0, any_VectorToObjectSpace_result1.Z * (arg1.Config.FrictionFwd or 0.05) + any_VectorToObjectSpace_result1.Z * math.abs(any_VectorToObjectSpace_result1.Z) * 0.001) * arg1.PartBase.AssemblyMass
    arg1.AlignOrientation.CFrame = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(CFrame.LookVector.X, 0, CFrame.LookVector.Z).Unit) * CFrame.Angles(0, 0, (math.clamp(-CFrame:VectorToObjectSpace(arg1.PartBase.RotVelocity).Y / 0.5, -1, 1) + arg1.SwayY) * math.pi * 0.03) * CFrame.Angles((math.clamp(-any_VectorToObjectSpace_result1.z / 80, -1, 1) * 0.8 + arg1.SpringAccelp * 0.2 + arg1.SwayX) * math.pi * 0.02, 0, 0) * CFrame.Angles(0, (math.clamp(1 - (arg1.Config.TurnCurveCoeff or 1) * math.sqrt(math.clamp((math.abs(-any_VectorToObjectSpace_result1.Z) - 100) / 800, 0, 1)), 0.05, 1)) * (arg1.SpringHeadingp * math.pi * arg1.Config.MaximumTurnAngle) * 0.25, 0) + CFrame.p
end
function module_upvr_2.HeartbeatDriver(arg1, arg2) -- Line 288
    if arg2 == nil then
    else
    end
    assert(true)
    if arg1.Model ~= nil then
        if arg2.Local then
            arg1:UpdateInput()
            arg1:CalculateSway()
            arg1:UpdatePhysics()
        else
            arg1:UpdateThirdInput()
        end
        arg1:UpdateCharacterJoints(arg2)
    end
end
local UserInputService_upvr = game:GetService("UserInputService")
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
function module_upvr_2.SetupLocalDriverInputs(arg1, arg2) -- Line 301
    arg1.WASD = {0, 0, 0, 0}
    arg2.Maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2_2) -- Line 303, Named "InputBegan"
        if arg2_2 then
            return true
        end
        if arg1_2.UserInputType == Enum.UserInputType.Keyboard and tbl_2_upvr[arg1_2.KeyCode] then
            arg1.WASD[tbl_2_upvr[arg1_2.KeyCode]] = 1
        end
    end))
    arg2.Maid:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_3, arg2_3) -- Line 314, Named "InputEnded"
        if arg2_3 then
            return true
        end
        if arg1_3.UserInputType == Enum.UserInputType.Keyboard and tbl_2_upvr[arg1_3.KeyCode] then
            arg1.WASD[tbl_2_upvr[arg1_3.KeyCode]] = 0
        end
    end))
    arg2.Maid:GiveTask(UserInputService_upvr.InputChanged:Connect(function(arg1_4) -- Line 325, Named "InputChanged"
        if arg1_4.UserInputType == Enum.UserInputType.Gamepad1 then
            local KeyCode = arg1_4.KeyCode
            local var59
            if KeyCode == Enum.KeyCode.Thumbstick1 then
                local X = arg1_4.Position.X
                local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var59 = (-X) ^ 2
                    return var59
                end
                if X >= -0.24 or not decompInlinedCondition() then
                    var59 = 0
                end
                arg1.WASD[2] = var59
                local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var59 = X ^ 2
                    return var59
                end
                if 0.24 >= X or not decompInlinedCondition_2() then
                    var59 = 0
                end
                arg1.WASD[4] = var59
                return
            end
            if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
                local Z = arg1_4.Position.Z
                var59 = tbl_2_upvr
                local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var59 = Z ^ 0.5
                    return var59
                end
                if 0.05 >= Z or not decompInlinedCondition_3() then
                    var59 = 0
                end
                arg1.WASD[var59[KeyCode]] = var59
            end
        end
    end))
    local tbl = {
        primary = true;
        priority = 1000;
        saturateTo = 0;
        image = "rbxassetid://7858765663";
        keyCodes = {Enum.KeyCode.W};
    }
    local function onPressed() -- Line 350
        arg1.WASD[1] = 1
    end
    tbl.onPressed = onPressed
    local function onReleased() -- Line 353
        arg1.WASD[1] = 0
    end
    tbl.onReleased = onReleased
    arg2.Maid:GiveTask(ActionButtonService_upvr.add(tbl))
    arg2.Maid:GiveTask(ActionButtonService_upvr.add({
        primary = true;
        priority = 700;
        saturateTo = 0;
        image = "rbxassetid://7858764373";
        keyCodes = {Enum.KeyCode.S};
        onPressed = function() -- Line 363, Named "onPressed"
            arg1.WASD[3] = 1
        end;
        onReleased = function() -- Line 366, Named "onReleased"
            arg1.WASD[3] = 0
        end;
    }))
    arg1:UpdateInput()
end
function module_upvr_2.Destroy(arg1) -- Line 374
    arg1.Maid:Destroy()
end
return module_upvr_2