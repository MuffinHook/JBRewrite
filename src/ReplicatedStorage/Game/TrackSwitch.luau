-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NetSync = require(ReplicatedStorage.Module.NetSync)
local Audio = require(ReplicatedStorage.Std.Audio)
local RunService = game:GetService("RunService")
local TrackSwitch = {}
TrackSwitch.__index = TrackSwitch
function TrackSwitch.new(p1, callback)
	local instance = setmetatable({}, TrackSwitch)
	local v3 = tick()
	local function Heartbeat(p1)
		local v1 = tick() - v3
		if v1 >= 1 then
			instance.Event:Disconnect()
			instance.Done = true
			v1 = 1
		end
		callback(v1, p1)
	end
	instance.Event = RunService.Heartbeat:Connect(Heartbeat)
	instance.Done = false
	return instance
end
function TrackSwitch.Destroy(p1)
	p1.Event:Disconnect()
	p1.Event = nil
	p1.Done = true
end
return {
	Init = function(p1)
		local _ = p1.Event
		local em = p1.em
		local v1 = nil
		local function Update(p1)
			if not p1.Tagged then
				return false
			end
			if p1.Type ~= "TrackSwitch" then
				return false
			end
			if v1 and not v1.Done then
				v1:Destroy()
			end
			local Inst = p1.Inst
			local Rail = Inst.Parent.Parent.Rail
			local Invert = Rail:FindFirstChild("Invert")
			local transparency = if p1.Flipped then 0 else 1
			Rail.Transparency = Invert and 1 - transparency or transparency
			local v3 = Inst.Parent
			v3.PrimaryPart = v3.Root
			local Root = v3.Parent.Model.Root
			v1 = TrackSwitch.new(0.5, function(progressFactor, p2)
				p1.Rot = if p1.Flipped then -0.9424777960769379 else 0 * progressFactor + (p1.Rot or 0) * (1 - progressFactor)
				v3:SetPrimaryPartCFrame(Root.CFrame * CFrame.Angles(0, 0, p1.Rot))
			end)
			Audio.ObjectLocal(Inst, 2803301098)
		end
		NetSync.Signals.InstAddedSignal:Connect(Update)
		NetSync.Signals.UpdatedSignal:Connect(Update)
	end
}
