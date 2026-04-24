-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Players = game:GetService("Players")
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local Falling = require(ReplicatedStorage.Game.Falling)
local Shockwave = require(ReplicatedStorage.Game.Shockwave)
local Maid = require(ReplicatedStorage.Std.Maid)
require(ReplicatedStorage.Module.UI)
local Binder = require(ReplicatedStorage.Std.Binder)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local RobberyUtils = require(ReplicatedStorage.Robbery.RobberyUtils)
local OilRigConsts = require(ReplicatedStorage.OilRig.OilRigConsts)
local OilRigUtils = require(ReplicatedStorage.OilRig.OilRigUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(self, p2)
	local instance = BaseObject.new(self)
	setmetatable(instance, t)
	local function handleProgressionState()
		instance.maid.progressionMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			OilRigUtils.getProgressionState(instance.obj)
		end
	end
	instance.maid:GiveTask(OilRigUtils.getProgressionStateChangedSignal(instance.obj):Connect(handleProgressionState))
	local function handleStatus()
		local var12 = RobberyUtils.getStatus(instance.obj)
		instance.maid.currRobberyMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			local isSTARTED = var12 == RobberyConsts.ENUM_STATUS.STARTED
		end
	end
	instance.maid:GiveTask(RobberyUtils.getStatusChangedSignal(instance.obj):Connect(handleStatus))
	instance.maid.localPlayerRobberyMaid = Maid.new()
	local function handleLocalPlayerInRobbery()
		instance.maid.progressionMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			OilRigUtils.getProgressionState(instance.obj)
		end
		local v2 = RobberyUtils.getStatus(instance.obj)
		instance.maid.currRobberyMaid = Maid.new()
		if OilRigUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			local isSTARTED = v2 == RobberyConsts.ENUM_STATUS.STARTED
		end
		instance.maid.localPlayerRobberyMaid:DoCleaning()
	end
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(instance.obj, OilRigConsts.PLAYERS_IN_ROBBERY_FOLDER_NAME, function(self, p2)
		p2:GiveTask(RxInstanceUtils.observeChildren(self, function(self, p2)
			if self.Name == tostring(Players.LocalPlayer.UserId) then
				instance.maid.progressionMaid = Maid.new()
				if OilRigUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
					OilRigUtils.getProgressionState(instance.obj)
				end
				local var3 = RobberyUtils.getStatus(instance.obj)
				instance.maid.currRobberyMaid = Maid.new()
				if OilRigUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
					local isSTARTED = var3 == RobberyConsts.ENUM_STATUS.STARTED
				end
				instance.maid.localPlayerRobberyMaid:DoCleaning()
				p2:GiveTask(self.Changed:Connect(handleLocalPlayerInRobbery))
			end
		end))
	end))
	local UpdateOilTankRemote = instance.obj:WaitForChild("UpdateOilTankRemote")
	instance.maid:GiveTask(UpdateOilTankRemote.OnClientEvent:Connect(function(self, p2)
		local instance = self:GetAttribute("OriginalCFrame")
		local v2 = self:GetAttribute("OriginalSize")
		local Oil = self:FindFirstChild("Oil")
		assert(Oil and Oil:IsA("BasePart"))
		local var4 = 1 - p2
		Oil.Size = Vector3.new(1, var4, 1) * v2
		Oil.CFrame = instance * CFrame.new(0, -v2.Y / 2 * (1 - var4), 0)
		if var4 <= 0.001 then
			Oil.Transparency = 1
		else
			Oil.Transparency = 0
		end
	end))
	instance:_listenEverywhere()
	return instance
end
function t._listenEverywhere(self)
	local function handleProgressionState()
		if OilRigUtils.getProgressionState(self.obj) == OilRigConsts.PROGRESSION_STATE.BlowUp then
			self:_launchBlowUp()
		end
	end
	self.maid:GiveTask(OilRigUtils.getProgressionStateChangedSignal(self.obj):Connect(handleProgressionState))
end
function t.IsPlayerInRobbery(self, p2)
	return OilRigUtils.getIsPlayerInRobbery(self.obj, p2)
end
function t._launchBlowUp(self)
	local Explosion = self.obj:FindFirstChild("OpenCloseSignal"):FindFirstChild("Explosion")
	assert(Explosion)
	Shockwave.new(Explosion.Position, {
		Duration = 4,
		MaxRadius = 750,
		StartTransparency = 0.2,
		EndTransparency = 1
	}).OnPastLocalPlayer:Connect(function()
		local ShockwaveRemote = self.obj:FindFirstChild("ShockwaveRemote")
		if ShockwaveRemote then
			ShockwaveRemote:FireServer()
		end
		if VehicleUtils.GetLocalVehiclePacket() ~= nil then
			CharacterUtil.OnJump()
			task.wait(0.1)
		end
		Falling.StartRagdolling(5)
	end)
end
return Binder.new(OilRigConsts.TAG_NAME, t)
