local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NetSync = require(ReplicatedStorage.Module.NetSync)
local Audio = require(ReplicatedStorage.Std.Audio)
local RunService = game:GetService("RunService")
local TrackSwitch = {}
TrackSwitch.__index = TrackSwitch
function TrackSwitch.new(duration, callback)
	local instance = setmetatable({}, TrackSwitch)
	local startTime = tick()
	local function Heartbeat(deltaTime)
		local elapsedTime = tick() - startTime
		if elapsedTime >= 1 then
			instance.Event:Disconnect()
			instance.Done = true
			elapsedTime = 1
		end
		callback(elapsedTime, deltaTime)
	end
	instance.Event = RunService.Heartbeat:Connect(Heartbeat)
	instance.Done = false
	return instance
end
function TrackSwitch.Destroy(self)
	self.Event:Disconnect()
	self.Event = nil
	self.Done = true
end
return {
	Init = function(eventManager)
		local _ = eventManager.Event
		local em = eventManager.em
		local trackSwitchInstance = nil
		local function Update(trackData)
			if not trackData.Tagged then
				return false
			end
			if trackData.Type ~= "TrackSwitch" then
				return false
			end
			if trackSwitchInstance and not trackSwitchInstance.Done then
				trackSwitchInstance:Destroy()
			end
			local Inst = trackData.Inst
			local Rail = Inst.Parent.Parent.Rail
			local Invert = Rail:FindFirstChild("Invert")
			local transparency = if trackData.Flipped then 0 else 1
			Rail.Transparency = Invert and 1 - transparency or transparency
			local parentModel = Inst.Parent
			parentModel.PrimaryPart = parentModel.Root
			local Root = parentModel.Parent.Model.Root
			trackSwitchInstance = TrackSwitch.new(0.5, function(progressFactor, deltaTime)
				trackData.Rot = if trackData.Flipped then -0.9424777960769379 else 0 * progressFactor + (trackData.Rot or 0) * (1 - progressFactor)
				parentModel:SetPrimaryPartCFrame(Root.CFrame * CFrame.Angles(0, 0, trackData.Rot))
			end)
			Audio.ObjectLocal(Inst, 2803301098)
		end
		NetSync.Signals.InstAddedSignal:Connect(Update)
		NetSync.Signals.UpdatedSignal:Connect(Update)
	end
}
