local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local Timeline = require(ReplicatedStorage.Module.Timeline)
local t = {}
t.__index = t
function t.new() --[[ Line: 9 | Upvalues: t (copy), Maid (copy), Signal (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2.Maid = Maid.new()
	t2.OnMessage = Signal.new()
	t2.ListEventUnconnected = {}
	t2.MapEventSignal = {}
	t2.Speed = 1
	return t2
end
function t.Run(p1) --[[ Line: 23 | Upvalues: Timeline (copy), RunService (copy) ]]
	local v1 = Timeline.new(p1.Seqs)
	if not p1.BornAt then
		p1.BornAt = workspace:GetServerTimeNow()
	end
	local v2 = 0
	p1.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 30 | Upvalues: v2 (ref), v1 (ref), p1 (copy) ]]
		local v12 = workspace:GetServerTimeNow()
		if v12 - v2 > 0.5 then
			v2 = v12
			if v1:Update(p1.Speed * (v12 - p1.BornAt)) then
				v1 = nil
				p1:Destroy()
			end
		end
	end))
end
function t.SetBornAt(p1, p2) --[[ Line: 43 ]]
	p1.BornAt = p2
end
function t.SetSpeed(p1, p2) --[[ Line: 46 ]]
	p1.Speed = p2
end
function t.LoadData(p1, p2) --[[ Line: 49 | Upvalues: Signal (copy) ]]
	assert(p1.Data == nil)
	p1.Data = p2
	local t = {}
	for i, v in ipairs(p2) do
		local v2
		v2 = v.Duration ~= nil
		assert(v2)
		table.insert(t, { function(p12) --[[ Name: Callback | Line: 55 | Upvalues: p1 (copy), v (copy) ]]
				if p12 == 0 then
					p1.OnMessage:Fire(v)
					if v.Events ~= nil then
						for i, v2 in ipairs(v.Events) do
							if p1.MapEventSignal[v2] == nil then
								error(("Missing signal for event: %s"):format(v2))
							end
							p1.MapEventSignal[v2]:Fire(v)
						end
					end
				end
			end, v.Duration })
		if v.Events ~= nil then
			for i2, v3 in ipairs(v.Events) do
				if p1.MapEventSignal[v3] ~= nil then
					error(("There already exists an event named: %s"):format(v3))
				end
				local v32 = Signal.new()
				p1.MapEventSignal[v3] = v32
				p1.Maid:GiveTask(v32)
				table.insert(p1.ListEventUnconnected, v3)
			end
		end
	end
	p1.Seqs = t
end
function t.Connect(p1, p2, p3) --[[ Line: 87 ]]
	for i = #p1.ListEventUnconnected, 1, -1 do
		if p1.ListEventUnconnected[i] == p2 then
			table.remove(p1.ListEventUnconnected, i)
			break
		end
	end
	if p1.MapEventSignal[p2] == nil then
		error(("No signal exists for event: %s"):format(p2))
	end
	p1.MapEventSignal[p2]:Connect(p3)
end
function t.VerifyAllConnected(p1) --[[ Line: 99 ]]
	if #p1.ListEventUnconnected > 0 then
		error(("Not all events are unconnected... remaining: %s"):format(table.concat(p1.ListEventUnconnected, ", ")))
	end
end
function t.Destroy(p1) --[[ Line: 104 ]]
	p1.MapEventSignal = nil
	p1.Maid:Destroy()
	p1.Maid = nil
	setmetatable(p1, nil)
end
return t