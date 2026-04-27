local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local VoltConsts = require(ReplicatedStorage.Volt.VoltConsts)
local VoltBinder = {}
VoltBinder.__index = VoltBinder
setmetatable(VoltBinder, BaseObject)
function VoltBinder.new(config)
	local instance = BaseObject.new(config)
	setmetatable(instance, VoltBinder)
	local Engine = instance.obj.Engine
	instance.maid:GiveTask(RunService.Heartbeat:Connect(function()
		local instance = Engine:FindFirstChild(VoltConsts.ENGINE_SOUND_NAME)
		local Magnitude = Engine.Velocity.Magnitude
		if instance then
			instance.PlaybackSpeed = (math.abs(Magnitude) + 5) / 150
		end
	end))
	return instance
end
return Binder.new(VoltConsts.TAG_NAME, VoltBinder)
