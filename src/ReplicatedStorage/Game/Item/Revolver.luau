local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local Gun = require(script.Parent.Gun)
local Revolver = {
	__ClassName = "Revolver"
}
Revolver.__index = Revolver
setmetatable(Revolver, Gun)
function Revolver.new(itemProperties, viewModel, config)
	local gunInstance = Gun.new(itemProperties, viewModel, config)
	setmetatable(gunInstance, Revolver)
	gunInstance:Setup(config)
	return gunInstance
end
function Revolver.SetupModel(itemProperties)
	Gun.SetupModel(itemProperties)
	local Model = itemProperties.Model
	local Cylinder = Model.Motion.Cylinder
	local motorCylinder = Joint.Motor(Cylinder, itemProperties.BoundingBox)
	Cylinder.Anchored = false
	local springCylinderPosition = Spring.new(Vector3.new(), Vector3.new(), 0.6, 20)
	local springCylinderRotation = Spring.new(0, 0, 0.6, 10)
	itemProperties.MotorCylinder = motorCylinder
	itemProperties.SpringCylinder = springCylinderPosition
	itemProperties.SpringCylinderSpin = springCylinderRotation
	itemProperties.MotorCylinderC0 = motorCylinder.C0
	itemProperties.CylinderTotalSpin = 0
	local Ammo = Model.Motion.Ammo
	Joint.Weld(Ammo, Cylinder)
	Ammo.Anchored = false
	itemProperties.PartAmmo = Ammo
end
function Revolver.UpdateItemSprings(itemProperties)
	Gun.UpdateItemSprings(itemProperties)
	itemProperties.CylinderPosition = itemProperties.SpringCylinder:Update()
	itemProperties.CylinderTotalSpin = (itemProperties.CylinderTotalSpin + itemProperties.SpringCylinderSpin:Update()) % math.tau
end
function Revolver.UpdateItemJoints(itemProperties)
	Gun.UpdateItemJoints(itemProperties)
	itemProperties.MotorCylinder.C1 = CFrame.new(itemProperties.CylinderPosition) * itemProperties.MotorCylinderC0:Inverse() * CFrame.Angles(0, 0, itemProperties.CylinderTotalSpin) * itemProperties.MotorCylinderC0
end
function Revolver.ShootSound(itemProperties, isRemote)
	if not isRemote then
		Audio.ObjectLocal(itemProperties.Tip, itemProperties.Config.Sound.shoot, {
			Pitch = 1,
			Volume = 0.6
		})
		delay(0.1, function()
			Audio.ObjectLocal(itemProperties.Tip, itemProperties.Config.Sound.bullet_case, {
				Volume = 0.4,
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
		end)
		itemProperties.SpringCylinderSpin:Accelerate(2)
	end
end
function Revolver.ReloadDropAmmoVisual(itemProperties)  end
function Revolver.ReloadRefillAmmoVisual(itemProperties)  end
function Revolver.ReloadDropAmmoSound(itemProperties)
	itemProperties.PartAmmo.Transparency = 1
	Audio.ObjectLocal(itemProperties.Tip, itemProperties.Config.Sound.reload_open)
	itemProperties.SpringCylinder:SetTarget(Vector3.new(-0.2, -0.1, 0))
end
function Revolver.ReloadRefillAmmoSound(itemProperties)
	itemProperties.PartAmmo.Transparency = 0
	itemProperties.SpringCylinderSpin:Accelerate(60)
	for i = 1, 4 do
		Audio.ObjectLocal(itemProperties.Tip, itemProperties.Config.Sound.bullet_insert)
		wait(0.2)
	end
	Audio.ObjectLocal(itemProperties.Tip, itemProperties.Config.Sound.reload_close)
	wait(0.2)
	Audio.ObjectLocal(itemProperties.Tip, itemProperties.Config.Sound.cylinder_spin)
	itemProperties.SpringCylinder:SetTarget(Vector3.new(0, 0, 0))
end
return Revolver
