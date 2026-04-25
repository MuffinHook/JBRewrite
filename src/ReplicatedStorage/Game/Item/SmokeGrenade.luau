-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local SmokeGrenadeBinder = require(ReplicatedStorage.Game.SmokeGrenade.SmokeGrenadeBinder)
local Notification = require(ReplicatedStorage.Game.Notification)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Gun = require(script.Parent.Gun)
local function getThrowableSmokeGrenade(p1)
	for i, v in ipairs((SmokeGrenadeBinder:GetAll())) do
		if v:GetCreator() == p1 and not v:GetThrown() then
			return v
		end
	end
end
local function getNumActiveSmokeGrenade(p1)
	local count = 0
	for i, v in ipairs((SmokeGrenadeBinder:GetAll())) do
		if v:GetCreator() == p1 and v:GetThrown() then
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
local t = {
	__ClassName = "SmokeGrenade"
}
t.__index = t
setmetatable(t, Gun)
function t.Init(p1)
	eventSignal = p1.Event
end
function t.new(p1, p2, p3)
	local gun = Gun.new(p1, p2, p3)
	setmetatable(gun, t)
	gun:Setup(p3)
	return gun
end
t.ApplySkin = false
function t.SetupArmWelds(p1)  end
function t.UpdateArmIK(p1)
	local IK = p1.IK
	IK.RightArm = p1.Model.Model.Hold.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
end
function t.SetupTip(p1)
	p1.TipOffset = Vector3.new()
end
function t.BulletEmitterOnLocalHitPlayer(p1)  end
function t.ShootBegin(p1, p2)
	tick()
	local grenadeInstance
	if p1.Local then
		if getNumActiveSmokeGrenade(p1.Player) >= 1 then
			Notification.new({
				Text = "Only one active smoke grenade allowed at a time."
			})
			error("Too many SmokeGrenade, detonate before launching more.")
		end
		local throwableGrenade = getThrowableSmokeGrenade(p1.Player)
		if not throwableGrenade then
			error("No throwable SmokeGrenade left in pool")
		end
		grenadeInstance = throwableGrenade
	else
		grenadeInstance = nil
	end
	if not p1:ShootCheckConditions() then
		return false
	end
	if p1.Local then
		local launchOrigin = p1.UpperTorso.CFrame * Vector3.new(0, 0, -2)
		local launchVelocity, _ = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(launchOrigin, p1.MousePosition, 100, workspace.Gravity, false)
		grenadeInstance._obj.PrimaryPart.Anchored = false
		grenadeInstance._obj:SetPrimaryPartCFrame(CFrame.new(launchOrigin, launchOrigin + launchVelocity))
		grenadeInstance:SetVelocity(launchVelocity)
		local rotationAxis = -0.25 * launchVelocity:Cross(Vector3.new(0, 1, 0))
		grenadeInstance:SetRotVelocity(rotationAxis + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 5)
		grenadeInstance:SetThrown(true)
		grenadeInstance._maid:GiveTask(function()  end)
		p1:SetNextShotPossible()
		p1:DecrementAmmo()
		eventSignal:FireServer("i" .. ("v3p4ig"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("tpzkady"):sub(2, 3):reverse():reverse():reverse() .. "6p5r")
		p1:ReloadDropAmmoVisual()
		delay(0.1, function()
			if p1.Destroyed then
				return false
			end
			p1:ReloadRefillAmmoVisual()
		end)
	end
	if p1.Local then
		p1:BroadcastInputBegan(p2)
	end
end
function t.ShootEnd(p1, p2)
	if p1.Local then
		p1:BroadcastInputEnded(p2)
	end
end
function t.ShootSound(p1, p2)
	if p2 then
		Audio.ObjectLocal(p1.Model.Skeleton.BoundingBox, 2121005402)
	end
end
t.ScopeBegin = false
t.ScopeEnd = false
t.Reload = false
return t
