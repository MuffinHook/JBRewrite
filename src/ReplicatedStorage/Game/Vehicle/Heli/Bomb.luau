local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var2_upvw
local var3_upvw
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
function tbl_upvr.new(arg1, arg2) -- Line 10
    local setmetatable_result1 = setmetatable({}, tbl_upvr)
    setmetatable_result1.p0 = arg1
    setmetatable_result1.v0 = arg2
    local clone = ReplicatedStorage_upvr.Resource.HeliBomb:Clone()
    var2_upvw.WeldAllTo(clone, clone.Rocket)
    clone.Rocket.Anchored = true
    clone.Rocket.CFrame = arg1
    clone.Parent = workspace
    setmetatable_result1.Model = clone
    return setmetatable_result1
end
local zero_vector3_upvr = Vector3.new()
local cframe_upvr = CFrame.Angles(0, math.pi, 0)
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
local RunService_upvr = game:GetService("RunService")
function tbl_upvr.Animate(arg1, arg2) -- Line 29
    local var11 = arg2
    if not var11 then
        var11 = var3_upvw
        var11 = var11.GetNowSync()
    end
    local var12_upvw = var11
    arg1.Runtime = RunService_upvr.Heartbeat:Connect(function() -- Line 37, Named "Heartbeat"
        local any_GetNowSync_result1_2 = var3_upvw.GetNowSync()
        local var20 = any_GetNowSync_result1_2 - var12_upvw
        local var21 = any_GetNowSync_result1_2 - var12_upvw
        var12_upvw = any_GetNowSync_result1_2
        local var22 = arg1.v0 * var20 + Vector3.new(0, -98.10000000000001 * var20 * var20, 0)
        arg1.Model.Rocket.CFrame = CFrame.new(zero_vector3_upvr, arg1.p0.LookVector:Lerp(Vector3.new(0, -1, 0), math.min(1, var20 * 1.3333333333333333))) * cframe_upvr + arg1.p0.p + var22
        if var20 - var21 < 0.3 and 0.3 < var20 then
            arg1.Model.Fire.Particle.Enabled = true
        end
        if 0.3 < var20 then
            local any_RayIgnoreNonCollide_result1_2, any_RayIgnoreNonCollide_result2 = RayCast_upvr.RayIgnoreNonCollide(arg1.p0.p + var22, Vector3.new(0, -1, 0), math.abs(arg1.v0.Y + -196.20000000000002 * var20) * var21, arg1.Model)
            if any_RayIgnoreNonCollide_result1_2 then
                arg1:Explode(any_RayIgnoreNonCollide_result2)
            end
        end
        if 5 < var20 and not arg1.Exploded then
            arg1:Destroy()
        end
    end)
end
local var25_upvw
local Players_upvr = game:GetService("Players")
function tbl_upvr.Explode(arg1, arg2) -- Line 68
    arg1.Exploded = true
    delay(2, function() -- Line 70
        arg1:Destroy()
    end)
    if arg1.Runtime then
        arg1.Runtime:Disconnect()
        arg1.Runtime = nil
    end
    arg1.Model.Fire.Particle.Enabled = false
    arg1.Model.Rocket.Transparency = 1
    local Explosion = Instance.new("Explosion")
    Explosion.ExplosionType = Enum.ExplosionType.NoCraters
    Explosion.DestroyJointRadiusPercent = 0
    Explosion.Position = arg2
    Explosion.Parent = workspace
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://55224766"
    Sound.Parent = arg1.Model.Rocket
    Sound.Volume = 0.8
    Sound:Play()
    local Character = Players_upvr.LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then
            local RootPart = Humanoid.RootPart
            if RootPart then
                local var40 = RootPart.Position - arg2
                local var41 = math.max(24 - var40.Magnitude, 0) / 24
                if 0.001 < var41 then
                    RootPart.Velocity += var40.Unit * var41 * 30
                    if arg1._owner then
                        print(arg1._owner)
                        var25_upvw:FireServer('x'.."hwcrukiommt1m":sub(4, 9):reverse():reverse():reverse():reverse():reverse()..""..'h', var41 * 50, arg1._owner, "Bomb")
                        return
                    end
                    var25_upvw:FireServer('y'.."ewqhzffpk":sub(5, 5):reverse():reverse():reverse():reverse():reverse().."".."".."slpka52":sub(2, 3):reverse():reverse():reverse():reverse():reverse().."".."kho3", var41 * 50, "Explode")
                end
            end
        end
    end
end
function tbl_upvr.SetOwner(arg1, arg2) -- Line 115
    arg1._owner = arg2
end
function tbl_upvr.Destroy(arg1) -- Line 118
    if arg1.Runtime then
        arg1.Runtime:Disconnect()
        arg1.Runtime = nil
    end
    arg1.Model:Destroy()
end
return {
    Init = function(arg1) -- Line 131, Named "Init"
        var25_upvw = arg1.Event
        var3_upvw = require(ReplicatedStorage_upvr.Module.Time)
        var2_upvw = require(ReplicatedStorage_upvr.Std.Joint)
    end;
    DropBomb = function(arg1, arg2, arg3, arg4) -- Line 126, Named "DropBomb"
        local any_new_result1 = tbl_upvr.new(arg1, arg2)
        any_new_result1:SetOwner(arg4)
        any_new_result1:Animate(arg3)
    end;
}