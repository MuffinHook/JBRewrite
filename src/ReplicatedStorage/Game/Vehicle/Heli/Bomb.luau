local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local v1 = nil
local v2 = nil
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 10 | Upvalues: t (copy), ReplicatedStorage (copy), v1 (ref) ]]
	local v2 = setmetatable({}, t)
	v2.p0 = p1
	v2.v0 = p2
	local v3 = ReplicatedStorage.Resource.HeliBomb:Clone()
	v1.WeldAllTo(v3, v3.Rocket)
	v3.Rocket.Anchored = true
	v3.Rocket.CFrame = p1
	v3.Parent = workspace
	v2.Model = v3
	return v2
end
local v3 = Vector3.new()
local v4 = CFrame.Angles(0, math.pi, 0)
function t.Animate(p1, p2) --[[ Line: 29 | Upvalues: v2 (ref), v3 (copy), v4 (copy), RayCast (copy), RunService (copy) ]]
	local v22 = p2 or v2.GetNowSync()
	local v32 = v22
	local function Heartbeat() --[[ Line: 37 | Upvalues: v2 (ref), v22 (ref), v32 (ref), p1 (copy), v3 (ref), v4 (ref), RayCast (ref) ]]
		local v1 = v2.GetNowSync()
		local v23 = v1 - v22
		local v33 = v1 - v32
		v32 = v1
		local v42 = p1.v0 * v23 + Vector3.new(0, -98.10000000000001 * v23 * v23, 0)
		p1.Model.Rocket.CFrame = CFrame.new(v3, (p1.p0.LookVector:Lerp(Vector3.new(0, -1, 0), (math.min(1, v23 * 1.3333333333333333))))) * v4 + p1.p0.p + v42
		if v23 - v33 < 0.3 and v23 > 0.3 then
			p1.Model.Fire.Particle.Enabled = true
		end
		if v23 > 0.3 then
			local v8, v9 = RayCast.RayIgnoreNonCollide(p1.p0.p + v42, Vector3.new(0, -1, 0), math.abs(p1.v0.Y + -196.20000000000002 * v23) * v33, p1.Model)
			if v8 then
				p1:Explode(v9)
			end
		end
		if v23 > 5 and not p1.Exploded then
			p1:Destroy()
		end
	end
	p1.Runtime = RunService.Heartbeat:Connect(Heartbeat)
end
local v5 = nil
function t.Explode(p1, p2) --[[ Line: 68 | Upvalues: Players (copy), v5 (ref) ]]
	p1.Exploded = true
	delay(2, function() --[[ Line: 70 | Upvalues: p1 (copy) ]]
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
				local v1 = RootPart.Position - p2
				local v3 = math.max(24 - v1.Magnitude, 0) / 24
				if v3 > 0.001 then
					RootPart.Velocity = RootPart.Velocity + v1.Unit * v3 * 30
					if p1._owner then
						print(p1._owner)
						v5:FireServer("x" .. ("oo9w30"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "41csnt", v3 * 50, p1._owner, "Bomb")
						return
					end
					v5:FireServer("x" .. ("mcv6ee23"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("dkwkvfcpa"):sub(5, 5):reverse() .. "1us6", v3 * 50, "Explode")
				end
			end
		end
	end
end
function t.SetOwner(p1, p2) --[[ Line: 115 ]]
	p1._owner = p2
end
function t.Destroy(p1) --[[ Line: 118 ]]
	if p1.Runtime then
		p1.Runtime:Disconnect()
		p1.Runtime = nil
	end
	p1.Model:Destroy()
end
local function DropBomb(p1, p2, p3, p4) --[[ Line: 126 | Upvalues: t (copy) ]]
	local v1 = t.new(p1, p2)
	v1:SetOwner(p4)
	v1:Animate(p3)
end
return {
	Init = function(p1) --[[ Name: Init | Line: 131 | Upvalues: v5 (ref), v2 (ref), ReplicatedStorage (copy), v1 (ref) ]]
		v5 = p1.Event
		v2 = require(ReplicatedStorage.Module.Time)
		v1 = require(ReplicatedStorage.Std.Joint)
	end,
	DropBomb = DropBomb
}