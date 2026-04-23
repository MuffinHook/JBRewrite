local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local t = {}
t.__index = t
function t.new() --[[ Line: 9 | Upvalues: t (copy), ReplicatedStorage (copy), Maid (copy), Signal (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	local v2 = ReplicatedStorage.Resource.Nuke:Clone()
	v2.PrimaryPart = v2.Base
	v2.Parent = workspace
	t2.Model = v2
	t2.Maid = Maid.new()
	t2.OnImpact = Signal.new()
	t2.Maid:GiveTask(t2.OnImpact)
	return t2
end
function t.Launch(p1, p2) --[[ Line: 27 | Upvalues: SimulatedPhysicsProjectile (copy) ]]
	assert(p2 ~= nil)
	assert(p2.Origin ~= nil)
	assert(p2.Target ~= nil)
	assert(p2.TimeDilation ~= nil)
	assert(p2.Speed ~= nil)
	p1.ProjPhysics = SimulatedPhysicsProjectile.new(p2.Origin)
	function p1.ProjPhysics._GetNow() --[[ Line: 35 | Upvalues: p2 (copy) ]]
		return tick() * p2.TimeDilation
	end
	p1.ProjPhysics.Birthdate = p1.ProjPhysics._GetNow()
	p1.ProjPhysics:HitTargetWithSpeed(p2.Target, p2.Speed, true)
	p1.BornAt = tick()
	p1:SetupRuntime()
end
function t.RenderStepped(p1) --[[ Line: 45 ]]
	local _PrevUpdatePosition = p1.ProjPhysics._PrevUpdatePosition
	local v1 = p1.ProjPhysics:GetElapsed()
	local v2 = p1.ProjPhysics:CalculateElapsedPosition(v1)
	p1.ProjPhysics._PrevUpdatePosition = v2
	p1.Model:SetPrimaryPartCFrame((CFrame.new(_PrevUpdatePosition, v2)))
	if p1.ProjPhysics.Duration < v1 then
		p1.OnImpact:Fire()
		p1:Destroy()
	end
end
function t.SetupRuntime(p1) --[[ Line: 59 | Upvalues: RunService (copy) ]]
	p1.LastHeartbeat = tick()
	p1.Maid:GiveTask(RunService.RenderStepped:Connect(function() --[[ Line: 61 | Upvalues: p1 (copy) ]]
		p1:RenderStepped()
	end))
end
function t.Destroy(p1) --[[ Line: 65 ]]
	p1.Model:Destroy()
	p1.Model = nil
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t