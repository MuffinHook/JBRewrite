-- Reviewed by Claude
-- variables reassigned
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
	local randX = math.random() * 2 - 1
	local randY = math.random() * 2 - 1
	return Vector3.new(randX, randY, math.random() * 2 - 1).Unit
end
local eventObject = nil
local C4 = {
	__ClassName = "C4"
}
C4.__index = C4
setmetatable(C4, Gun)
function C4.Init(self)
	eventObject = self.Event
end
function C4.new(self, weaponConfig, setupData)
	local weaponInstance = Gun.new(self, weaponConfig, setupData)
	setmetatable(weaponInstance, C4)
	weaponInstance.ApplySkin = false
	weaponInstance:Setup(setupData)
	if weaponInstance.Local and AdminPermUtils.hasPerms(weaponInstance.Player) then
		weaponInstance.Maid:GiveTask(ActionButtonService.add({
			priority = 750,
			image = "rbxassetid://4939740665",
			keyCodes = { Enum.KeyCode.F },
			onPressed = function()
				local detonableC4Instance = getDetonatableC4(weaponInstance.Player)
				if detonableC4Instance then
					detonableC4Instance:Detonate({
						nuke = true
					})
				end
			end
		}))
	end
	return weaponInstance
end
function C4.SetupArmWelds(self) end
function C4.UpdateArmIK(self)
	local IK = self.IK
	IK.RightArm = self.Model.Model.Hold.Position
	IK.RightAngle = self.Config.Motion.RightElbowAngle
end
function C4.SetupTip(self)
	self.TipOffset = Vector3.new()
end
function C4.BulletEmitterOnLocalHitPlayer(self) end
function C4.ShootBegin(self, inputState)
	tick()
	local c4Instance, launchPosition, mousePosition, gravityValue, projectileVelocity, _, rotationVelocityBase, randomRotX, randomRotY, randomRotZ
	if not self.Local then
		if self.Local then
			if getNumActiveC4(self.Player) >= 2 then
				return false
			end
			c4Instance = getThrowableC4(self.Player)
			if not c4Instance then
				error("No throwable C4 left in pool")
			end
		else
			c4Instance = nil
		end
		if not self:ShootCheckConditions() then
			return false
		end
		self:DecrementAmmo()
		self:SetNextShotPossible()
		if self.Local then
			launchPosition = self.UpperTorso.CFrame * Vector3.new(0, 0, -2)
			mousePosition = self.MousePosition
			gravityValue = workspace.Gravity
			projectileVelocity, _ = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(launchPosition, mousePosition, 50, gravityValue, false)
			c4Instance._obj.PrimaryPart.Anchored = false
			c4Instance._obj:SetPrimaryPartCFrame(CFrame.new(launchPosition, launchPosition + projectileVelocity))
			c4Instance:SetVelocity(projectileVelocity)
			rotationVelocityBase = -0.25 * projectileVelocity:Cross(Vector3.new(0, 1, 0))
			randomRotX = math.random() * 2 - 1
			randomRotY = math.random() * 2 - 1
			randomRotZ = math.random() * 2 - 1
			c4Instance:SetRotVelocity(rotationVelocityBase + Vector3.new(randomRotX, randomRotY, randomRotZ).Unit * 5)
			task.spawn(function()
				c4Instance:ListenForAttach()
			end)
			eventObject:FireServer("x" .. ("guynw"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("wpwlw8gc4"):sub(5, 6):reverse():reverse():reverse() .. "" .. "" .. ("st5golsm"):sub(5, 7):reverse():reverse():reverse() .. "k")
			self.Model.Model.Screen.Color = Color3.new(255/255, 0/255, 0/255)
		end
		if self.Local then
			self:BroadcastInputBegan(inputState)
		end
		return
	end
	local detonationOccurred = false
	while true do
		local detonableC4 = getDetonatableC4(self.Player)
		if detonableC4 then
			detonableC4:Detonate()
			detonationOccurred = true
		end
		if not detonableC4 then
			if detonationOccurred then
				Audio.ObjectLocal(self.Model.Skeleton.BoundingBox, 6036722343, {
					Volume = 1
				})
				self.SpringItemOffset:SetTarget(self.Config.Motion.Raise.Springs.ItemOffset)
				self.SpringItemRotation:SetTarget(self.Config.Motion.Raise.Springs.ItemRotation)
				self.SpringNeckRotation:SetTarget(self.Config.Motion.Raise.Springs.NeckRotation)
				delay(0.2, function()
					self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
					self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
					self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
				end)
				self.Model.Model.Screen.Color = Color3.fromRGB(91, 93, 105)
			else
				if self.Local then
					if getNumActiveC4(self.Player) >= 2 then
						return false
					end
					c4Instance = getThrowableC4(self.Player)
					if not c4Instance then
						error("No throwable C4 left in pool")
					end
				else
					c4Instance = nil
				end
				if not self:ShootCheckConditions() then
					return false
				end
				self:DecrementAmmo()
				self:SetNextShotPossible()
				if self.Local then
					launchPosition = self.UpperTorso.CFrame * Vector3.new(0, 0, -2)
					mousePosition = self.MousePosition
					gravityValue = workspace.Gravity
					projectileVelocity, _ = SimulatedPhysicsProjectile.CalculateVelocityToHitTargetWithSpeed(launchPosition, mousePosition, 50, gravityValue, false)
					c4Instance._obj.PrimaryPart.Anchored = false
					c4Instance._obj:SetPrimaryPartCFrame(CFrame.new(launchPosition, launchPosition + projectileVelocity))
					c4Instance:SetVelocity(projectileVelocity)
					rotationVelocityBase = -0.25 * projectileVelocity:Cross(Vector3.new(0, 1, 0))
					randomRotX = math.random() * 2 - 1
					randomRotY = math.random() * 2 - 1
					randomRotZ = math.random() * 2 - 1
					c4Instance:SetRotVelocity(rotationVelocityBase + Vector3.new(randomRotX, randomRotY, randomRotZ).Unit * 5)
					task.spawn(function()
						c4Instance:ListenForAttach()
					end)
					eventObject:FireServer("x" .. ("guynw"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("wpwlw8gc4"):sub(5, 6):reverse():reverse():reverse() .. "" .. "" .. ("st5golsm"):sub(5, 7):reverse():reverse():reverse() .. "k")
					self.Model.Model.Screen.Color = Color3.new(255/255, 0/255, 0/255)
				end
				if self.Local then
					self:BroadcastInputBegan(inputState)
				end
			end
			break
		end
	end
end
function C4.ShootEnd(self, inputState)
	if self.Local then
		self:BroadcastInputEnded(inputState)
	end
end
function C4.ShootSound(self, inputState) end
function C4.ReloadDropAmmoSound(self) end
function C4.ReloadRefillAmmoSound(self) end
function C4.ReloadDropAmmoVisual(self) end
function C4.ReloadRefillAmmoVisual(self) end
C4.ScopeBegin = false
C4.ScopeEnd = false
C4.Reload = false
return C4
