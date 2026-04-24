-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local CollectionService = game:GetService("CollectionService")
local data = nil
local function GetById(p1)
	for i = #data, 1, -1 do
		if data[i].Id == p1 then
			return i
		end
	end
	return false
end
local t = {
	InstAddedSignal = Signal.new(),
	InstRemovedSignal = Signal.new(),
	AddedSignal = Signal.new(),
	RemovedSignal = Signal.new(),
	UpdatedSignal = Signal.new()
}
local v2 = nil
local var3 = nil
local function NetSyncReplicateSingle(p1)
	local var12 = p1
	local Id = var12.Id
	local v2 = false
	for i = #data, 1, -1 do
		if data[i].Id == Id then
			v2 = i
			break
		end
	end
	if v2 then
		var12 = data[v2]
		for var3, v4 in next, p1 do
			if var3 ~= "Id" and (var3 ~= "Inst" and var3 ~= "Tagged") then
				var12[var3] = v4
			end
		end
		t.UpdatedSignal:Fire(var12)
	else
		var12.Inst = nil
		table.insert(data, var12)
		t.AddedSignal:Fire(var12)
	end
	if var12.Tagged then
		local var6 = ("NetSync_%d"):format(var12.Id)
		if not var12.InstanceAddedSignal then
			var12.InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(var6)
			local function InstanceAdded(p1)
				var12.Inst = p1
				t.InstAddedSignal:Fire(var12)
			end
			var12.InstanceAddedSignal:Connect(InstanceAdded)
			local var7 = next
			local v8, v9 = CollectionService:GetTagged(var6)
			for v10, v11 in var7, v8, v9 do
				var12.Inst = v11
				t.InstAddedSignal:Fire(var12)
			end
		end
		if not var12.InstanceRemovedSignal then
			var12.InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(var6)
			var12.InstanceRemovedSignal:Connect(function()
				t.InstRemovedSignal:Fire(var12)
			end)
		end
	end
end
local function NetSyncReplicateDestroy(p1)
	assert(data)
	local v2 = false
	for i = #data, 1, -1 do
		if data[i].Id == p1 then
			v2 = i
			break
		end
	end
	t.RemovedSignal:Fire((table.remove(data, (assert(v2)))))
	return false
end
local function NetSyncReplicateAll(p1)
	for i = 1, #p1 do
		NetSyncReplicateSingle(p1[i])
	end
end
return {
	Init = function(p1)
		data = {}
		local em = p1.em
		v2 = p1.Event
		var3 = em
		em.ybfjndtk = NetSyncReplicateSingle
		em.icqxr6a0 = NetSyncReplicateDestroy
		em.u8darxdf = NetSyncReplicateAll
	end,
	Signals = t
}
