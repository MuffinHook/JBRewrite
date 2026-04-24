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
function t.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.motor = p1:WaitForChild("Pivot"):WaitForChild("TrackingSpotlightMotor")
	v1._lastDt = os.clock()
	v1._maxDYaw = 0.6283185307179586
	v1._lastPitch = 0
	v1._lastYaw = 0
	v1._pitchSpring = Spring.new(v1._lastPitch, 0, 0.6, 15)
	v1._yawSpring = Spring.new(v1._lastYaw, 0, 0.6, 15)
	local function updateTarget()
		local v12 = p1:GetAttribute("TrackingSpotlightTargetUserId")
		local v2 = if v12 then Players:GetPlayerByUserId(v12) else nil
		if v2 then
			v1:TrackPlayer(v2)
		else
			v1:StopTracking()
		end
	end
	v1.maid:GiveTask(p1:GetAttributeChangedSignal("TrackingSpotlightTargetUserId"):Connect(updateTarget))
	local v3 = p1:GetAttribute("TrackingSpotlightTargetUserId")
	local v4 = if v3 then Players:GetPlayerByUserId(v3) else nil
	if v4 then
		v1:TrackPlayer(v4)
	else
		v1:StopTracking()
	end
	return v1
end
function t.TrackPlayer(p1, p2)
	local v1 = Maid.new()
	p1.maid.trackingMaid = v1
	v1:GiveTask(RunService.Heartbeat:Connect(function()
		if p2.Character then
			if p2.Character.PrimaryPart then
				local Position = p2.Character.PrimaryPart.Position
				p1:MoveTowardsTarget(Position)
				local v1 = CharacterUtils.getHumanoid(p2.Character)
				if v1 then
					local Tip = p1.obj:FindFirstChild("Top"):FindFirstChild("Tip")
					if GeomUtils.isPointInCylinder(Position, Tip.Position, Tip.CFrame.LookVector, 200, 2.5) then
						if not v1:GetAttribute("IsInTrackingSpotlight") then
							v1:SetAttribute("IsInTrackingSpotlight", true)
						end
					elseif v1:GetAttribute("IsInTrackingSpotlight") then
						v1:SetAttribute("IsInTrackingSpotlight", nil)
					end
				end
			else
				p1:StopTracking()
			end
		else
			p1:StopTracking()
		end
	end))
	v1:GiveTask(function()
		local v1 = CharacterUtils.getHumanoid(p2.Character)
		if v1 then
			v1:SetAttribute("IsInTrackingSpotlight", nil)
		end
	end)
	v1:GiveTask(function()
		p1._lastPitch = 0
		p1._lastYaw = 0
		p1.motor.C1 = CFrame.new()
	end)
end
function t.StopTracking(p1)
	p1.maid.trackingMaid = nil
end
function t.MoveTowardsTarget(p1, p2)
	local v1 = os.clock()
	local v2 = v1 - p1._lastDt
	p1._lastDt = v1
	local Pivot = p1.obj:FindFirstChild("Pivot")
	local Top = p1.obj:FindFirstChild("Top")
	local Pivot_2 = Top:FindFirstChild("Pivot")
	local Tip = Top:FindFirstChild("Tip")
	local v3 = Pivot_2.CFrame:PointToObjectSpace(Tip.Position)
	local v4 = Pivot.CFrame:PointToObjectSpace(p2)
	local v5, v6 = GeomUtils.offsetLookAtTarget(v3.x, v3.y, nil, v4.x, v4.y, v4.z)
	p1._lastPitch = p1._lastPitch + math.clamp(GeomUtils.shortAngleDist(p1._lastPitch, v6), -p1._maxDYaw * v2, p1._maxDYaw * v2)
	p1._lastYaw = p1._lastYaw + math.clamp(GeomUtils.shortAngleDist(p1._lastYaw, v5), -p1._maxDYaw * v2, p1._maxDYaw * v2)
	local v13 = p1._pitchSpring:SetTarget(p1._lastPitch)
	local v14 = p1._yawSpring:SetTarget(p1._lastYaw)
	p1.motor.C1 = CFrame.Angles(0, v14, 0) * CFrame.Angles(v13, 0, 0)
end
return Binder.new("TrackingSpotlight", t)
