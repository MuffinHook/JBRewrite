local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local Nuke = {}
Nuke.__index = Nuke
function Nuke.new()
	local nukeInstance = {}
	setmetatable(nukeInstance, Nuke)
	local nukeModel = ReplicatedStorage.Resource.Nuke:Clone()
	nukeModel.PrimaryPart = nukeModel.Base
	nukeModel.Parent = workspace
	nukeInstance.Model = nukeModel
	nukeInstance.Maid = Maid.new()
	nukeInstance.OnImpact = Signal.new()
	nukeInstance.Maid:GiveTask(nukeInstance.OnImpact)
	return nukeInstance
end
function Nuke.Launch(self, launchConfig)
	assert(launchConfig ~= nil)
	assert(launchConfig.Origin ~= nil)
	assert(launchConfig.Target ~= nil)
	assert(launchConfig.TimeDilation ~= nil)
	assert(launchConfig.Speed ~= nil)
	self.ProjPhysics = SimulatedPhysicsProjectile.new(launchConfig.Origin)
	function self.ProjPhysics._GetNow()
		return tick() * launchConfig.TimeDilation
	end
	self.ProjPhysics.Birthdate = self.ProjPhysics._GetNow()
	self.ProjPhysics:HitTargetWithSpeed(launchConfig.Target, launchConfig.Speed, true)
	self.BornAt = tick()
	self:SetupRuntime()
end
function Nuke.RenderStepped(self)
	local _PrevUpdatePosition = self.ProjPhysics._PrevUpdatePosition
	local elapsedTime = self.ProjPhysics:GetElapsed()
	local newPosition = self.ProjPhysics:CalculateElapsedPosition(elapsedTime)
	self.ProjPhysics._PrevUpdatePosition = newPosition
	self.Model:SetPrimaryPartCFrame((CFrame.new(_PrevUpdatePosition, newPosition)))
	if self.ProjPhysics.Duration < elapsedTime then
		self.OnImpact:Fire()
		self:Destroy()
	end
end
function Nuke.SetupRuntime(self)
	self.LastHeartbeat = tick()
	self.Maid:GiveTask(RunService.RenderStepped:Connect(function()
		self:RenderStepped()
	end))
end
function Nuke.Destroy(self)
	self.Model:Destroy()
	self.Model = nil
	self.Maid:Destroy()
	self.Maid = nil
end
return Nuke
