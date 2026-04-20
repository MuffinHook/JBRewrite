local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
local Gun_upvr = require(script.Parent.Gun)
local zero_cframe_upvr = CFrame.new()
local function FromAxisAngle_upvr(arg1) -- Line 12, Named "FromAxisAngle"
    local X = arg1.X
    local Y = arg1.Y
    local Z = arg1.Z
    local var9 = (X * X + Y * Y + Z * Z) ^ 0.5
    if 0.00001 < var9 then
        local var10 = math.sin(var9 * 0.5) / var9
        return CFrame.new(0, 0, 0, var10 * X, var10 * Y, var10 * Z, math.cos(var9 * 0.5))
    end
    return zero_cframe_upvr
end
local module_upvr = {
    __ClassName = "Flintlock";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 27
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr.SetupModel(arg1) -- Line 34
    Gun_upvr.SetupModel(arg1)
    local Lever = arg1.Model.Motion.Lever
    Lever.Anchored = false
    arg1.MotorLever = Joint_upvr.Motor(Lever, arg1.BoundingBox)
    arg1.SpringLever = Spring_upvr.new(Vector3.new(0, 0, 0), Vector3.new(), 0.8, 20)
    arg1.SpringKnockback = Spring_upvr.new(0, 0, 0.9, 20)
end
function module_upvr.UpdateItemSprings(arg1) -- Line 49
    Gun_upvr.UpdateItemSprings(arg1)
    arg1.LeverPosition = arg1.SpringLever:Update()
    arg1.KnockbackPosition = arg1.SpringKnockback:Update()
end
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local os_clock_result1_upvw = os.clock()
function module_upvr.UpdateItemJoints(arg1) -- Line 59
    Gun_upvr.UpdateItemJoints(arg1)
    arg1.MotorLever.C1 = FromAxisAngle_upvr(arg1.LeverPosition)
    if 0.1 < arg1.KnockbackPosition and not VehicleUtils_upvr.GetLocalVehiclePacket() and not arg1.Humanoid.Sit then
        arg1.RootPart.CFrame = arg1.RootPart.CFrame * CFrame.new(0, 0, arg1.KnockbackPosition * 60 * (os.clock() - os_clock_result1_upvw))
    end
    os_clock_result1_upvw = os.clock()
end
function module_upvr.SetupArmWelds(arg1) -- Line 69
    Joint_upvr.Weld(arg1.Model.Skeleton.RightArm, arg1.BoundingBox)
    arg1.Model.Skeleton.RightArm.Anchored = false
end
function module_upvr.UpdateArmIK(arg1) -- Line 73
    local IK = arg1.IK
    IK.RightArm = arg1.Model.Skeleton.RightArm.Position
    IK.RightAngle = arg1.Config.Motion.RightElbowAngle
end
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
function module_upvr.ShootSound(arg1, arg2) -- Line 79
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.flintlock_shoot, {
            Pitch = 0.7;
            Volume = 0.7;
        })
        arg1.SpringLever:Accelerate(Vector3.new(30, 0, 0))
        if RayCast_upvr.RayIgnoreNonCollide(arg1.RootPart.Position, -arg1.RootPart.CFrame.LookVector, 5, arg1.Character) == nil then
            arg1.SpringKnockback:Accelerate(50)
        end
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 91
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.flintlock_reload_open, {
        RollOffMaxDistance = 129;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 96
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.flintlock_reload_close, {
        RollOffMaxDistance = 129;
    })
end
return module_upvr