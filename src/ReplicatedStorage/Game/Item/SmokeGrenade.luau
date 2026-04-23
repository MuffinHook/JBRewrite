local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local SmokeGrenadeBinder = require(ReplicatedStorage.Game.SmokeGrenade.SmokeGrenadeBinder)
local Notification = require(ReplicatedStorage.Game.Notification)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Gun = require(script.Parent.Gun)
local function getThrowableSmokeGrenade(p1) --[[ Line: 12 | Upvalues: SmokeGrenadeBinder (copy) ]]
	for i, v in ipairs((SmokeGrenadeBinder:GetAll())) do
		if v:GetCreator() == p1 and not v:GetThrown() then
			return v
		end
	end
end
local function getNumActiveSmokeGrenade(p1) --[[ Line: 22 | Upvalues: SmokeGrenadeBinder (copy) ]]
	local count = 0
	for i, v in ipairs((SmokeGrenadeBinder:GetAll())) do
		if v:GetCreator() == p1 and v:GetThrown() then
			count = count + 1
		end
	end
	return count
end
local function randomVector() --[[ Line: 34 ]]
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local v2 = nil
local t = {
	__ClassName = "SmokeGrenade"
}
t.__index = t
setmetatable(t, Gun)
function t.Init(p1) --[[ Line: 44 | Upvalues: v2 (ref) ]]
	v2 = p1.Event
end
function t.new(p1, p2, p3) --[[ Line: 47 | Upvalues: Gun (copy), t (copy) ]]
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	return v1
end
t.ApplySkin = false
function t.SetupArmWelds(p1) --[[ Line: 55 ]] end
function t.UpdateArmIK(p1) --[[ Line: 56 ]]
	local IK = p1.IK
	IK.RightArm = p1.Model.Model.Hold.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
end
function t.SetupTip(p1) --[[ Line: 62 ]]
	p1.TipOffset = Vector3.new()
end
function t.BulletEmitterOnLocalHitPlayer(p1) --[[ Line: 65 ]] end
function t.ShootBegin(p1, p2) --[[ Line: 66 | Upvalues: getNumActiveSmokeGrenade (copy), Notification (copy), getThrowableSmokeGrenade (copy), SimulatedPhysicsProjectile (copy), v2 (ref) ]]
	tick()
	local v1
	if p1.Local then
		if getNumActiveSmokeGrenade(p1.Player) >= 1 then
			Notification.new({
				Text = "Only one active smoke grenade allowed at a time."
			})
			error("Too many SmokeGrenade, detonate before launching more.")
		end
		local v22 = getThrowableSmokeGrenade(p1.Player)
		if not v22 then
			error("No throwable SmokeGrenade left in pool")
		end
		v1 = v22
	else
		v1 = nil
	end
	if not p1:ShootCheckConditions() then
		return false
	end
	if p1.Local then
		local v3 = p1.UpperTorso.CFrame * Vector3.new(0, 0, -2)
		local v4, _ = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(v3, p1.MousePosition, 100, workspace.Gravity, false)
		v1._obj.PrimaryPart.Anchored = false
		v1._obj:SetPrimaryPartCFrame(CFrame.new(v3, v3 + v4))
		v1:SetVelocity(v4)
		local v5 = -0.25 * v4:Cross(Vector3.new(0, 1, 0))
		v1:SetRotVelocity(v5 + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 5)
		v1:SetThrown(true)
		v1._maid:GiveTask(function() --[[ Line: 99 ]] end)
		p1:SetNextShotPossible()
		p1:DecrementAmmo()
		v2:FireServer("i" .. ("v3p4ig"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("tpzkady"):sub(2, 3):reverse():reverse():reverse() .. "6p5r")
		p1:ReloadDropAmmoVisual()
		delay(0.1, function() --[[ Line: 109 | Upvalues: p1 (copy) ]]
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
function t.ShootEnd(p1, p2) --[[ Line: 121 ]]
	if p1.Local then
		p1:BroadcastInputEnded(p2)
	end
end
function t.ShootSound(p1, p2) --[[ Line: 126 | Upvalues: Audio (copy) ]]
	if p2 then
		Audio.ObjectLocal(p1.Model.Skeleton.BoundingBox, 2121005402)
	end
end
t.ScopeBegin = false
t.ScopeEnd = false
t.Reload = false
return t