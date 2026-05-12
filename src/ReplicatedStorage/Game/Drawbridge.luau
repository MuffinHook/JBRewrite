local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
local Drawbridge = { Door0 = nil}
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
		local easedValue, fallbackProgress
		if progress < 0.5 then
			easedValue = 2 * progress * progress
			if not easedValue then
				fallbackProgress = progress
				easedValue = -1 - 2 * (progress - 2) * progress
			end
		else
			fallbackProgress = progress
			easedValue = -1 - 2 * (progress - 2) * progress
		end
		self.Angle = Angle * (1 - easedValue) + targetAngle * easedValue
		self.Model:PivotTo(self.HingeCF * CFrame.Angles(self.Angle, 0, 0))
	end)
end
local DrawbridgeModule = {
	_initSpawned = function(module)
		module.Model = workspace:WaitForChild("Drawbridge", 5)
		if module.Model == nil then
			if RunUtils.isMainWorld() and not RunService:IsStudio() then
				error("Missing `Drawbridge` in Workspace.")
			else
				return
			end
		end
		module.Door0 = Drawbridge.new(module.Model.Model.RoadA.Bridge, module.Model.Model.RoadA.Hinge)
	end
}
function DrawbridgeModule.Init(module)
	task.spawn(DrawbridgeModule._initSpawned, DrawbridgeModule)
	function module.em.toggleDrawbridge(open)
		if open then
			DrawbridgeModule.Open()
		else
			DrawbridgeModule.Close()
		end
	end
end
function DrawbridgeModule.Open()
	DrawbridgeModule.Door0:AnimateToAngle(0.9424777960769379, 10)
end
function DrawbridgeModule.Close()
	DrawbridgeModule.Door0:AnimateToAngle(0, 10)
end
return DrawbridgeModule
