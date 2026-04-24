-- Reviewed by Claude
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local DoorConsts = require(ReplicatedStorage.Door2.DoorConsts)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local VaultDoorPuzzleUtils = require(ReplicatedStorage.Casino.VaultDoorPuzzleUtils)
local VaultDoorPuzzle = {}
VaultDoorPuzzle.__index = VaultDoorPuzzle
setmetatable(VaultDoorPuzzle, BaseObject)
function VaultDoorPuzzle.new(puzzleObj, manifest)
	local puzzleInstance = BaseObject.new(puzzleObj)
	setmetatable(puzzleInstance, VaultDoorPuzzle)
	RxInstanceUtils.yieldForProperty(puzzleObj, "PrimaryPart")
	puzzleInstance.manifest = manifest
	puzzleInstance._pos = 0
	local function action(actionConfig, isActive)
		if isActive and puzzleInstance:GetHacker() then
			manifest.updateDirectionRemote:FireServer()
		elseif isActive then
			manifest.requestHackRemote:FireServer()
		end
		return true
	end
	local function preUpdateFun(actionConfig)
		local currentHacker = puzzleInstance:GetHacker()
		local isNotDisabled = not puzzleInstance:GetDisabled()
		if isNotDisabled then
			isNotDisabled = if currentHacker == nil then true else currentHacker == Players.LocalPlayer
		end
		actionConfig.Enabled = isNotDisabled
	end
	local actionSpec = {
		Part = puzzleInstance.obj.PrimaryPart,
		Name = "",
		Timed = false,
		Dist = 8,
		Callback = action,
		Enabled = true,
		PreUpdateFun = preUpdateFun,
		PreUpdatePeriod = 0.1
	}
	puzzleInstance.spec = actionSpec
	puzzleInstance.maid:GiveTask(CircleAction.Add(actionSpec, puzzleInstance.obj.PrimaryPart))
	puzzleInstance.maid:GiveTask(puzzleInstance:GetHackerChangedSignal():Connect(function()
		local currentHacker = puzzleInstance:GetHacker()
		if currentHacker then
			local hackerMaid = Maid.new()
			puzzleInstance.maid.hackMaid = hackerMaid
			puzzleInstance:_hookHacker(hackerMaid, currentHacker)
		else
			puzzleInstance.maid.hackMaid = nil
			puzzleInstance:_hookHacker()
		end
	end))
	puzzleInstance:_hookHacker()
	return puzzleInstance
end
function VaultDoorPuzzle._hookHacker(self, hackerMaid, hackerPlayer)
	if hackerMaid == nil then
		self.spec.Name = "Crack"
	else
		local rotationForce = 0
		local directionInput = self:GetDirection()
		hackerMaid:GiveTask(self:GetDirectionChangedSignal():Connect(function()
			directionInput = self:GetDirection()
		end))
		hackerMaid:GiveTask(RunService.Heartbeat:Connect(function(deltaTime)
			rotationForce = rotationForce + 5 * directionInput * deltaTime
			rotationForce = rotationForce * 0.95
			self._pos = self._pos + rotationForce * deltaTime
			self.manifest.innerModel:SetPrimaryPartCFrame(self.obj.PrimaryPart.CFrame * CFrame.Angles(0, 0, self._pos))
		end))
		if hackerPlayer == Players.LocalPlayer then
			self.spec.Name = "Change Direction"
		end
	end
end
function VaultDoorPuzzle.GetHackerChangedSignal(self)
	return VaultDoorPuzzleUtils.getHackerChangedSignal(self.obj)
end
function VaultDoorPuzzle.GetHacker(self)
	return VaultDoorPuzzleUtils.getHacker(self.obj)
end
function VaultDoorPuzzle.SetDirection(self, direction)
	return VaultDoorPuzzleUtils.setDirection(self.obj, direction)
end
function VaultDoorPuzzle.GetDirection(self)
	return VaultDoorPuzzleUtils.getDirection(self.obj)
end
function VaultDoorPuzzle.GetDirectionChangedSignal(self)
	return VaultDoorPuzzleUtils.getDirectionChangedSignal(self.obj)
end
function VaultDoorPuzzle.GetDisabled(self)
	return VaultDoorPuzzleUtils.getDisabled(self.obj)
end
return ManifestBinder.new("VaultDoorPuzzle", {
	innerModel = DoorConsts.INNER_MODEL_NAME,
	requestHackRemote = "RequestHack",
	updateDirectionRemote = "UpdateDirection"
}, VaultDoorPuzzle)