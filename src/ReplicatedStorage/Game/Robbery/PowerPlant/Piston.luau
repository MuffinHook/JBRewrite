-- Reviewed by Claude
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2.Maid = Maid.new()
	local Piston = p1:FindFirstChild("Piston")
	local PistonOrigin = p1:FindFirstChild("PistonOrigin")
	if not PistonOrigin then
		PistonOrigin = Instance.new("Part")
		PistonOrigin.Name = "PistonOrigin"
		PistonOrigin.Anchored = true
		PistonOrigin.Transparency = 1
		PistonOrigin.CanCollide = false
		PistonOrigin.CFrame = Piston.CFrame
		PistonOrigin.Parent = p1
	end
	t2.RemoteEvent = p1:WaitForChild("RemoteEvent")
	local v2 = Spring.new(0, 0, 1, 0)
	assert(true)
	local v3 = tick()
	local v4 = true
	t2.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local v1 = tick()
		if v1 - v3 > 3 then
			v3 = v1
			v2.Damp = 0.7
			v2.Freq = 50
			v2:SetTarget(1)
			Audio.ObjectLocal(Piston, 5327245125, {
				MaxDistance = 96
			})
			v4 = false
			delay(1, function()
				v2.Damp = 0.9
				v2.Freq = 10
				v2:SetTarget(0)
				v4 = true
			end)
		end
		Piston.CFrame = PistonOrigin.CFrame * CFrame.new(0, (1 - v2:Update()) * 10, 0)
	end))
	local v5 = 0
	t2.Maid:GiveTask(Piston.Touched:Connect(function(p1)
		local v1 = v2:Update()
		local v22 = Players:GetPlayerFromCharacter(p1.Parent)
		if v22 then
			local v3 = tick()
			if v3 - v5 > 1.5 and (v1 > 0.05 and (v1 < 0.95 and v4 == false)) then
				v5 = v3
				t2:SlamPlayer(v22)
			end
		end
	end))
	return t2
end
function t.SlamPlayer(p1, p2)
	local Humanoid = p2.Character.Humanoid
	Humanoid.BodyHeightScale.Value = 0.3
	Audio.ObjectLocal(Humanoid.RootPart, 5333889062)
	delay(4, function()
		Humanoid.BodyHeightScale.Value = 1
		Audio.ObjectLocal(Humanoid.RootPart, 5333889401)
	end)
	p1.RemoteEvent:FireServer()
end
function t.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t
