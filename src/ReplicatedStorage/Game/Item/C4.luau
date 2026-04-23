-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local AdminPermUtils = require(ReplicatedStorage.App.AdminPermUtils)
require(ReplicatedStorage.Module.R15IKv2)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local C4Binder = require(ReplicatedStorage.Game.C4.C4Binder)
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Gun = require(script.Parent.Gun)
local function getDetonatableC4(p1)
	for i, v in ipairs((C4Binder:GetAll())) do
		if v:GetCreator() == p1 and (not v:IsListening() and (not v:GetDetonated() and v:GetStuck())) then
			return v
		end
	end
end
local function getThrowableC4(p1)
	for i, v in ipairs((C4Binder:GetAll())) do
		if v:GetCreator() == p1 and not (v:IsListening() or (v:GetDetonated() or v:GetStuck())) then
			return v
		end
	end
end
local function getNumActiveC4(p1)
	local count = 0
	for i, v in ipairs((C4Binder:GetAll())) do
		if v:GetCreator() == p1 and (v:IsListening() or v:GetStuck()) then
			count = count + 1
		end
	end
	return count
end
local function randomVector()
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local v2 = nil
local t = {
	__ClassName = "C4"
}
t.__index = t
setmetatable(t, Gun)
function t.Init(p1)
	v2 = p1.Event
end
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1.ApplySkin = false
	v1:Setup(p3)
	if v1.Local and AdminPermUtils.hasPerms(v1.Player) then
		v1.Maid:GiveTask(ActionButtonService.add({
			priority = 750,
			image = "rbxassetid://4939740665",
			keyCodes = { Enum.KeyCode.F },
			onPressed = function()
				local v12 = getDetonatableC4(v1.Player)
				if v12 then
					v12:Detonate({
						nuke = true
					})
				end
			end
		}))
	end
	return v1
end
function t.SetupArmWelds(p1) end
function t.UpdateArmIK(p1)
	local IK = p1.IK
	IK.RightArm = p1.Model.Model.Hold.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
end
function t.SetupTip(p1)
	p1.TipOffset = Vector3.new()
end
function t.BulletEmitterOnLocalHitPlayer(p1) end
function t.ShootBegin(p1, p2)
	tick()
	local v1, v22, v3, v4, v5, _, v6, v7, v8, v9
	if not p1.Local then
		if p1.Local then
			if getNumActiveC4(p1.Player) >= 2 then
				return false
			end
			v1 = getThrowableC4(p1.Player)
			if not v1 then
				error("No throwable C4 left in pool")
			end
		else
			v1 = nil
		end
		if not p1:ShootCheckConditions() then
			return false
		end
		p1:DecrementAmmo()
		p1:SetNextShotPossible()
		if p1.Local then
			v22 = p1.UpperTorso.CFrame * Vector3.new(0, 0, -2)
			v3 = p1.MousePosition
			v4 = workspace.Gravity
			v5, _ = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(v22, v3, 50, v4, false)
			v1._obj.PrimaryPart.Anchored = false
			v1._obj:SetPrimaryPartCFrame(CFrame.new(v22, v22 + v5))
			v1:SetVelocity(v5)
			v6 = -0.25 * v5:Cross(Vector3.new(0, 1, 0))
			v7 = math.random() * 2 - 1
			v8 = math.random() * 2 - 1
			v9 = math.random() * 2 - 1
			v1:SetRotVelocity(v6 + Vector3.new(v7, v8, v9).Unit * 5)
			task.spawn(function()
				v1:ListenForAttach()
			end)
			v2:FireServer("x" .. ("guynw"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("wpwlw8gc4"):sub(5, 6):reverse():reverse():reverse() .. "" .. "" .. ("st5golsm"):sub(5, 7):reverse():reverse():reverse() .. "k")
			p1.Model.Model.Screen.Color = Color3.new(255/255, 0/255, 0/255)
		end
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
		return
	end
	local v10 = false
	while true do
		local v11 = getDetonatableC4(p1.Player)
		if v11 then
			v11:Detonate()
			v10 = true
		end
		if not v11 then
			if v10 then
				Audio.ObjectLocal(p1.Model.Skeleton.BoundingBox, 6036722343, {
					Volume = 1
				})
				p1.SpringItemOffset:SetTarget(p1.Config.Motion.Raise.Springs.ItemOffset)
				p1.SpringItemRotation:SetTarget(p1.Config.Motion.Raise.Springs.ItemRotation)
				p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Raise.Springs.NeckRotation)
				delay(0.2, function()
					p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
					p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
					p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
				end)
				p1.Model.Model.Screen.Color = Color3.fromRGB(91, 93, 105)
			else
				if p1.Local then
					if getNumActiveC4(p1.Player) >= 2 then
						return false
					end
					v1 = getThrowableC4(p1.Player)
					if not v1 then
						error("No throwable C4 left in pool")
					end
				else
					v1 = nil
				end
				if not p1:ShootCheckConditions() then
					return false
				end
				p1:DecrementAmmo()
				p1:SetNextShotPossible()
				if p1.Local then
					v22 = p1.UpperTorso.CFrame * Vector3.new(0, 0, -2)
					v3 = p1.MousePosition
					v4 = workspace.Gravity
					v5, _ = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(v22, v3, 50, v4, false)
					v1._obj.PrimaryPart.Anchored = false
					v1._obj:SetPrimaryPartCFrame(CFrame.new(v22, v22 + v5))
					v1:SetVelocity(v5)
					v6 = -0.25 * v5:Cross(Vector3.new(0, 1, 0))
					v7 = math.random() * 2 - 1
					v8 = math.random() * 2 - 1
					v9 = math.random() * 2 - 1
					v1:SetRotVelocity(v6 + Vector3.new(v7, v8, v9).Unit * 5)
					task.spawn(function()
						v1:ListenForAttach()
					end)
					v2:FireServer("x" .. ("guynw"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("wpwlw8gc4"):sub(5, 6):reverse():reverse():reverse() .. "" .. "" .. ("st5golsm"):sub(5, 7):reverse():reverse():reverse() .. "k")
					p1.Model.Model.Screen.Color = Color3.new(255/255, 0/255, 0/255)
				end
				if p1.Local then
					p1:BroadcastInputBegan(p2)
				end
			end
			break
		end
	end
end
function t.ShootEnd(p1, p2)
	if p1.Local then
		p1:BroadcastInputEnded(p2)
	end
end
function t.ShootSound(p1, p2) end
function t.ReloadDropAmmoSound(p1) end
function t.ReloadRefillAmmoSound(p1) end
function t.ReloadDropAmmoVisual(p1) end
function t.ReloadRefillAmmoVisual(p1) end
t.ScopeBegin = false
t.ScopeEnd = false
t.Reload = false
return t