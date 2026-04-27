local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local TrackingSpotlightClass = {}
TrackingSpotlightClass.__index = TrackingSpotlightClass
setmetatable(TrackingSpotlightClass, BaseObject)
function TrackingSpotlightClass.new(self)
	local instance = BaseObject.new(self)
	setmetatable(instance, TrackingSpotlightClass)
	instance.motor = self:WaitForChild("Pivot"):WaitForChild("TrackingSpotlightMotor")
	instance._lastDt = os.clock()
	instance._maxDYaw = 0.6283185307179586
	instance._lastPitch = 0
	instance._lastYaw = 0
	instance._pitchSpring = Spring.new(instance._lastPitch, 0, 0.6, 15)
	instance._yawSpring = Spring.new(instance._lastYaw, 0, 0.6, 15)
	local function updateTarget()
		local targetUserId = self:GetAttribute("TrackingSpotlightTargetUserId")
		local targetPlayer = if targetUserId then Players:GetPlayerByUserId(targetUserId) else nil
		if targetPlayer then
			instance:TrackPlayer(targetPlayer)
		else
			instance:StopTracking()
		end
	end
	instance.maid:GiveTask(self:GetAttributeChangedSignal("TrackingSpotlightTargetUserId"):Connect(updateTarget))
	local targetUserId = self:GetAttribute("TrackingSpotlightTargetUserId")
	local targetPlayer = if targetUserId then Players:GetPlayerByUserId(targetUserId) else nil
	if targetPlayer then
		instance:TrackPlayer(targetPlayer)
	else
		instance:StopTracking()
	end
	return instance
end
function TrackingSpotlightClass.TrackPlayer(self, targetPlayer)
	local trackingMaid = Maid.new()
	self.maid.trackingMaid = trackingMaid
	trackingMaid:GiveTask(RunService.Heartbeat:Connect(function()
		if targetPlayer.Character then
			if targetPlayer.Character.PrimaryPart then
				local Position = targetPlayer.Character.PrimaryPart.Position
				self:MoveTowardsTarget(Position)
				local humanoid = CharacterUtils.getHumanoid(targetPlayer.Character)
				if humanoid then
					local Tip = self.obj:FindFirstChild("Top"):FindFirstChild("Tip")
					if GeomUtils.isPointInCylinder(Position, Tip.Position, Tip.CFrame.LookVector, 200, 2.5) then
						if not humanoid:GetAttribute("IsInTrackingSpotlight") then
							humanoid:SetAttribute("IsInTrackingSpotlight", true)
						end
					elseif humanoid:GetAttribute("IsInTrackingSpotlight") then
						humanoid:SetAttribute("IsInTrackingSpotlight", nil)
					end
				end
			else
				self:StopTracking()
			end
		else
			self:StopTracking()
		end
	end))
	trackingMaid:GiveTask(function()
		local humanoid = CharacterUtils.getHumanoid(targetPlayer.Character)
		if humanoid then
			humanoid:SetAttribute("IsInTrackingSpotlight", nil)
		end
	end)
	trackingMaid:GiveTask(function()
		self._lastPitch = 0
		self._lastYaw = 0
		self.motor.C1 = CFrame.new()
	end)
end
function TrackingSpotlightClass.StopTracking(self)
	self.maid.trackingMaid = nil
end
function TrackingSpotlightClass.MoveTowardsTarget(self, targetPosition)
	local currentTime = os.clock()
	local deltaTime = currentTime - self._lastDt
	self._lastDt = currentTime
	local Pivot = self.obj:FindFirstChild("Pivot")
	local Top = self.obj:FindFirstChild("Top")
	local PivotChild = Top:FindFirstChild("Pivot")
	local Tip = Top:FindFirstChild("Tip")
	local tipRelativePosition = PivotChild.CFrame:PointToObjectSpace(Tip.Position)
	local targetRelativePosition = Pivot.CFrame:PointToObjectSpace(targetPosition)
	local yawOffset, pitchOffset = GeomUtils.offsetLookAtTarget(tipRelativePosition.x, tipRelativePosition.y, nil, targetRelativePosition.x, targetRelativePosition.y, targetRelativePosition.z)
	self._lastPitch = self._lastPitch + math.clamp(GeomUtils.shortAngleDist(self._lastPitch, pitchOffset), -self._maxDYaw * deltaTime, self._maxDYaw * deltaTime)
	self._lastYaw = self._lastYaw + math.clamp(GeomUtils.shortAngleDist(self._lastYaw, yawOffset), -self._maxDYaw * deltaTime, self._maxDYaw * deltaTime)
	local updatedPitch = self._pitchSpring:SetTarget(self._lastPitch)
	local updatedYaw = self._yawSpring:SetTarget(self._lastYaw)
	self.motor.C1 = CFrame.Angles(0, updatedYaw, 0) * CFrame.Angles(updatedPitch, 0, 0)
end
return Binder.new("TrackingSpotlight", TrackingSpotlightClass)
