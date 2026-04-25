-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local instance = nil
local table2 = nil
local t = {}
t.__index = t
function t.new(p1, p2)
	local table2 = setmetatable({}, t)
	table2.p0 = p1
	table2.v0 = p2
	local var3 = ReplicatedStorage.Resource.HeliBomb:Clone()
	instance.WeldAllTo(var3, var3.Rocket)
	var3.Rocket.Anchored = true
	var3.Rocket.CFrame = p1
	var3.Parent = workspace
	table2.Model = var3
	return table2
end
local var3 = Vector3.new()
local bombRotationOffset = CFrame.Angles(0, math.pi, 0)
function t.Animate(p1, p2)
	local elapsedTime = p2 or table2.GetNowSync()
	local lastFrameTime = elapsedTime
	local function Heartbeat()
		local currentTime = table2.GetNowSync()
		local deltaTime = currentTime - elapsedTime
		local frameDelta = currentTime - lastFrameTime
		lastFrameTime = currentTime
		local velocityVector = p1.v0 * deltaTime + Vector3.new(0, -98.10000000000001 * deltaTime * deltaTime, 0)
		p1.Model.Rocket.CFrame = CFrame.new(var3, (p1.p0.LookVector:Lerp(Vector3.new(0, -1, 0), (math.min(1, deltaTime * 1.3333333333333333))))) * bombRotationOffset + p1.p0.p + velocityVector
		if deltaTime - frameDelta < 0.3 and deltaTime > 0.3 then
			p1.Model.Fire.Particle.Enabled = true
		end
		if deltaTime > 0.3 then
			local v8, v9 = RayCast.RayIgnoreNonCollide(p1.p0.p + velocityVector, Vector3.new(0, -1, 0), math.abs(p1.v0.Y + -196.20000000000002 * deltaTime) * frameDelta, p1.Model)
			if v8 then
				p1:Explode(v9)
			end
		end
		if deltaTime > 5 and not p1.Exploded then
			p1:Destroy()
		end
	end
	p1.Runtime = RunService.Heartbeat:Connect(Heartbeat)
end
local eventRemote = nil
function t.Explode(p1, p2)
	p1.Exploded = true
	delay(2, function()
		p1:Destroy()
	end)
	if p1.Runtime then
		p1.Runtime:Disconnect()
		p1.Runtime = nil
	end
	p1.Model.Fire.Particle.Enabled = false
	p1.Model.Rocket.Transparency = 1
	local Explosion = Instance.new("Explosion")
	Explosion.ExplosionType = Enum.ExplosionType.NoCraters
	Explosion.DestroyJointRadiusPercent = 0
	Explosion.Position = p2
	Explosion.Parent = workspace
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://55224766"
	Sound.Parent = p1.Model.Rocket
	Sound.Volume = 0.8
	Sound:Play()
	local Character = Players.LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			local RootPart = Humanoid.RootPart
			if RootPart then
				local instance = RootPart.Position - p2
				local var3 = math.max(24 - instance.Magnitude, 0) / 24
				if var3 > 0.001 then
					RootPart.Velocity = RootPart.Velocity + instance.Unit * var3 * 30
					if p1._owner then
						print(p1._owner)
						eventRemote:FireServer("x" .. ("oo9w30"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "41csnt", var3 * 50, p1._owner, "Bomb")
						return
					end
					eventRemote:FireServer("x" .. ("mcv6ee23"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("dkwkvfcpa"):sub(5, 5):reverse() .. "1us6", var3 * 50, "Explode")
				end
			end
		end
	end
end
function t.SetOwner(p1, p2)
	p1._owner = p2
end
function t.Destroy(p1)
	if p1.Runtime then
		p1.Runtime:Disconnect()
		p1.Runtime = nil
	end
	p1.Model:Destroy()
end
local function DropBomb(p1, p2, p3, p4)
	local instance = t.new(p1, p2)
	instance:SetOwner(p4)
	instance:Animate(p3)
end
return {
	Init = function(p1)
		eventRemote = p1.Event
		table2 = require(ReplicatedStorage.Module.Time)
		instance = require(ReplicatedStorage.Std.Joint)
	end,
	DropBomb = DropBomb
}
