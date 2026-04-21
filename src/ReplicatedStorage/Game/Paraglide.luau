local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
local var6_upvw
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local CollectionService_upvr = game:GetService("CollectionService")
local C4Consts_upvr = require(ReplicatedStorage.Game.C4.C4Consts)
local new_upvr = Vector3.new
local FindPartOnRayWithIgnoreList_upvw = workspace.FindPartOnRayWithIgnoreList
local function fpor2_upvw(arg1, arg2, ...) -- Line 18, Named "fpor2"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local magnitude = arg2.magnitude
    local unit = arg2.unit
    local args_list = {...}
    TableUtils_upvr.concatInPlace(args_list, CollectionService_upvr:GetTagged(C4Consts_upvr.TAG_NAME))
    local var15
    if var15 then
        var15 = table.insert
        var15(args_list, workspace.NetworkFixPart1)
    end
    var15 = nil
    repeat
        local FindPartOnRayWithIgnoreList_upvw_result1, FindPartOnRayWithIgnoreList_upvw_result2, _ = FindPartOnRayWithIgnoreList_upvw(workspace, Ray.new(arg1, unit * (magnitude - 0)), args_list, false, true)
        var15 = FindPartOnRayWithIgnoreList_upvw_result1
        FindPartOnRayWithIgnoreList_upvw_result1 = var15
        local var20 = FindPartOnRayWithIgnoreList_upvw_result1
        if var20 then
            var20 = var15.CanCollide
        end
        local var21 = var20
        if not var21 then
            table.insert(args_list, var15)
        end
    until var21 and magnitude - (arg1 - FindPartOnRayWithIgnoreList_upvw_result2).magnitude <= 0.001 and 4 < 0 + 1
    if not var15 then
    end
    return var15, arg1 + unit * magnitude, new_upvr
end
new_upvr = nil
FindPartOnRayWithIgnoreList_upvw = nil
local any_new_result1_upvr = Signal.new()
local any_new_result1_upvr_2 = Signal.new()
local var24_upvw
local function UpdateParachute_upvr() -- Line 60, Named "UpdateParachute"
    local HumanoidRootPart = var24_upvw.HumanoidRootPart
    local var27 = CurrentCamera_upvr.CFrame * CFrame.Angles(0.2, 0, 0)
    local absolute = math.abs(var27.LookVector:Dot(Vector3.new(0, 1, 0)))
    var24_upvw.Velocity.Velocity = Vector3.new(var27.LookVector.X, 0, var27.lookVector.Z) * 60 * math.max(0.5, absolute) + Vector3.new(0, absolute, 0) * -40
    var24_upvw.Gyro.CFrame = CFrame.new(Vector3.new(), var27.lookVector) * CFrame.new(0, 0, math.clamp(HumanoidRootPart.RotVelocity.y, -4, 4) * 0.125)
    local fpor2_result1_2, fpor2_upvw_result2 = fpor2_upvw(HumanoidRootPart.Position, Vector3.new(0, -4, 0), HumanoidRootPart.Parent)
    if fpor2_result1_2 and not fpor2_result1_2:IsDescendantOf(workspace.Vehicles) then
        FindPartOnRayWithIgnoreList_upvw()
    end
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local function RawParachute_upvr() -- Line 77, Named "RawParachute"
    if var24_upvw then
        print("Already has parachute")
        return false
    end
    local Character_2 = LocalPlayer_upvr.Character
    if not Character_2 then
        return false
    end
    local Humanoid = Character_2:FindFirstChild("Humanoid")
    if not Humanoid then
        return false
    end
    local PrimaryPart = Character_2.PrimaryPart
    if not PrimaryPart then
        return false
    end
    if Humanoid.PlatformStand then
        return false
    end
    if Humanoid.Sit then
        return false
    end
    Humanoid.PlatformStand = true
    Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
    var24_upvw = {}
    var24_upvw.Type = "Parachute"
    local BodyGyro_2 = Instance.new("BodyGyro")
    BodyGyro_2.MaxTorque = Vector3.new(10000, 10000, 10000)
    BodyGyro_2.CFrame = CurrentCamera_upvr.CFrame * CFrame.Angles(0.2, 0, 0)
    BodyGyro_2.Parent = PrimaryPart
    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    BodyVelocity.Velocity = Vector3.new(0, -1, 0)
    BodyVelocity.Parent = PrimaryPart
    var24_upvw.Gyro = BodyGyro_2
    var24_upvw.Velocity = BodyVelocity
    var24_upvw.HumanoidRootPart = PrimaryPart
    var24_upvw.Humanoid = Humanoid
    Audio_upvr.ObjectLocal(Humanoid.RootPart, 4482070135)
    var24_upvw.Loop = RunService_upvr.Heartbeat:Connect(UpdateParachute_upvr)
    return true
end
local function _() -- Line 127, Named "RawParachuteStop"
    if not var24_upvw then
        return false
    end
    if var24_upvw.Type ~= "Parachute" then
        return false
    end
    var24_upvw.Gyro:Destroy()
    var24_upvw.Velocity:Destroy()
    var24_upvw.Loop:Disconnect()
    var24_upvw.Humanoid.PlatformStand = false
    var24_upvw = nil
    any_new_result1_upvr:Fire()
    return true
end
function new_upvr() -- Line 143, Named "Parachute"
    if not RawParachute_upvr() then
        return false
    end
    var6_upvw:FireServer('s'..("o02hf61"):sub(3, 4):reverse():reverse():reverse()..""..""..("xxz9h"):sub(2, 2):reverse()..""..""..("pfsmeyt"):sub(3, 4):reverse():reverse():reverse().."".."g6")
end
function FindPartOnRayWithIgnoreList_upvw() -- Line 150, Named "ParachuteStop"
    local var37
    if not var24_upvw then
        var37 = false
    elseif var24_upvw.Type ~= "Parachute" then
        var37 = false
    else
        var24_upvw.Gyro:Destroy()
        var24_upvw.Velocity:Destroy()
        var24_upvw.Loop:Disconnect()
        var24_upvw.Humanoid.PlatformStand = false
        var24_upvw = nil
        any_new_result1_upvr:Fire()
        var37 = true
    end
    if not var37 then
        return false
    end
    var6_upvw:FireServer('x'..""..("gaa8cc"):sub(2, 4):reverse():reverse():reverse().."".."kj83")
end
local GliderStop_upvw
local function UpdateGlider_upvr() -- Line 157, Named "UpdateGlider"
    local HumanoidRootPart_2 = var24_upvw.HumanoidRootPart
    local var40 = CurrentCamera_upvr.CFrame * CFrame.Angles(0.2, 0, 0)
    local absolute_2 = math.abs(math.clamp(var40.lookVector:Dot(Vector3.new(0, 1, 0)), -1, -0.06))
    var24_upvw.Velocity.Velocity = Vector3.new(var40.lookVector.X, 0, var40.lookVector.Z) * 60 * math.max(0.9, absolute_2) + Vector3.new(0, absolute_2, 0) * -90
    var24_upvw.Gyro.CFrame = CFrame.new(Vector3.new(), var40.lookVector * 1) * CFrame.Angles(-1.8849555921538759, 0, 0)
    local fpor2_result1, _ = fpor2_upvw(HumanoidRootPart_2.Position, Vector3.new(0, -3, 0), HumanoidRootPart_2.Parent)
    if fpor2_result1 and not fpor2_result1:IsDescendantOf(workspace.Vehicles) and 1 < tick() - var24_upvw.Started then
        GliderStop_upvw()
    end
end
local function RawGlider_upvr() -- Line 173, Named "RawGlider"
    if var24_upvw then
        print("Already has glider")
        return false
    end
    local Character = LocalPlayer_upvr.Character
    if not Character then
        return false
    end
    local Humanoid_2 = Character:FindFirstChild("Humanoid")
    if not Humanoid_2 then
        return false
    end
    local PrimaryPart_2 = Character.PrimaryPart
    if not PrimaryPart_2 then
        return false
    end
    if Humanoid_2.PlatformStand then
        return false
    end
    if Humanoid_2.Sit then
        return false
    end
    Humanoid_2.PlatformStand = true
    Humanoid_2:ChangeState(Enum.HumanoidStateType.PlatformStanding)
    var24_upvw = {}
    var24_upvw.Type = "Glider"
    local BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    BodyGyro.CFrame = CurrentCamera_upvr.CFrame * CFrame.Angles((-math.pi/2), 0, 0)
    BodyGyro.Parent = PrimaryPart_2
    local BodyVelocity_2 = Instance.new("BodyVelocity")
    BodyVelocity_2.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    BodyVelocity_2.Velocity = Vector3.new(0, -1, 0)
    BodyVelocity_2.Parent = PrimaryPart_2
    var24_upvw.Gyro = BodyGyro
    var24_upvw.Velocity = BodyVelocity_2
    var24_upvw.HumanoidRootPart = PrimaryPart_2
    var24_upvw.Humanoid = Humanoid_2
    var24_upvw.Started = tick()
    var24_upvw.Loop = RunService_upvr.Heartbeat:Connect(UpdateGlider_upvr)
    return true
end
local function RawGliderStop_upvr() -- Line 223, Named "RawGliderStop"
    if not var24_upvw then
        return false
    end
    if var24_upvw.Type ~= "Glider" then
        return false
    end
    var24_upvw.Gyro:Destroy()
    var24_upvw.Velocity:Destroy()
    var24_upvw.Loop:Disconnect()
    var24_upvw.Humanoid.PlatformStand = false
    var24_upvw.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    var24_upvw = nil
    any_new_result1_upvr_2:Fire()
    return true
end
function GliderStop_upvw() -- Line 247, Named "GliderStop"
    if not RawGliderStop_upvr() then
        return false
    end
    var6_upvw:FireServer('m'..("urpnp1xn"):sub(2, 6):reverse():reverse():reverse()..""..""..("qslgu"):sub(4, 4):reverse():reverse():reverse():reverse():reverse()..""..'l')
end
local var49_upvw = GliderStop_upvw
local var50_upvw
return {
    Init = function(arg1) -- Line 254, Named "Init"
        var6_upvw = arg1.Event
        var50_upvw = arg1.em
        function var50_upvw.sh2xmsg6() -- Line 256
            if not RawParachute_upvr() then
                var6_upvw:FireServer('x'..("c8d"):sub(2, 2):reverse():reverse():reverse():reverse():reverse()..""..""..("pmfhay"):sub(5, 5):reverse():reverse():reverse()..""..""..("fae5c"):sub(2, 2):reverse()..""..""..("aukqeqe"):sub(3, 3):reverse().."".."j83")
            end
        end
        function var50_upvw.x8aakj83() -- Line 262
            if not var24_upvw then
            else
                if var24_upvw.Type ~= "Parachute" then return end
                var24_upvw.Gyro:Destroy()
                var24_upvw.Velocity:Destroy()
                var24_upvw.Loop:Disconnect()
                var24_upvw.Humanoid.PlatformStand = false
                var24_upvw = nil
                any_new_result1_upvr:Fire()
            end
        end
        function var50_upvw.sdrdsjqn() -- Line 265
            if not RawGlider_upvr() then
                var6_upvw:FireServer('m'..("sagrpnp1pwe"):sub(3, 8):reverse()..""..'l')
            end
        end
        function var50_upvw.m1pnprgl() -- Line 271
            RawGliderStop_upvr()
        end
        require(script.Parent.DefaultActions).onJumpPressed:Connect(function() -- Line 276
            if var24_upvw and var24_upvw.Type == "Glider" then
                var49_upvw()
            end
        end)
    end;
    Parachute = new_upvr;
    ParachuteStop = FindPartOnRayWithIgnoreList_upvw;
    Glider = function() -- Line 240, Named "Glider"
        if not RawGlider_upvr() then
            return false
        end
        var6_upvw:FireServer('s'..("tidat6"):sub(3, 3):reverse():reverse():reverse()..""..""..("sscsdrlo"):sub(4, 6):reverse().."".."jqn")
    end;
    GliderStop = var49_upvw;
    IsFlying = function() -- Line 57, Named "IsFlying"
        local var25
        if var24_upvw == nil then
            var25 = false
        else
            var25 = true
        end
        return var25
    end;
    OnParachuteStopped = any_new_result1_upvr;
    OnGliderStopped = any_new_result1_upvr_2;
}
