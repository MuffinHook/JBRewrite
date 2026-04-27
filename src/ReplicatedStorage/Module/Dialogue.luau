local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local Timeline = require(ReplicatedStorage.Module.Timeline)
local DialogueModule = {}
DialogueModule.__index = DialogueModule
function DialogueModule.new()
	local self = {}
	setmetatable(self, DialogueModule)
	self.Maid = Maid.new()
	self.OnMessage = Signal.new()
	self.ListEventUnconnected = {}
	self.MapEventSignal = {}
	self.Speed = 1
	return self
end
function DialogueModule.Run(dialogue)
	local instance = Timeline.new(dialogue.Seqs)
	if not dialogue.BornAt then
		dialogue.BornAt = workspace:GetServerTimeNow()
	end
	local lastHeartbeatTime = 0
	dialogue.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local currentTime = workspace:GetServerTimeNow()
		if currentTime - lastHeartbeatTime > 0.5 then
			lastHeartbeatTime = currentTime
			if instance:Update(dialogue.Speed * (currentTime - dialogue.BornAt)) then
				instance = nil
				dialogue:Destroy()
			end
		end
	end))
end
function DialogueModule.SetBornAt(dialogue, timestamp)
	dialogue.BornAt = timestamp
end
function DialogueModule.SetSpeed(dialogue, speed)
	dialogue.Speed = speed
end
function DialogueModule.LoadData(dialogue, data)
	assert(dialogue.Data == nil)
	dialogue.Data = data
	local sequences = {}
	for i, messageData in ipairs(data) do
		local hasDuration
		hasDuration = messageData.Duration ~= nil
		assert(hasDuration)
		table.insert(sequences, { function(progress)
				if progress == 0 then
					dialogue.OnMessage:Fire(messageData)
					if messageData.Events ~= nil then
						for i, eventName in ipairs(messageData.Events) do
							if dialogue.MapEventSignal[eventName] == nil then
								error(("Missing signal for event: %s"):format(eventName))
							end
							dialogue.MapEventSignal[eventName]:Fire(messageData)
						end
					end
				end
			end, messageData.Duration })
		if messageData.Events ~= nil then
			for eventIndex, eventName in ipairs(messageData.Events) do
				if dialogue.MapEventSignal[eventName] ~= nil then
					error(("There already exists an event named: %s"):format(eventName))
				end
				local eventSignal = Signal.new()
				dialogue.MapEventSignal[eventName] = eventSignal
				dialogue.Maid:GiveTask(eventSignal)
				table.insert(dialogue.ListEventUnconnected, eventName)
			end
		end
	end
	dialogue.Seqs = sequences
end
function DialogueModule.Connect(dialogue, eventName, callback)
	for i = #dialogue.ListEventUnconnected, 1, -1 do
		if dialogue.ListEventUnconnected[i] == eventName then
			table.remove(dialogue.ListEventUnconnected, i)
			break
		end
	end
	if dialogue.MapEventSignal[eventName] == nil then
		error(("No signal exists for event: %s"):format(eventName))
	end
	dialogue.MapEventSignal[eventName]:Connect(callback)
end
function DialogueModule.VerifyAllConnected(dialogue)
	if #dialogue.ListEventUnconnected > 0 then
		error(("Not all events are unconnected... remaining: %s"):format(table.concat(dialogue.ListEventUnconnected, ", ")))
	end
end
function DialogueModule.Destroy(dialogue)
	dialogue.MapEventSignal = nil
	dialogue.Maid:Destroy()
	dialogue.Maid = nil
	setmetatable(dialogue, nil)
end
return DialogueModule
