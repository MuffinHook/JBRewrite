local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var2_upvw
local var3_upvw
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
local function CalculateConstants_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 16, Named "CalculateConstants"
    local var5 = arg4 or 0.25
    local var6 = arg5
    if not var6 then
        var6 = {}
    end
    local var7 = arg1 + arg2 * var5 + Vector3.new(0, -98.10000000000001 * var5 * var5, 0)
    local Unit = (arg3 - var7).Unit
    local _, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(var7, Unit, 999, var6)
    local any_Dot_result1 = arg2:Dot(Unit)
    return var7, var5, ((any_Dot_result1 * any_Dot_result1 + 3000 * (any_RayIgnoreNonCollideWithIgnoreList_result2 - var7).Magnitude) ^ 0.5 - any_Dot_result1) / 1500, any_RayIgnoreNonCollideWithIgnoreList_result2
end
local var12_upvw
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
function tbl_upvr.new(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 32
    local setmetatable_result1 = setmetatable({}, tbl_upvr)
    local var15
    if not var15 then
        var15 = "RocketPart"
    end
    setmetatable_result1.Rotation = CFrame.Angles(0, 0, 0)
    if var15 == "RocketPart" then
        setmetatable_result1.Rotation = CFrame.Angles(0, math.pi, 0)
    end
    local clone = ReplicatedStorage_upvr.Resource[var15]:Clone()
    clone.CanCollide = false
    clone.Anchored = true
    clone.Parent = workspace
    clone.CFrame = arg1 * setmetatable_result1.Rotation
    setmetatable_result1.Part = clone
    setmetatable_result1.Origin = arg1
    setmetatable_result1.OriginVelocity = arg2
    setmetatable_result1.Target = arg3
    setmetatable_result1.DropPeriod = arg5
    setmetatable_result1.IgnoreList = arg6
    return setmetatable_result1
end
local RunService_upvr = game:GetService("RunService")
function tbl_upvr.Animate(arg1, arg2) -- Line 57
    local var18 = arg2
    if not var18 then
        var18 = var3_upvw
        var18 = var18.GetNowSync()
    end
    local var19_upvw = var18
    local OriginVelocity_upvr = arg1.OriginVelocity
    local CalculateConstants_upvr_result1_upvr, CalculateConstants_result2_upvr, CalculateConstants_result3_upvr, CalculateConstants_upvr_result4 = CalculateConstants_upvr(arg1.Origin.p, OriginVelocity_upvr, arg1.Target, arg1.DropPeriod, arg1.IgnoreList)
    local Unit_2_upvr = (arg1.Target - CalculateConstants_upvr_result1_upvr).Unit
    local function Ignite_upvr() -- Line 70, Named "Ignite"
        arg1.Part.Fire.Enabled = true
        var2_upvw.ObjectLocal(arg1.Part, 1386598740, {
            TimePosition = 0.5;
            Volume = 0.5;
        })
        var2_upvw.ObjectLocal(arg1.Part, 9058734199, {
            Volume = 0.6;
            Pitch = 0.6;
            EmitterSize = 25;
        })
    end
    local var28_upvw = var19_upvw - 0.03333333333333333
    local LookVector_upvr = (arg1.Origin * arg1.Rotation).LookVector
    local any_Dot_result1_2_upvr = OriginVelocity_upvr:Dot(Unit_2_upvr)
    arg1.Runtime = RunService_upvr.Heartbeat:Connect(function() -- Line 76, Named "Heartbeat"
        local any_GetNowSync_result1 = var3_upvw.GetNowSync()
        local var32 = any_GetNowSync_result1 - var19_upvw
        local var33 = any_GetNowSync_result1 - var28_upvw
        var28_upvw = any_GetNowSync_result1
        if var32 - var33 < CalculateConstants_result2_upvr and CalculateConstants_result2_upvr <= var32 then
            Ignite_upvr()
        end
        if var32 - var33 < CalculateConstants_result2_upvr + CalculateConstants_result3_upvr and CalculateConstants_result2_upvr + CalculateConstants_result3_upvr <= var32 then
            arg1:Explode()
        end
        if var32 < CalculateConstants_result2_upvr then
            arg1.Part.CFrame = arg1.Origin * arg1.Rotation + OriginVelocity_upvr * var32 + Vector3.new(0, -98.10000000000001 * var32 * var32, 0)
        elseif var32 < CalculateConstants_result2_upvr + CalculateConstants_result3_upvr then
            local var34 = var32 - CalculateConstants_result2_upvr
            arg1.Part.CFrame = CFrame.new(var12_upvw, LookVector_upvr:Lerp(Unit_2_upvr, math.min(var34 * 10, 1))) + CalculateConstants_upvr_result1_upvr + any_Dot_result1_2_upvr * Unit_2_upvr * var34 + (Unit_2_upvr) * (750 * var34 * var34)
        end
    end)
end
function tbl_upvr.Explode(arg1) -- Line 100
    delay(2, function() -- Line 101
        arg1:Destroy()
    end)
    arg1.Part.Transparency = 1
    arg1.Part.CanCollide = false
    arg1.Part.Fire.Enabled = false
    local Explosion = Instance.new("Explosion")
    Explosion.ExplosionType = Enum.ExplosionType.NoCraters
    Explosion.DestroyJointRadiusPercent = 0
    Explosion.Position = arg1.Part.Position
    Explosion.Parent = workspace
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://55224766"
    Sound.Parent = arg1.Part
    Sound.Volume = 0.8
    Sound:Play()
end
function tbl_upvr.Destroy(arg1) -- Line 121
    arg1.Part:Destroy()
    arg1.Part = nil
    arg1.Runtime:Disconnect()
    arg1.Runtime = nil
end
return {
    CalculateConstants = CalculateConstants_upvr;
    LaunchMissile = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 131, Named "LaunchMissile"
        tbl_upvr.new(arg1, arg2, arg3, arg5, arg6, arg7):Animate(arg4)
    end;
    Init = function() -- Line 135, Named "Init"
        var12_upvw = Vector3.new()
        var2_upvw = require(ReplicatedStorage_upvr.Std.Audio)
        var3_upvw = require(ReplicatedStorage_upvr.Module.Time)
    end;
}