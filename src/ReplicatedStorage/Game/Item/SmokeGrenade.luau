local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local SmokeGrenadeBinder = require(ReplicatedStorage.Game.SmokeGrenade.SmokeGrenadeBinder)
local Notification = require(ReplicatedStorage.Game.Notification)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Gun = require(script.Parent.Gun)
local function getThrowableSmokeGrenade(player)
	for i, grenade in ipairs((SmokeGrenadeBinder:GetAll())) do
		if grenade:GetCreator() == player and not grenade:GetThrown() then
			return grenade
		end
	end
end
local function getNumActiveSmokeGrenade(player)
	local count = 0
	for i, grenade in ipairs((SmokeGrenadeBinder:GetAll())) do
		if grenade:GetCreator() == player and grenade:GetThrown() then
			count = count + 1
		end
	end
	return count
end
local function randomVector()
	local randomX = math.random() * 2 - 1
	local randomY = math.random() * 2 - 1
	return Vector3.new(randomX, randomY, math.random() * 2 - 1).Unit
end
local eventSignal = nil
local SmokeGrenade = {
	__ClassName = "SmokeGrenade"
}
SmokeGrenade.__index = SmokeGrenade
setmetatable(SmokeGrenade, Gun)
function SmokeGrenade.Init(eventProvider)
	eventSignal = eventProvider.Event
end
function SmokeGrenade.new(self, config, setupConfig)
	local gun = Gun.new(self, config, setupConfig)
	setmetatable(gun, SmokeGrenade)
	gun:Setup(setupConfig)
	return gun
end
SmokeGrenade.ApplySkin = false
function SmokeGrenade.SetupArmWelds(self)  end
function SmokeGrenade.UpdateArmIK(self)
	local IK = self.IK
	IK.RightArm = self.Model.Model.Hold.Position
	IK.RightAngle = self.Config.Motion.RightElbowAngle
end
function SmokeGrenade.SetupTip(self)
	self.TipOffset = Vector3.new()
end
function SmokeGrenade.BulletEmitterOnLocalHitPlayer(self)  end
function SmokeGrenade.ShootBegin(self, input)
	tick()
	local grenadeInstance
	if self.Local then
		if getNumActiveSmokeGrenade(self.Player) >= 1 then
			Notification.new({
				Text = "Only one active smoke grenade allowed at a time."
			})
			error("Too many SmokeGrenade, detonate before launching more.")
		end
		local throwableGrenade = getThrowableSmokeGrenade(self.Player)
		if not throwableGrenade then
			error("No throwable SmokeGrenade left in pool")
		end
		grenadeInstance = throwableGrenade
	else
		grenadeInstance = nil
	end
	if not self:ShootCheckConditions() then
		return false
	end
	if self.Local then
		local launchOrigin = self.UpperTorso.CFrame * Vector3.new(0, 0, -2)
		local launchVelocity, _ = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(launchOrigin, self.MousePosition, 100, workspace.Gravity, false)
		grenadeInstance._obj.PrimaryPart.Anchored = false
		grenadeInstance._obj:SetPrimaryPartCFrame(CFrame.new(launchOrigin, launchOrigin + launchVelocity))
		grenadeInstance:SetVelocity(launchVelocity)
		local rotationAxis = -0.25 * launchVelocity:Cross(Vector3.new(0, 1, 0))
		grenadeInstance:SetRotVelocity(rotationAxis + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 5)
		grenadeInstance:SetThrown(true)
		grenadeInstance._maid:GiveTask(function()  end)
		self:SetNextShotPossible()
		self:DecrementAmmo()
		eventSignal:FireServer("i4zp6p5r")
		self:ReloadDropAmmoVisual()
		task.delay(0.1, function()
			if self.Destroyed then
				return false
			end
			self:ReloadRefillAmmoVisual()
		end)
	end
	if self.Local then
		self:BroadcastInputBegan(input)
	end
end
function SmokeGrenade.ShootEnd(self, input)
	if self.Local then
		self:BroadcastInputEnded(input)
	end
end
function SmokeGrenade.ShootSound(self, shouldPlay)
	if shouldPlay then
		Audio.ObjectLocal(self.Model.Skeleton.BoundingBox, 2121005402)
	end
end
SmokeGrenade.ScopeBegin = false
SmokeGrenade.ScopeEnd = false
SmokeGrenade.Reload = false
return SmokeGrenade
