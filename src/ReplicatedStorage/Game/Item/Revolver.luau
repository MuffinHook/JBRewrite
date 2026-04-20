local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "Revolver";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 13
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr.SetupModel(arg1) -- Line 20
    Gun_upvr.SetupModel(arg1)
    local Model = arg1.Model
    local Cylinder = Model.Motion.Cylinder
    local any_Motor_result1 = Joint_upvr.Motor(Cylinder, arg1.BoundingBox)
    Cylinder.Anchored = false
    arg1.MotorCylinder = any_Motor_result1
    arg1.SpringCylinder = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.6, 20)
    arg1.SpringCylinderSpin = Spring_upvr.new(0, 0, 0.6, 10)
    arg1.MotorCylinderC0 = any_Motor_result1.C0
    arg1.CylinderTotalSpin = 0
    local Ammo = Model.Motion.Ammo
    Joint_upvr.Weld(Ammo, Cylinder)
    Ammo.Anchored = false
    arg1.PartAmmo = Ammo
end
function module_upvr.UpdateItemSprings(arg1) -- Line 43
    Gun_upvr.UpdateItemSprings(arg1)
    arg1.CylinderPosition = arg1.SpringCylinder:Update()
    arg1.CylinderTotalSpin = (arg1.CylinderTotalSpin + arg1.SpringCylinderSpin:Update()) % (-math.pi*2)
end
function module_upvr.UpdateItemJoints(arg1) -- Line 51
    Gun_upvr.UpdateItemJoints(arg1)
    arg1.MotorCylinder.C1 = CFrame.new(arg1.CylinderPosition) * arg1.MotorCylinderC0:Inverse() * CFrame.Angles(0, 0, arg1.CylinderTotalSpin) * arg1.MotorCylinderC0
end
function module_upvr.ShootSound(arg1, arg2) -- Line 58
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.shoot, {
            Pitch = 1;
            Volume = 0.6;
        })
        delay(0.1, function() -- Line 61
            Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.bullet_case, {
                Volume = 0.4;
                Pitch = 1 + math.random() * 0.1 - 0.05;
            })
        end)
        arg1.SpringCylinderSpin:Accelerate(2)
    end
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 71
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 72
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 73
    arg1.PartAmmo.Transparency = 1
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.reload_open)
    arg1.SpringCylinder:SetTarget(Vector3.new(-0.2000, -0.1000, 0))
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 79
    arg1.PartAmmo.Transparency = 0
    arg1.SpringCylinderSpin:Accelerate(60)
    for _ = 1, 4 do
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.bullet_insert)
        wait(0.2)
    end
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.reload_close)
    wait(0.2)
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.cylinder_spin)
    arg1.SpringCylinder:SetTarget(Vector3.new(0, 0, 0))
end
return module_upvr