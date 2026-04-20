local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local var3_upvw
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr_2 = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local JetPackUtil_upvr = require(ReplicatedStorage_upvr.Game.JetPack.JetPackUtil)
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
local JetPackGui_upvr = require(script.Parent.JetPackGui)
local var10_upvw
local var11_upvw
local function SetHumanoidEnabled_upvr(arg1, arg2) -- Line 44, Named "SetHumanoidEnabled"
    for _, v in next, Enum.HumanoidStateType:GetEnumItems() do
        if v ~= Enum.HumanoidStateType.Dead and v ~= Enum.HumanoidStateType.None and v ~= Enum.HumanoidStateType.Jumping then
            arg1:SetStateEnabled(v, arg2)
        end
    end
end
local tbl_4_upvr = {}
local var17_upvw = false
local tbl_upvr = {
    OnEquipped = nil;
}
local tbl_2_upvr = {
    LocalMaxFuel = 15;
    LocalFuel = 15;
    LocalFuelType = "Standard";
}
local tbl_3_upvr = {}
local var21_upvw
local var22_upvw
local var23_upvw = false
local function _() -- Line 77, Named "StopThreads"
    local var24
    if var23_upvw ~= true then
        var24 = false
    else
        var24 = true
    end
    assert(var24)
    var21_upvw:Disconnect()
    var21_upvw = nil
    var22_upvw:Disconnect()
    var22_upvw = nil
    var23_upvw = false
end
local function _() -- Line 85, Named "CheckThreads"
    if var23_upvw == false then
        return true
    end
    local var25 = tbl_3_upvr
    if #var25 == 0 then
        if var23_upvw ~= true then
            var25 = false
        else
            var25 = true
        end
        assert(var25)
        var21_upvw:Disconnect()
        var21_upvw = nil
        var22_upvw:Disconnect()
        var22_upvw = nil
        var23_upvw = false
        return true
    end
    return false
end
local function Stepped(arg1, arg2) -- Line 96
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var30
    if var23_upvw == false then
        var30 = true
    else
        local var31 = tbl_3_upvr
        if #var31 == 0 then
            if var23_upvw ~= true then
            else
            end
            assert(true)
            var21_upvw:Disconnect()
            var21_upvw = nil
            var22_upvw:Disconnect()
            var22_upvw = nil
            var23_upvw = false
            var30 = true
        else
            var30 = false
        end
    end
    if var30 then
        var30 = false
        return var30
    end
    var30 = 1
    for i_2 = #tbl_3_upvr, var30, -1 do
        tbl_2_upvr.Stepped(tbl_3_upvr[i_2], arg2)
    end
end
local function Heartbeat(arg1) -- Line 104
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var36
    if var23_upvw == false then
        var36 = true
    else
        local var37 = tbl_3_upvr
        if #var37 == 0 then
            if var23_upvw ~= true then
            else
            end
            assert(true)
            var21_upvw:Disconnect()
            var21_upvw = nil
            var22_upvw:Disconnect()
            var22_upvw = nil
            var23_upvw = false
            var36 = true
        else
            var36 = false
        end
    end
    if var36 then
        var36 = false
        return var36
    end
    var36 = 1
    for i_3 = #tbl_3_upvr, var36, -1 do
        tbl_2_upvr.Heartbeat(tbl_3_upvr[i_3], arg1)
    end
end
local function _() -- Line 112, Named "StartThreads"
    local var38
    if var23_upvw ~= false then
        var38 = false
    else
        var38 = true
    end
    assert(var38)
    var23_upvw = true
    var22_upvw = RunService_upvr.Stepped:Connect(Stepped)
    var21_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
end
local function _(arg1) -- Line 119, Named "AddPacket"
    table.insert(tbl_3_upvr, arg1)
    local var39 = tbl_3_upvr
    if #var39 == 1 then
        if var23_upvw ~= false then
            var39 = false
        else
            var39 = true
        end
        assert(var39)
        var23_upvw = true
        var22_upvw = RunService_upvr.Stepped:Connect(Stepped)
        var21_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
    end
end
local function _(arg1) -- Line 125, Named "GetPacketByPlayer"
    for i_4 = #tbl_3_upvr, 1, -1 do
        local var41 = tbl_3_upvr[i_4]
        if var41.Player == arg1 then
            return var41, i_4
        end
    end
    return nil
end
local Paraglide_upvr = require(ReplicatedStorage_upvr.Game.Paraglide)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function tbl_2_upvr.Equip(arg1, arg2) -- Line 134
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var44
    if Paraglide_upvr.IsFlying() == true then
        Paraglide_upvr.ParachuteStop()
    end
    assert(arg1, "Player is nil")
    local Character = arg1.Character
    assert(Character, "Character is nil")
    local Humanoid_2 = Character:FindFirstChild("Humanoid")
    if not Humanoid_2 then
        return nil
    end
    if Humanoid_2.Health <= 0 then
        return nil
    end
    local RootPart_3 = Humanoid_2.RootPart
    if not RootPart_3 then
        return nil
    end
    local module = {}
    module.Player = arg1
    module.Character = Character
    module.Humanoid = Humanoid_2
    module.RootPart = RootPart_3
    module.Model = Character.JetPack
    module.IsThrusting = false
    module.EquippedAt = tick()
    module.SoundThrust = Audio_upvr.ObjectLocal(RootPart_3, 9058734199, {
        Looped = true;
        Volume = 0;
    })
    module.SoundThrustVolumeTarget = 0.3
    Audio_upvr.ObjectLocal(RootPart_3, 1386598740, {
        TimePosition = 0.5;
        Volume = 0.1;
    })
    if arg1 == LocalPlayer_upvr then
        tbl_2_upvr.EquipLocal(module)
    else
        assert(arg2)
        assert(JetPackUtil_upvr.Fuel[arg2])
    end
    table.insert(tbl_3_upvr, module)
    if #tbl_3_upvr == 1 then
        if var23_upvw ~= false then
        else
        end
        assert(true)
        var23_upvw = true
        var22_upvw = RunService_upvr.Stepped:Connect(Stepped)
        var21_upvw = RunService_upvr.Heartbeat:Connect(Heartbeat)
    end
    if arg1 == LocalPlayer_upvr then
        var11_upvw:FireServer('d'.."fcxxsacojwh":sub(4, 8):reverse():reverse():reverse().."".."".."exzoy":sub(3, 3):reverse():reverse():reverse():reverse():reverse()..""..'5')
    end
    return module
end
function tbl_2_upvr.UpdateFuel() -- Line 182
    JetPackGui_upvr.UpdateFuel(tbl_2_upvr.LocalFuel, tbl_2_upvr.LocalMaxFuel)
    for _, v_2 in LocalPlayer_upvr.Character:GetChildren() do
        if v_2:IsA("Model") and v_2:GetAttribute("IsJetPack") == true then
            local FuelBar = v_2:FindFirstChild("FuelBar")
            local len = #FuelBar:GetChildren()
            for i_6 = 1, len do
                if i_6 <= math.ceil(len * tbl_2_upvr.LocalFuel / tbl_2_upvr.LocalMaxFuel - 0.001) then
                    FuelBar[i_6].Color = Color3.fromRGB(78, 109, 130)
                    FuelBar[i_6].Material = Enum.Material.Neon
                else
                    FuelBar[i_6].Color = Color3.fromRGB(42, 56, 66)
                    FuelBar[i_6].Material = Enum.Material.SmoothPlastic
                end
            end
        end
    end
end
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
function tbl_2_upvr.EquipLocal(arg1) -- Line 201
    local Humanoid = arg1.Humanoid
    SetHumanoidEnabled_upvr(Humanoid, false)
    Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
    local class_Animator_upvr = Humanoid:FindFirstChildOfClass("Animator")
    task.delay(0.1, function() -- Line 209
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local _ = #tbl_3_upvr
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [16.6]
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [16.198]
        if nil == Players_upvr.LocalPlayer then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    local RootPart = arg1.RootPart
    arg1.MovingSpring = Spring_upvr.new(0, 0, 0.8, 10)
    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    BodyVelocity.Velocity = RootPart.Velocity
    BodyVelocity.Parent = RootPart
    arg1.BodyVelocity = BodyVelocity
    local BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
    BodyGyro.D = 100
    BodyGyro.P = 500
    BodyGyro.Parent = RootPart
    arg1.BodyGyro = BodyGyro
    local clone = ReplicatedStorage_upvr.Resource.JetPack.GroundSmoke:Clone()
    clone.Parent = workspace
    arg1.GroundSmokeLeft = clone
    local clone_2 = ReplicatedStorage_upvr.Resource.JetPack.GroundSmoke:Clone()
    clone_2.Parent = workspace
    arg1.GroundSmokeRight = clone_2
    arg1.GroundSmokeLastEmit = tick()
    arg1.ConnAnimationPlayed = Humanoid.AnimationPlayed:Connect(function(arg1_2) -- Line 249
        arg1_2:Stop()
    end)
    local var70 = JetPackUtil_upvr.Fuel[tbl_2_upvr.LocalFuelType]
    assert(var70)
    arg1.LeanAngle = var70.LeanAngle
    assert(tbl_2_upvr.LocalFuel)
    assert(tbl_2_upvr.LocalMaxFuel)
    tbl_2_upvr.UpdateFuel()
    tbl_upvr.OnEquipped:Fire()
end
function tbl_2_upvr.Unequip(arg1) -- Line 264
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _ = #tbl_3_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.7]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.454]
    if nil == arg1 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function tbl_2_upvr.UnequipLocal(arg1) -- Line 288
    local Humanoid_6 = arg1.Humanoid
    local any_GetLocalVehiclePacket_result1 = VehicleUtils_upvr_2.GetLocalVehiclePacket()
    if not any_GetLocalVehiclePacket_result1 or any_GetLocalVehiclePacket_result1.Make ~= "Volt" then
        SetHumanoidEnabled_upvr(Humanoid_6, true)
    end
    Humanoid_6:ChangeState(Enum.HumanoidStateType.GettingUp)
    arg1.BodyGyro:Destroy()
    arg1.BodyGyro = nil
    arg1.BodyVelocity:Destroy()
    arg1.BodyVelocity = nil
    arg1.ConnAnimationPlayed:Disconnect()
    arg1.ConnAnimationPlayed = nil
end
function tbl_2_upvr.UpdateJoints(arg1, arg2) -- Line 305
    local Character_2 = arg1.Character
    if not Character_2:IsDescendantOf(workspace) then
        tbl_2_upvr.Unequip(arg1.Player)
    end
    local Neck = Character_2.Head:FindFirstChild("Neck")
    if not Neck then
        tbl_2_upvr.Unequip(arg1.Player)
        return false
    end
    local any_ToOrientation_result1, _, _ = arg1.RootPart.CFrame:ToOrientation()
    Neck.Transform = CFrame.Angles(-any_ToOrientation_result1 * 0.7, 0, 0)
    Character_2.RightLowerArm.RightElbow.Transform = CFrame.Angles(1.2566370614359172, 0, -0.37699111843077515)
    Character_2.LeftLowerArm.LeftElbow.Transform = CFrame.Angles(1.2566370614359172, 0, 0.37699111843077515)
    Character_2.RightUpperArm.RightShoulder.Transform = CFrame.Angles(0.3141592653589793, 0, 0)
    Character_2.LeftUpperArm.LeftShoulder.Transform = CFrame.Angles(0.3141592653589793, 0, 0)
    Character_2.RightUpperLeg.RightHip.Transform = CFrame.Angles(math.pi * arg2 * 0.15, 0, 0.05 + arg2 * 0.1)
    Character_2.LeftUpperLeg.LeftHip.Transform = CFrame.Angles(math.pi * arg2 * 0.15, 0, -0.05 + arg2 * -0.1)
    Character_2.RightLowerLeg.RightKnee.Transform = CFrame.Angles(math.pi * arg2 * -0.3, 0, 0)
    Character_2.LeftLowerLeg.LeftKnee.Transform = CFrame.Angles(math.pi * arg2 * -0.3, 0, 0)
end
function tbl_2_upvr.Stepped(arg1, arg2) -- Line 341
    local Humanoid_5 = arg1.Humanoid
    if Humanoid_5.Health <= 0 then
        tbl_2_upvr.Unequip(arg1.Player)
    else
        if not Humanoid_5:IsDescendantOf(workspace) then
            tbl_2_upvr.Unequip(arg1.Player)
            return
        end
        if arg1.Player == LocalPlayer_upvr then
            tbl_2_upvr.SteppedLocal(arg1, arg2)
            return
        end
        tbl_2_upvr.UpdateJoints(arg1, math.clamp(arg1.RootPart.Velocity.Magnitude / 20, 0, 1))
    end
end
function tbl_2_upvr.SteppedLocal(arg1, arg2) -- Line 361
    tbl_2_upvr.UpdateJoints(arg1, arg1.MovingSpring:Update() * 0.5 + 0.5)
    for _, v_3 in ipairs(tbl_4_upvr) do
        v_3.Region:Update({LocalPlayer_upvr})
    end
end
function tbl_2_upvr.Heartbeat(arg1, arg2) -- Line 370
    local Humanoid_4 = arg1.Humanoid
    if Humanoid_4.Health <= 0 then
        tbl_2_upvr.Unequip(arg1.Player)
    else
        if not Humanoid_4:IsDescendantOf(workspace) then
            tbl_2_upvr.Unequip(arg1.Player)
            return
        end
        arg1.SoundThrust.Volume = arg1.SoundThrust.Volume + (arg1.SoundThrustVolumeTarget - arg1.SoundThrust.Volume) * 0.1
        if arg1.Player == LocalPlayer_upvr then
            tbl_2_upvr.HeartbeatLocal(arg1, arg2)
        end
    end
end
local CurrentCamera_upvr = workspace.CurrentCamera
local any_new_result1_upvr = require(ReplicatedStorage_upvr.Std.AccelTween).new(80)
local abs_upvr = math.abs
function tbl_2_upvr.HeartbeatLocal(arg1, arg2) -- Line 389
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local tick_result1_2 = tick()
    local any_GetMoveVector_result1 = var3_upvw:GetControls():GetMoveVector()
    local _, _, _, _, any_GetComponents_result5, any_GetComponents_result6, _, any_GetComponents_result8, any_GetComponents_result9, _, any_GetComponents_result11, any_GetComponents_result12_2 = CurrentCamera_upvr.CFrame:GetComponents()
    local var131 = 0
    local RootPart_4 = arg1.Humanoid.RootPart
    if 0.001 >= any_GetMoveVector_result1.Magnitude then
        var131 = false
    else
        var131 = true
    end
    if var131 then
        arg1.LastCF = CFrame.new(0, 0, var131, -any_GetComponents_result11 * any_GetComponents_result9 + any_GetComponents_result8 * any_GetComponents_result12_2, 0, any_GetComponents_result6, any_GetComponents_result11 * any_GetComponents_result6 - any_GetComponents_result5 * any_GetComponents_result12_2, 1, any_GetComponents_result9, -any_GetComponents_result8 * any_GetComponents_result6 + any_GetComponents_result5 * any_GetComponents_result9, 0, any_GetComponents_result12_2) * CFrame.new(Vector3.new(), any_GetMoveVector_result1)
    end
    local var134
    if var131 and arg1.IsThrusting then
        var134 = 1
    else
        var134 = 0
    end
    arg1.MovingSpring:SetTarget(var134)
    if arg1.LastCF then
        local Position_2 = RootPart_4.Position
        if not var131 or not arg1.IsThrusting or not arg1.LeanAngle then
        end
        var134 = arg1.LastCF * CFrame.Angles(0, 0, 0) + Vector3.new(Position_2.x, Position_2.y, Position_2.z)
        arg1.BodyGyro.CFrame = var134
    end
    local Velocity = RootPart_4.Velocity
    local var137 = 100
    local var138 = 1
    if arg1.IsThrusting then
        var137 = 200
        if 1 < os.clock() - arg1.ThrustingBornAt then
            var137 = 450
        else
            var138 *= 3
        end
    end
    if any_new_result1_upvr.t ~= var137 then
        if any_new_result1_upvr.t < 200 or var137 < any_new_result1_upvr.t then
            any_new_result1_upvr.pt = var137
        else
            any_new_result1_upvr.t = var137
        end
    end
    arg1.BodyVelocity.Velocity = Velocity + (Vector3.new(0, -2746.8, 0) + Vector3.new(var138 * -4 * 0.5 * Velocity.x * abs_upvr(Velocity.x), -6 * Velocity.y * abs_upvr(Velocity.y), var138 * -4 * 0.5 * Velocity.z * abs_upvr(Velocity.z)) + (RootPart_4.CFrame.UpVector) * (14 * any_new_result1_upvr.p)) / 14 * arg2
    local any_RayIgnoreNonCollide_result1_2, any_RayIgnoreNonCollide_result2 = RayCast_upvr.RayIgnoreNonCollide(RootPart_4.Position, Vector3.new(0, -1, 0), 20, LocalPlayer_upvr.Character)
    if any_RayIgnoreNonCollide_result1_2 ~= nil and arg1.IsThrusting and 0.05 < tick_result1_2 - arg1.GroundSmokeLastEmit and arg1.LastCF then
        arg1.GroundSmokeRight.CFrame = CFrame.new(any_RayIgnoreNonCollide_result2.x, any_RayIgnoreNonCollide_result2.y + 1, any_RayIgnoreNonCollide_result2.z) + arg1.LastCF * Vector3.new(2, 0, 0)
        arg1.GroundSmokeRight.LandingSmoke:Emit(1)
        arg1.GroundSmokeLeft.CFrame = CFrame.new(any_RayIgnoreNonCollide_result2.x, any_RayIgnoreNonCollide_result2.y + 1, any_RayIgnoreNonCollide_result2.z) + arg1.LastCF * Vector3.new(-2, 0, 0)
        arg1.GroundSmokeLeft.LandingSmoke:Emit(1)
        arg1.GroundSmokeLastEmit = tick_result1_2
    end
    local var141
    if 0.1 < tick_result1_2 - arg1.EquippedAt and not arg1.IsThrusting then
        var141 = arg1.Humanoid.HipHeight + RootPart_4.Size.Y * 0.5
        var141 = LocalPlayer_upvr
        var141 = var141.Character
        local any_RayIgnoreNonCollide_result1_3, _ = RayCast_upvr.RayIgnoreNonCollide(RootPart_4.Position, Vector3.new(0, -1, 0), var141 + 0.5, var141)
        if any_RayIgnoreNonCollide_result1_3 then
            tbl_2_upvr.Unequip(LocalPlayer_upvr)
        end
    end
    if arg1.IsThrusting then
        var141 = 1
    else
        var141 = 0.3333333333333333
    end
    tbl_2_upvr.LocalFuel -= arg2 * var141
    if tbl_2_upvr.LocalFuel < 0 then
        tbl_2_upvr.LocalFuel = 0
        tbl_2_upvr.Unequip(arg1.Player)
    end
    tbl_2_upvr.UpdateFuel()
    if VehicleUtils_upvr_2.GetLocalVehiclePacket() ~= nil then
        tbl_2_upvr.Unequip(arg1.Player)
    end
end
function tbl_2_upvr.SetThrustVisual(arg1, arg2) -- Line 486
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var152
    if 0.001 >= arg2 then
        var152 = false
    else
        var152 = true
    end
    if 0.5 >= arg2 then
    else
    end
    local Model = arg1.Model
    if Model and Model.Parent then
        for _, v_4 in Model.Body:GetDescendants() do
            if v_4:IsA("ParticleEmitter") then
                if v_4.Name == "Flamethrower" then
                    v_4.Enabled = true
                else
                    v_4.Enabled = var152
                end
            end
        end
    end
end
function tbl_2_upvr.StartThrust(arg1) -- Line 502
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(arg1)
    local _ = #tbl_3_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [18.6]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [18.454]
    if nil == arg1 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function tbl_2_upvr.StopThrust(arg1) -- Line 531
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(arg1)
    local _ = #tbl_3_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [18.6]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [18.454]
    if nil == arg1 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local const_number_upvw = 0
local Time_upvr = require(ReplicatedStorage_upvr.Module.Time)
local function OnJump_upvr() -- Line 563, Named "OnJump"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if var10_upvw.IsRagdolling() then return end
    for _, v_5 in ipairs(tbl_4_upvr) do
        v_5.Region:Update({LocalPlayer_upvr})
    end
    local _ = #tbl_3_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [40.7]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [40.454]
    if nil == LocalPlayer_upvr then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function jumpPressed_upvr() -- Line 592, Named "jumpPressed"
    OnJump_upvr()
end
local function jumpReleased_upvr() -- Line 595, Named "jumpReleased"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _ = #tbl_3_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.7]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.454]
    if nil == LocalPlayer_upvr then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
local DefaultActions_upvr = require(ReplicatedStorage_upvr.Game.DefaultActions)
local Region_upvr = require(ReplicatedStorage_upvr.Std.Region)
local RegionUtils_upvr = require(ReplicatedStorage_upvr.Std.Region.RegionUtils)
local CollectionService_upvr = game:GetService("CollectionService")
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
return {
    Init = function(arg1) -- Line 608, Named "Init"
        var10_upvw = require(ReplicatedStorage_upvr.Game.Falling)
        var3_upvw = require(LocalPlayer_upvr.PlayerScripts:WaitForChild("PlayerModule"))
        tbl_upvr.OnEquipped = Signal_upvr.new()
        JetPackGui_upvr.Init()
        var10_upvw.OnRagdolled:Connect(function() -- Line 614
            tbl_2_upvr.Unequip(LocalPlayer_upvr)
        end)
        local em = arg1.em
        var11_upvw = arg1.Event
        function em.docasxz5(arg1_3, arg2) -- Line 620
            assert(arg1_3)
            tbl_2_upvr.Equip(arg1_3, arg2)
        end
        function em.z9l6l9ax(arg1_4) -- Line 624
            assert(arg1_4)
            tbl_2_upvr.Unequip(arg1_4)
        end
        function em.ojwfx4d6(arg1_5) -- Line 628
            assert(arg1_5)
            tbl_2_upvr.StartThrust(arg1_5)
        end
        function em.drcabdoq(arg1_6) -- Line 632
            assert(arg1_6)
            tbl_2_upvr.StopThrust(arg1_6)
        end
        local var185_upvw = false
        local var186_upvw
        local var187_upvw
        function em.wqcrorzq() -- Line 638
            local var188
            if var185_upvw ~= false then
                var188 = false
            else
                var188 = true
            end
            assert(var188)
            var186_upvw = DefaultActions_upvr.onJumpPressed:Connect(jumpPressed_upvr)
            var187_upvw = DefaultActions_upvr.onJumpReleased:Connect(jumpReleased_upvr)
            var185_upvw = true
            var188 = tbl_2_upvr
            var188 = var188.LocalMaxFuel
            tbl_2_upvr.LocalFuel = var188
            tbl_2_upvr.UpdateFuel()
        end
        function em.w0owff5i() -- Line 649
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local var189
            if var185_upvw ~= true then
                var189 = false
            else
                var189 = true
            end
            assert(var189)
            var186_upvw:Disconnect()
            var186_upvw = nil
            var187_upvw:Disconnect()
            var187_upvw = nil
            var185_upvw = false
            local _ = #tbl_3_upvr
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [37.7]
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [37.454]
            if nil == LocalPlayer_upvr then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        local function AddedFun(arg1_7) -- Line 662, Named "h8038vme"
            tbl_2_upvr.LocalFuel = math.max(tbl_2_upvr.LocalFuel - arg1_7 / 10, 0)
            tbl_2_upvr.UpdateFuel()
        end
        em.h8038vme = AddedFun
        function AddedFun(arg1_8) -- Line 667
            local tbl = {}
            tbl.Part = arg1_8
            tbl.Region = Region_upvr.new(RegionUtils_upvr.ConditionPlayer)
            tbl.Region:AddPart(tbl.Part)
            tbl.Region.OnObjAdded:Connect(function(arg1_9) -- Line 673
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                local var194
                if arg1_9 ~= LocalPlayer_upvr then
                    var194 = false
                else
                    var194 = true
                end
                assert(var194)
                var17_upvw = true
                local _ = #tbl_3_upvr
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [25.8]
                -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [25.710]
                if nil == LocalPlayer_upvr then
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            end)
            tbl.Region.OnObjRemoved:Connect(function(arg1_10) -- Line 680
                local var197
                if arg1_10 ~= LocalPlayer_upvr then
                    var197 = false
                else
                    var197 = true
                end
                assert(var197)
                var17_upvw = false
            end)
            table.insert(tbl_4_upvr, tbl)
        end
        local var191 = AddedFun
        for _, v_6 in ipairs(CollectionService_upvr:GetTagged("JetPackNoFly")) do
            var191(v_6)
        end
        CollectionService_upvr:GetInstanceAddedSignal("JetPackNoFly"):Connect(var191)
        CollectionService_upvr:GetInstanceRemovedSignal("JetPackNoFly"):Connect(function(arg1_11) -- Line 686, Named "RemovedFun"
            for i_10 = #tbl_4_upvr, 1, -1 do
                local var199 = tbl_4_upvr[i_10]
                if var199.Part == arg1_11 then
                    table.remove(tbl_4_upvr, i_10)
                    var199.Region:Destroy()
                    return
                end
            end
        end)
        var10_upvw.OnRagdoll:Connect(function() -- Line 704
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local _ = #tbl_3_upvr
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.6]
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.198]
            if nil == LocalPlayer_upvr then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
        Interval_upvr.every(0.2):Connect(function() -- Line 711
            if not var185_upvw then
            else
                local assert_result1 = assert(LocalPlayer_upvr.Character)
                local Humanoid_3 = assert_result1:FindFirstChild("Humanoid")
                assert(Humanoid_3)
                local RootPart_2 = Humanoid_3.RootPart
                assert(RootPart_2)
                if RayCast_upvr.RayIgnoreNonCollide(RootPart_2.Position, Vector3.new(0, -1, 0), Humanoid_3.HipHeight + RootPart_2.Size.Y * 0.5 + 2, assert_result1) == nil then return end
                if tbl_2_upvr.LocalFuel < tbl_2_upvr.LocalMaxFuel then
                    local var209 = tbl_2_upvr
                    var209.LocalFuel += 0.1
                    if tbl_2_upvr.LocalMaxFuel < tbl_2_upvr.LocalFuel then
                        tbl_2_upvr.LocalFuel = tbl_2_upvr.LocalMaxFuel
                    end
                    tbl_2_upvr.UpdateFuel()
                end
            end
        end)
        VehicleUtils_upvr.OnVehicleEntered:Connect(function() -- Line 738
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local _ = #tbl_3_upvr
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.6]
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.198]
            if nil == LocalPlayer_upvr then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
    end;
    Stunned = function() -- Line 600, Named "Stunned"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local _ = #tbl_3_upvr
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.7]
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.454]
        if nil == LocalPlayer_upvr then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    IsFlying = function() -- Line 553, Named "IsFlying"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local _ = #tbl_3_upvr
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.6]
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.198]
        if nil == LocalPlayer_upvr then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    IsThrusting = function() -- Line 557, Named "IsThrusting"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local _ = #tbl_3_upvr
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.6]
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.198]
        if nil == LocalPlayer_upvr then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    Signal = tbl_upvr;
}