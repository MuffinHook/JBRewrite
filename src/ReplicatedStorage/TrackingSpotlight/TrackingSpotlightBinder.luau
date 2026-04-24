-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(self)
	local instance = BaseObject.new(self)
	setmetatable(instance, t)
	instance.motor = self:WaitForChild("Pivot"):WaitForChild("TrackingSpotlightMotor")
	instance._lastDt = os.clock()
	instance._maxDYaw = 0.6283185307179586
	instance._lastPitch = 0
	instance._lastYaw = 0
	instance._pitchSpring = Spring.new(instance._lastPitch, 0, 0.6, 15)
	instance._yawSpring = Spring.new(instance._lastYaw, 0, 0.6, 15)
	local function updateTarget()
		local var12 = self:GetAttribute("TrackingSpotlightTargetUserId")
		local localPlayer = if var12 then Players:GetPlayerByUserId(var12) else nil
		if localPlayer then
			instance:TrackPlayer(localPlayer)
		else
			instance:StopTracking()
		end
	end
	instance.maid:GiveTask(self:GetAttributeChangedSignal("TrackingSpotlightTargetUserId"):Connect(updateTarget))
	local var3 = self:GetAttribute("TrackingSpotlightTargetUserId")
	local localPlayer = if var3 then Players:GetPlayerByUserId(var3) else nil
	if localPlayer then
		instance:TrackPlayer(localPlayer)
	else
		instance:StopTracking()
	end
	return instance
end
function t.TrackPlayer(self, p2)
	local instance = Maid.new()
	self.maid.trackingMaid = instance
	instance:GiveTask(RunService.Heartbeat:Connect(function()
		if p2.Character then
			if p2.Character.PrimaryPart then
				local Position = p2.Character.PrimaryPart.Position
				self:MoveTowardsTarget(Position)
				local instance = CharacterUtils.getHumanoid(p2.Character)
				if instance then
					local Tip = self.obj:FindFirstChild("Top"):FindFirstChild("Tip")
					if GeomUtils.isPointInCylinder(Position, Tip.Position, Tip.CFrame.LookVector, 200, 2.5) then
						if not instance:GetAttribute("IsInTrackingSpotlight") then
							instance:SetAttribute("IsInTrackingSpotlight", true)
						end
					elseif instance:GetAttribute("IsInTrackingSpotlight") then
						instance:SetAttribute("IsInTrackingSpotlight", nil)
					end
				end
			else
				self:StopTracking()
			end
		else
			self:StopTracking()
		end
	end))
	instance:GiveTask(function()
		local instance = CharacterUtils.getHumanoid(p2.Character)
		if instance then
			instance:SetAttribute("IsInTrackingSpotlight", nil)
		end
	end)
	instance:GiveTask(function()
		self._lastPitch = 0
		self._lastYaw = 0
		self.motor.C1 = CFrame.new()
	end)
end
function t.StopTracking(self)
	self.maid.trackingMaid = nil
end
function t.MoveTowardsTarget(self, p2)
	local instance = os.clock()
	local localPlayer = instance - self._lastDt
	self._lastDt = instance
	local Pivot = self.obj:FindFirstChild("Pivot")
	local Top = self.obj:FindFirstChild("Top")
	local Pivot_2 = Top:FindFirstChild("Pivot")
	local Tip = Top:FindFirstChild("Tip")
	local var3 = Pivot_2.CFrame:PointToObjectSpace(Tip.Position)
	local localPlayer = Pivot.CFrame:PointToObjectSpace(p2)
	local v5, v6 = GeomUtils.offsetLookAtTarget(var3.x, var3.y, nil, localPlayer.x, localPlayer.y, localPlayer.z)
	self._lastPitch = self._lastPitch + math.clamp(GeomUtils.shortAngleDist(self._lastPitch, v6), -self._maxDYaw * localPlayer, self._maxDYaw * localPlayer)
	self._lastYaw = self._lastYaw + math.clamp(GeomUtils.shortAngleDist(self._lastYaw, v5), -self._maxDYaw * localPlayer, self._maxDYaw * localPlayer)
	local var13 = self._pitchSpring:SetTarget(self._lastPitch)
	local var14 = self._yawSpring:SetTarget(self._lastYaw)
	self.motor.C1 = CFrame.Angles(0, var14, 0) * CFrame.Angles(var13, 0, 0)
end
return Binder.new("TrackingSpotlight", t)
