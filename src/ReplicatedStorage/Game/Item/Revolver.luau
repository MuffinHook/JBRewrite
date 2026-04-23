local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "Revolver"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3) --[[ Line: 13 | Upvalues: Gun (copy), t (copy) ]]
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	return v1
end
function t.SetupModel(p1) --[[ Line: 20 | Upvalues: Gun (copy), Joint (copy), Spring (copy) ]]
	Gun.SetupModel(p1)
	local Model = p1.Model
	local Cylinder = Model.Motion.Cylinder
	local v1 = Joint.Motor(Cylinder, p1.BoundingBox)
	Cylinder.Anchored = false
	local v2 = Spring.new(Vector3.new(), Vector3.new(), 0.6, 20)
	local v3 = Spring.new(0, 0, 0.6, 10)
	p1.MotorCylinder = v1
	p1.SpringCylinder = v2
	p1.SpringCylinderSpin = v3
	p1.MotorCylinderC0 = v1.C0
	p1.CylinderTotalSpin = 0
	local Ammo = Model.Motion.Ammo
	Joint.Weld(Ammo, Cylinder)
	Ammo.Anchored = false
	p1.PartAmmo = Ammo
end
function t.UpdateItemSprings(p1) --[[ Line: 43 | Upvalues: Gun (copy) ]]
	Gun.UpdateItemSprings(p1)
	p1.CylinderPosition = p1.SpringCylinder:Update()
	p1.CylinderTotalSpin = (p1.CylinderTotalSpin + p1.SpringCylinderSpin:Update()) % 6.283185307179586
end
function t.UpdateItemJoints(p1) --[[ Line: 51 | Upvalues: Gun (copy) ]]
	Gun.UpdateItemJoints(p1)
	p1.MotorCylinder.C1 = CFrame.new(p1.CylinderPosition) * p1.MotorCylinderC0:Inverse() * CFrame.Angles(0, 0, p1.CylinderTotalSpin) * p1.MotorCylinderC0
end
function t.ShootSound(p1, p2) --[[ Line: 58 | Upvalues: Audio (copy) ]]
	if not p2 then
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.shoot, {
			Pitch = 1,
			Volume = 0.6
		})
		delay(0.1, function() --[[ Line: 61 | Upvalues: Audio (ref), p1 (copy) ]]
			Audio.ObjectLocal(p1.Tip, p1.Config.Sound.bullet_case, {
				Volume = 0.4,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
		p1.SpringCylinderSpin:Accelerate(2)
	end
end
function t.ReloadDropAmmoVisual(p1) --[[ Line: 71 ]] end
function t.ReloadRefillAmmoVisual(p1) --[[ Line: 72 ]] end
function t.ReloadDropAmmoSound(p1) --[[ Line: 73 | Upvalues: Audio (copy) ]]
	p1.PartAmmo.Transparency = 1
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.reload_open)
	p1.SpringCylinder:SetTarget(Vector3.new(-0.2, -0.1, 0))
end
function t.ReloadRefillAmmoSound(p1) --[[ Line: 79 | Upvalues: Audio (copy) ]]
	p1.PartAmmo.Transparency = 0
	p1.SpringCylinderSpin:Accelerate(60)
	for i = 1, 4 do
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.bullet_insert)
		wait(0.2)
	end
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.reload_close)
	wait(0.2)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.cylinder_spin)
	p1.SpringCylinder:SetTarget(Vector3.new(0, 0, 0))
end
return t