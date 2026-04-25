-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local t = {}
t.__index = t
function t.new(parentPart)
	local self = {}
	setmetatable(self, t)
	self.Maid = Maid.new()
	local Piston = parentPart:FindFirstChild("Piston")
	local PistonOrigin = parentPart:FindFirstChild("PistonOrigin")
	if not PistonOrigin then
		PistonOrigin = Instance.new("Part")
		PistonOrigin.Name = "PistonOrigin"
		PistonOrigin.Anchored = true
		PistonOrigin.Transparency = 1
		PistonOrigin.CanCollide = false
		PistonOrigin.CFrame = Piston.CFrame
		PistonOrigin.Parent = parentPart
	end
	self.RemoteEvent = parentPart:WaitForChild("RemoteEvent")
	local pistonSpring = Spring.new(0, 0, 1, 0)
	assert(true)
	local lastActivationTime = tick()
	local isSpringIdle = true
	self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local currentTime = tick()
		if currentTime - lastActivationTime > 3 then
			lastActivationTime = currentTime
			pistonSpring.Damp = 0.7
			pistonSpring.Freq = 50
			pistonSpring:SetTarget(1)
			Audio.ObjectLocal(Piston, 5327245125, {
				MaxDistance = 96
			})
			isSpringIdle = false
			delay(1, function()
				pistonSpring.Damp = 0.9
				pistonSpring.Freq = 10
				pistonSpring:SetTarget(0)
				isSpringIdle = true
			end)
		end
		Piston.CFrame = PistonOrigin.CFrame * CFrame.new(0, (1 - pistonSpring:Update()) * 10, 0)
	end))
	local lastSlamTime = 0
	self.Maid:GiveTask(Piston.Touched:Connect(function(p1)
		local springProgress = pistonSpring:Update()
		local affectedPlayer = Players:GetPlayerFromCharacter(p1.Parent)
		if affectedPlayer then
			local currentTime = tick()
			if currentTime - lastSlamTime > 1.5 and (springProgress > 0.05 and (springProgress < 0.95 and isSpringIdle == false)) then
				lastSlamTime = currentTime
				self:SlamPlayer(affectedPlayer)
			end
		end
	end))
	return self
end
function t.SlamPlayer(self, player)
	local Humanoid = player.Character.Humanoid
	Humanoid.BodyHeightScale.Value = 0.3
	Audio.ObjectLocal(Humanoid.RootPart, 5333889062)
	delay(4, function()
		Humanoid.BodyHeightScale.Value = 1
		Audio.ObjectLocal(Humanoid.RootPart, 5333889401)
	end)
	self.RemoteEvent:FireServer()
end
function t.Destroy(self)
	self.Maid:Destroy()
	self.Maid = nil
end
return t
