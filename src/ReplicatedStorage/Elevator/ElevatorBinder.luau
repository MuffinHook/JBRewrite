-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Interval = require(ReplicatedStorage.Std.Interval)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
require(ReplicatedStorage.Door2.DoorBinder)
local ElevatorBinder = {}
ElevatorBinder.__index = ElevatorBinder
setmetatable(ElevatorBinder, BaseObject)
function ElevatorBinder.new(instance, manifest)
	local self = BaseObject.new(instance)
	setmetatable(self, ElevatorBinder)
	self.manifest = manifest
	self.maid:GiveTask(Interval.every(0.5):Connect(function()
		if self:_isLocalColliding() then
			if not self.maid.running then
				self:_hook()
			end
		elseif self.maid.running then
			self.maid.running = nil
		end
	end))
	return self
end
function ElevatorBinder._isLocalColliding(self)
	local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
	raycastParams.FilterDescendantsInstances = { self.manifest.floor }
	if rootPart then
		return workspace:Raycast(rootPart.Position, Vector3.new(0, -20, 0), raycastParams) ~= nil
	else
		return false
	end
end
function ElevatorBinder._hook(self)
	local floor = self.manifest.floor
	local previousCFrame = floor.CFrame
	self.maid.running = RunService.Heartbeat:Connect(function()
		local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		local currentCFrame = floor.CFrame
		rootPart.CFrame = currentCFrame * previousCFrame:Inverse() * rootPart.CFrame
		previousCFrame = currentCFrame
	end)
end
return ManifestBinder.new("Elevator", {
	floor = "Car/InnerModel/Floor"
}, ElevatorBinder)
