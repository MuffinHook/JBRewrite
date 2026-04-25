-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local Gun = require(script.Parent.Gun)
local Shotgun = {
	__ClassName = "Shotgun"
}
Shotgun.__index = Shotgun
setmetatable(Shotgun, Gun)
function Shotgun.new(p1, p2, p3)
	local gunInstance = Gun.new(p1, p2, p3)
	setmetatable(gunInstance, Shotgun)
	gunInstance:Setup(p3)
	gunInstance.LastHitBucketTime = 0
	gunInstance.LastHitBucketCount = 0
	gunInstance.BulletEmitter.BulletWhizEnabled = false
	gunInstance:_updateAmmoVisual()
	gunInstance.Maid:GiveTask(gunInstance.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrentLocal"):Connect(function()
		gunInstance:_updateAmmoVisual()
	end))
	return gunInstance
end
function Shotgun.SetupModel(p1)
	Gun.SetupModel(p1)
	local Pump = p1.Model.Motion.Pump
	local motorPump = Joint.Motor(Pump, p1.BoundingBox)
	Pump.Anchored = false
	local springPump = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
	p1.MotorPump = motorPump
	p1.SpringPump = springPump
end
function Shotgun.SetupArmWelds(p1)
	Joint.Weld(p1.Model.Skeleton.LeftArm, p1.Model.Motion.Pump)
	Joint.Weld(p1.Model.Skeleton.RightArm, p1.BoundingBox)
	p1.Model.Skeleton.LeftArm.Anchored = false
	p1.Model.Skeleton.RightArm.Anchored = false
end
function Shotgun.UpdateItemSprings(p1)
	Gun.UpdateItemSprings(p1)
	p1.PumpPosition = p1.SpringPump:Update()
end
function Shotgun.UpdateItemJoints(p1)
	Gun.UpdateItemJoints(p1)
	p1.MotorPump.C1 = CFrame.new(p1.PumpPosition)
end
function Shotgun.ReloadDropAmmoVisual(p1)  end
function Shotgun.ReloadRefillAmmoVisual(p1)  end
function Shotgun.BulletEmitterOnLocalHitPlayer(p1, ...)
	local currentTime = tick()
	if currentTime - p1.LastHitBucketTime > 0.5 then
		p1.LastHitBucketTime = currentTime
		p1.LastHitBucketCount = 0
	end
	p1.LastHitBucketCount = p1.LastHitBucketCount + 1
	if p1.LastHitBucketCount <= 10 then
		Gun.BulletEmitterOnLocalHitPlayer(p1, ...)
	end
end
function Shotgun.BulletEmitterShieldDamage(p1, ...)
	local currentTime = tick()
	if currentTime - p1.LastHitBucketTime > 0.5 then
		p1.LastHitBucketTime = currentTime
		p1.LastHitBucketCount = 0
	end
	p1.LastHitBucketCount = p1.LastHitBucketCount + 1
	if p1.LastHitBucketCount <= 10 then
		Gun.BulletEmitterShieldDamage(p1, ...)
	end
end
function Shotgun.ShootSound(p1, p2)
	if not p2 then
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_shotgun_shot_01, {
			Pitch = 1 + math.random() * 0.1 - 0.05,
			Volume = 0.4
		})
		task.delay(0.3, function()
			Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_shotgun_cock_01, {
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
			p1.SpringPump:Accelerate(Vector3.new(0, 0, 35))
		end)
	end
end
function Shotgun._updateAmmoVisual(p1, p2)
	if p1.Local then
		local Ammo = p1.Model:FindFirstChild("Model"):FindFirstChild("Ammo")
		if not p2 then
			p2 = InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrentLocal") - 1
		end
		local ammoCount = #Ammo:GetChildren()
		for i = 1, ammoCount do
			local ammoPart = Ammo:FindFirstChild((tostring(ammoCount - i + 1)))
			if i <= p2 then
				ammoPart.Transparency = 0
			else
				ammoPart.Transparency = 1
			end
		end
	end
end
function Shotgun.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_shotgun_dry_fire_01, {
		Pitch = 0.5,
		RollOffMaxDistance = 64
	})
end
function Shotgun.ReloadRefillAmmoSound(p1)
	for i = 1, 4 do
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_shotgun_cock_01, {
			Pitch = 0.9,
			RollOffMaxDistance = 64
		})
		if not p1._updateAmmoVisual then
			return
		end
		p1:_updateAmmoVisual(i)
		task.wait(0.375)
	end
	task.wait(0.1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_shotgun_dry_fire_01, {
		Pitch = 0.5,
		RollOffMaxDistance = 64
	})
	p1.SpringPump:Accelerate(Vector3.new(0, 0, 35))
end
return Shotgun
