-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local Gun = require(script.Parent.Gun)
local t = {
	__ClassName = "Shotgun"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	v1.LastHitBucketTime = 0
	v1.LastHitBucketCount = 0
	v1.BulletEmitter.BulletWhizEnabled = false
	v1:_updateAmmoVisual()
	v1.Maid:GiveTask(v1.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrentLocal"):Connect(function()
		v1:_updateAmmoVisual()
	end))
	return v1
end
function t.SetupModel(p1)
	Gun.SetupModel(p1)
	local Pump = p1.Model.Motion.Pump
	local v1 = Joint.Motor(Pump, p1.BoundingBox)
	Pump.Anchored = false
	local v2 = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
	p1.MotorPump = v1
	p1.SpringPump = v2
end
function t.SetupArmWelds(p1)
	Joint.Weld(p1.Model.Skeleton.LeftArm, p1.Model.Motion.Pump)
	Joint.Weld(p1.Model.Skeleton.RightArm, p1.BoundingBox)
	p1.Model.Skeleton.LeftArm.Anchored = false
	p1.Model.Skeleton.RightArm.Anchored = false
end
function t.UpdateItemSprings(p1)
	Gun.UpdateItemSprings(p1)
	p1.PumpPosition = p1.SpringPump:Update()
end
function t.UpdateItemJoints(p1)
	Gun.UpdateItemJoints(p1)
	p1.MotorPump.C1 = CFrame.new(p1.PumpPosition)
end
function t.ReloadDropAmmoVisual(p1)  end
function t.ReloadRefillAmmoVisual(p1)  end
function t.BulletEmitterOnLocalHitPlayer(p1, ...)
	local v1 = tick()
	if v1 - p1.LastHitBucketTime > 0.5 then
		p1.LastHitBucketTime = v1
		p1.LastHitBucketCount = 0
	end
	p1.LastHitBucketCount = p1.LastHitBucketCount + 1
	if p1.LastHitBucketCount <= 10 then
		Gun.BulletEmitterOnLocalHitPlayer(p1, ...)
	end
end
function t.BulletEmitterShieldDamage(p1, ...)
	local v1 = tick()
	if v1 - p1.LastHitBucketTime > 0.5 then
		p1.LastHitBucketTime = v1
		p1.LastHitBucketCount = 0
	end
	p1.LastHitBucketCount = p1.LastHitBucketCount + 1
	if p1.LastHitBucketCount <= 10 then
		Gun.BulletEmitterShieldDamage(p1, ...)
	end
end
function t.ShootSound(p1, p2)
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
function t._updateAmmoVisual(p1, p2)
	if p1.Local then
		local Ammo = p1.Model:FindFirstChild("Model"):FindFirstChild("Ammo")
		if not p2 then
			p2 = InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrentLocal") - 1
		end
		local v1 = #Ammo:GetChildren()
		for i = 1, v1 do
			local v2 = Ammo:FindFirstChild((tostring(v1 - i + 1)))
			if i <= p2 then
				v2.Transparency = 0
			else
				v2.Transparency = 1
			end
		end
	end
end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.gun_shotgun_dry_fire_01, {
		Pitch = 0.5,
		RollOffMaxDistance = 64
	})
end
function t.ReloadRefillAmmoSound(p1)
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
return t
