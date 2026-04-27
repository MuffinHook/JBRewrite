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
function Shotgun.new(gunItem, modelPart, config)
	local gunInstance = Gun.new(gunItem, modelPart, config)
	setmetatable(gunInstance, Shotgun)
	gunInstance:Setup(config)
	gunInstance.LastHitBucketTime = 0
	gunInstance.LastHitBucketCount = 0
	gunInstance.BulletEmitter.BulletWhizEnabled = false
	gunInstance:_updateAmmoVisual()
	gunInstance.Maid:GiveTask(gunInstance.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrentLocal"):Connect(function()
		gunInstance:_updateAmmoVisual()
	end))
	return gunInstance
end
function Shotgun.SetupModel(gunItem)
	Gun.SetupModel(gunItem)
	local Pump = gunItem.Model.Motion.Pump
	local motorPump = Joint.Motor(Pump, gunItem.BoundingBox)
	Pump.Anchored = false
	local springPump = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
	gunItem.MotorPump = motorPump
	gunItem.SpringPump = springPump
end
function Shotgun.SetupArmWelds(gunItem)
	Joint.Weld(gunItem.Model.Skeleton.LeftArm, gunItem.Model.Motion.Pump)
	Joint.Weld(gunItem.Model.Skeleton.RightArm, gunItem.BoundingBox)
	gunItem.Model.Skeleton.LeftArm.Anchored = false
	gunItem.Model.Skeleton.RightArm.Anchored = false
end
function Shotgun.UpdateItemSprings(gunItem)
	Gun.UpdateItemSprings(gunItem)
	gunItem.PumpPosition = gunItem.SpringPump:Update()
end
function Shotgun.UpdateItemJoints(gunItem)
	Gun.UpdateItemJoints(gunItem)
	gunItem.MotorPump.C1 = CFrame.new(gunItem.PumpPosition)
end
function Shotgun.ReloadDropAmmoVisual(gunItem)  end
function Shotgun.ReloadRefillAmmoVisual(gunItem)  end
function Shotgun.BulletEmitterOnLocalHitPlayer(gunItem, ...)
	local currentTime = tick()
	if currentTime - gunItem.LastHitBucketTime > 0.5 then
		gunItem.LastHitBucketTime = currentTime
		gunItem.LastHitBucketCount = 0
	end
	gunItem.LastHitBucketCount = gunItem.LastHitBucketCount + 1
	if gunItem.LastHitBucketCount <= 10 then
		Gun.BulletEmitterOnLocalHitPlayer(gunItem, ...)
	end
end
function Shotgun.BulletEmitterShieldDamage(gunItem, ...)
	local currentTime = tick()
	if currentTime - gunItem.LastHitBucketTime > 0.5 then
		gunItem.LastHitBucketTime = currentTime
		gunItem.LastHitBucketCount = 0
	end
	gunItem.LastHitBucketCount = gunItem.LastHitBucketCount + 1
	if gunItem.LastHitBucketCount <= 10 then
		Gun.BulletEmitterShieldDamage(gunItem, ...)
	end
end
function Shotgun.ShootSound(gunItem, isLocalPlayer)
	if not isLocalPlayer then
		Audio.ObjectLocal(gunItem.Tip, gunItem.Config.Sound.gun_shotgun_shot_01, {
			Pitch = 1 + math.random() * 0.1 - 0.05,
			Volume = 0.4
		})
		task.delay(0.3, function()
			Audio.ObjectLocal(gunItem.Tip, gunItem.Config.Sound.gun_shotgun_cock_01, {
				Pitch = 1 + math.random() * 0.1 - 0.05
			})
			gunItem.SpringPump:Accelerate(Vector3.new(0, 0, 35))
		end)
	end
end
function Shotgun._updateAmmoVisual(gunItem, ammoCount)
	if gunItem.Local then
		local Ammo = gunItem.Model:FindFirstChild("Model"):FindFirstChild("Ammo")
		if not ammoCount then
			ammoCount = InventoryItemUtils.getAttr(gunItem.inventoryItemValue, "AmmoCurrentLocal") - 1
		end
		local totalAmmo = #Ammo:GetChildren()
		for i = 1, totalAmmo do
			local ammoPart = Ammo:FindFirstChild((tostring(totalAmmo - i + 1)))
			if i <= ammoCount then
				ammoPart.Transparency = 0
			else
				ammoPart.Transparency = 1
			end
		end
	end
end
function Shotgun.ReloadDropAmmoSound(gunItem)
	Audio.ObjectLocal(gunItem.Tip, gunItem.Config.Sound.gun_shotgun_dry_fire_01, {
		Pitch = 0.5,
		RollOffMaxDistance = 64
	})
end
function Shotgun.ReloadRefillAmmoSound(gunItem)
	for i = 1, 4 do
		Audio.ObjectLocal(gunItem.Tip, gunItem.Config.Sound.gun_shotgun_cock_01, {
			Pitch = 0.9,
			RollOffMaxDistance = 64
		})
		if not gunItem._updateAmmoVisual then
			return
		end
		gunItem:_updateAmmoVisual(i)
		task.wait(0.375)
	end
	task.wait(0.1)
	Audio.ObjectLocal(gunItem.Tip, gunItem.Config.Sound.gun_shotgun_dry_fire_01, {
		Pitch = 0.5,
		RollOffMaxDistance = 64
	})
	gunItem.SpringPump:Accelerate(Vector3.new(0, 0, 35))
end
return Shotgun
