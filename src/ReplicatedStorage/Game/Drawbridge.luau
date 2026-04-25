-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
local Drawbridge = {}
Drawbridge.__index = Drawbridge
function Drawbridge.new(model, hinge)
	assert(model ~= nil)
	assert(hinge ~= nil)
	local instance = {}
	setmetatable(instance, Drawbridge)
	instance.HingeCF = hinge.CFrame
	instance.Model = model
	instance.Model.PrimaryPart = hinge
	instance.Event = nil
	instance.Angle = 0
	return instance
end
function Drawbridge.AnimateToAngle(self, targetAngle, duration)
	assert(targetAngle ~= nil)
	assert(duration ~= nil)
	if self.Event ~= nil then
		self.Event:Disconnect()
		self.Event = nil
	end
	local Angle = self.Angle
	local startTime = tick()
	self.Event = RunService.Heartbeat:Connect(function()
		local progress = (tick() - startTime) / duration
		if progress > 1 then
			self.Event:Disconnect()
			self.Event = nil
			progress = 1
		end
		local easedValue, v32
		if progress < 0.5 then
			easedValue = 2 * progress * progress
			if not easedValue then
				v32 = progress
				easedValue = -1 - 2 * (progress - 2) * progress
			end
		else
			v32 = progress
			easedValue = -1 - 2 * (progress - 2) * progress
		end
		self.Angle = Angle * (1 - easedValue) + targetAngle * easedValue
		self.Model:PivotTo(self.HingeCF * CFrame.Angles(self.Angle, 0, 0))
	end)
end
local t2 = {
	_initSpawned = function(p1)
		p1.Model = workspace:WaitForChild("Drawbridge", 5)
		if p1.Model == nil then
			if RunUtils.isMainWorld() and not RunService:IsStudio() then
				error("Missing `Drawbridge` in Workspace.")
			else
				return
			end
		end
		p1.Door0 = Drawbridge.new(p1.Model.Model.RoadA.Bridge, p1.Model.Model.RoadA.Hinge)
	end
}
function t2.Init(p1)
	task.spawn(t2._initSpawned, t2)
	function p1.em.fbs2dwjk(p1)
		if p1 then
			t2.Open()
		else
			t2.Close()
		end
	end
end
function t2.Open()
	t2.Door0:AnimateToAngle(0.9424777960769379, 10)
end
function t2.Close()
	t2.Door0:AnimateToAngle(0, 10)
end
return t2
