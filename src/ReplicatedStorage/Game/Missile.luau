-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = nil
local RayCast = require(ReplicatedStorage.Module.RayCast)
local v2 = nil
local function CalculateConstants(p1, p2, p3, p4, p5)
	local v1 = p4 or 0.25
	local v3 = p1 + p2 * v1 + Vector3.new(0, -98.10000000000001 * v1 * v1, 0)
	local Unit = (p3 - v3).Unit
	local _, v4 = RayCast.RayIgnoreNonCollideWithIgnoreList(v3, Unit, 999, p5 or {})
	local v5 = p2:Dot(Unit)
	return v3, v1, ((v5 * v5 + 3000 * (v4 - v3).Magnitude) ^ 0.5 - v5) / 1500, v4
end
local v3 = nil
local t = {}
t.__index = t
function t.new(p1, p2, p3, p4, p5, p6)
	local v2 = setmetatable({}, t)
	if not p4 then
		p4 = "RocketPart"
	end
	v2.Rotation = CFrame.Angles(0, 0, 0)
	if p4 == "RocketPart" then
		v2.Rotation = CFrame.Angles(0, math.pi, 0)
	end
	local v3 = ReplicatedStorage.Resource[p4]:Clone()
	v3.CanCollide = false
	v3.Anchored = true
	v3.Parent = workspace
	v3.CFrame = p1 * v2.Rotation
	v2.Part = v3
	v2.Origin = p1
	v2.OriginVelocity = p2
	v2.Target = p3
	v2.DropPeriod = p5
	v2.IgnoreList = p6
	return v2
end
function t.Animate(p1, p2)
	local v22 = p2 or v2.GetNowSync()
	local OriginVelocity = p1.OriginVelocity
	local LookVector = (p1.Origin * p1.Rotation).LookVector
	local v32, v4, v5, _ = CalculateConstants(p1.Origin.p, OriginVelocity, p1.Target, p1.DropPeriod, p1.IgnoreList)
	local Unit = (p1.Target - v32).Unit
	local v6 = OriginVelocity:Dot(Unit)
	local v7 = v22 - 0.03333333333333333
	local function Ignite()
		p1.Part.Fire.Enabled = true
		v1.ObjectLocal(p1.Part, 1386598740, {
			TimePosition = 0.5,
			Volume = 0.5
		})
		v1.ObjectLocal(p1.Part, 9058734199, {
			Volume = 0.6,
			Pitch = 0.6,
			EmitterSize = 25
		})
	end
	local function Heartbeat()
		local v1 = v2.GetNowSync()
		local v23 = v1 - v22
		local v33 = v1 - v7
		v7 = v1
		if v23 - v33 < v4 and v4 <= v23 then
			Ignite()
		end
		if v23 - v33 < v4 + v5 and v4 + v5 <= v23 then
			p1:Explode()
		end
		if v23 < v4 then
			p1.Part.CFrame = p1.Origin * p1.Rotation + OriginVelocity * v23 + Vector3.new(0, -98.10000000000001 * v23 * v23, 0)
		elseif v23 < v4 + v5 then
			local v42 = v23 - v4
			p1.Part.CFrame = CFrame.new(v3, (LookVector:Lerp(Unit, (math.min(v42 * 10, 1))))) + v32 + v6 * Unit * v42 + Unit * (750 * v42 * v42)
		end
	end
	p1.Runtime = RunService.Heartbeat:Connect(Heartbeat)
end
function t.Explode(p1)
	delay(2, function()
		p1:Destroy()
	end)
	p1.Part.Transparency = 1
	p1.Part.CanCollide = false
	p1.Part.Fire.Enabled = false
	local Explosion = Instance.new("Explosion")
	Explosion.ExplosionType = Enum.ExplosionType.NoCraters
	Explosion.DestroyJointRadiusPercent = 0
	Explosion.Position = p1.Part.Position
	Explosion.Parent = workspace
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://55224766"
	Sound.Parent = p1.Part
	Sound.Volume = 0.8
	Sound:Play()
end
function t.Destroy(p1)
	p1.Part:Destroy()
	p1.Part = nil
	p1.Runtime:Disconnect()
	p1.Runtime = nil
end
return {
	CalculateConstants = CalculateConstants,
	LaunchMissile = function(p1, p2, p3, p4, p5, p6, p7)
		t.new(p1, p2, p3, p5, p6, p7):Animate(p4)
	end,
	Init = function()
		v3 = Vector3.new()
		v1 = require(ReplicatedStorage.Std.Audio)
		v2 = require(ReplicatedStorage.Module.Time)
	end
}
