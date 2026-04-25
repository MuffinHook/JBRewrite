-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local t = {}
t.__index = t
function t.new()
	local nukeInstance = {}
	setmetatable(nukeInstance, t)
	local nukeModel = ReplicatedStorage.Resource.Nuke:Clone()
	nukeModel.PrimaryPart = nukeModel.Base
	nukeModel.Parent = workspace
	nukeInstance.Model = nukeModel
	nukeInstance.Maid = Maid.new()
	nukeInstance.OnImpact = Signal.new()
	nukeInstance.Maid:GiveTask(nukeInstance.OnImpact)
	return nukeInstance
end
function t.Launch(p1, p2)
	assert(p2 ~= nil)
	assert(p2.Origin ~= nil)
	assert(p2.Target ~= nil)
	assert(p2.TimeDilation ~= nil)
	assert(p2.Speed ~= nil)
	p1.ProjPhysics = SimulatedPhysicsProjectile.new(p2.Origin)
	function p1.ProjPhysics._GetNow()
		return tick() * p2.TimeDilation
	end
	p1.ProjPhysics.Birthdate = p1.ProjPhysics._GetNow()
	p1.ProjPhysics:HitTargetWithSpeed(p2.Target, p2.Speed, true)
	p1.BornAt = tick()
	p1:SetupRuntime()
end
function t.RenderStepped(p1)
	local _PrevUpdatePosition = p1.ProjPhysics._PrevUpdatePosition
	local elapsedTime = p1.ProjPhysics:GetElapsed()
	local newPosition = p1.ProjPhysics:CalculateElapsedPosition(elapsedTime)
	p1.ProjPhysics._PrevUpdatePosition = newPosition
	p1.Model:SetPrimaryPartCFrame((CFrame.new(_PrevUpdatePosition, newPosition)))
	if p1.ProjPhysics.Duration < elapsedTime then
		p1.OnImpact:Fire()
		p1:Destroy()
	end
end
function t.SetupRuntime(p1)
	p1.LastHeartbeat = tick()
	p1.Maid:GiveTask(RunService.RenderStepped:Connect(function()
		p1:RenderStepped()
	end))
end
function t.Destroy(p1)
	p1.Model:Destroy()
	p1.Model = nil
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t
