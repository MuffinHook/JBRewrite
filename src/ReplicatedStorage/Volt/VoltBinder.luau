-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local VoltConsts = require(ReplicatedStorage.Volt.VoltConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local Engine = v1.obj.Engine
	v1.maid:GiveTask(RunService.Heartbeat:Connect(function()
		local v1 = Engine:FindFirstChild(VoltConsts.ENGINE_SOUND_NAME)
		local Magnitude = Engine.Velocity.Magnitude
		if v1 then
			v1.PlaybackSpeed = (math.abs(Magnitude) + 5) / 150
		end
	end))
	return v1
end
return Binder.new(VoltConsts.TAG_NAME, t)
