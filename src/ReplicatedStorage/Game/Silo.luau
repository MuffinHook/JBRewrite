local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Anim = require(ReplicatedStorage.Module.Anim)
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
local Silo = {}
Silo.__index = Silo
function Silo.new(model)
	assert(model ~= nil)
	local instance = {}
	setmetatable(instance, Silo)
	instance.Model = model
	instance.Door1CF = instance.Model.Door1.CFrame
	instance.Door2CF = instance.Model.Door2.CFrame
	instance.OnOpened = Signal.new()
	instance.Anim = nil
	instance.IsOpen = false
	return instance
end
function Silo.Transition(self, duration, updateCallback)
	if self.Anim ~= nil then
		self.Anim:Destroy()
	end
	self.Anim = Anim.new(duration or 6)
	self.Anim.OnCompleted:Connect(function()
		self.Anim:Destroy()
		self.Anim = nil
	end)
	self.Anim.OnCanceled:Connect(function()
		self.Anim:Destroy()
		self.Anim = nil
	end)
	self.Anim.Maid:GiveTask(RunService.RenderStepped:Connect(function()
		updateCallback(self, (self.Anim:Update()))
	end))
end
function Silo.Open(self, duration)
	self.IsOpen = true
	return self:Transition(duration, self.SeqOpen)
end
function Silo.Close(self, duration)
	self.IsOpen = false
	return self:Transition(duration, self.SeqClose)
end
function Silo.SetDoorOpen(self, openAmount)
	local Model = self.Model
	local Door1 = Model.Door1
	local pivotOffset1 = CFrame.new(0, 0, -Door1.Size.Z * 0.5)
	Door1.CFrame = self.Door1CF * pivotOffset1 * CFrame.Angles(openAmount * math.pi * 0.5, 0, 0) * pivotOffset1:Inverse()
	local Door2 = Model.Door2
	local pivotOffset2 = CFrame.new(0, 0, -Door2.Size.Z * 0.5)
	Door2.CFrame = self.Door2CF * pivotOffset2 * CFrame.Angles(openAmount * math.pi * 0.5, 0, 0) * pivotOffset2:Inverse()
end
function Silo.SeqOpen(self, progress)
	if progress == 1 then
		self.OnOpened:Fire()
	end
	local easedProgress, progressValue
	if progress < 0.5 then
		easedProgress = 2 * progress * progress
		if not easedProgress then
			progressValue = progress
			easedProgress = -1 - 2 * (progress - 2) * progress
		end
	else
		progressValue = progress
		easedProgress = -1 - 2 * (progress - 2) * progress
	end
	self:SetDoorOpen(easedProgress)
end
function Silo.SeqClose(self, progress)
	local invertedProgress = 1 - progress
	self:SetDoorOpen(invertedProgress < 0.5 and 2 * invertedProgress * invertedProgress or -1 - 2 * (invertedProgress - 2) * invertedProgress)
end
function Silo.Destroy(self)
	if self.Anim ~= nil then
		self.Anim:Destroy()
		self.Anim = nil
	end
	self.OnOpened:Destroy()
	self.OnOpened = nil
end
return Silo
