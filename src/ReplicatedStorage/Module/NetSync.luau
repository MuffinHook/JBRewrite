local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local CollectionService = game:GetService("CollectionService")
local v1 = nil
local function GetById(p1) --[[ Line: 6 | Upvalues: v1 (ref) ]]
	for i = #v1, 1, -1 do
		if v1[i].Id == p1 then
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
local v3 = nil
local function NetSyncReplicateSingle(p1) --[[ Line: 22 | Upvalues: v1 (ref), t (copy), CollectionService (copy) ]]
	local v12 = p1
	local Id = v12.Id
	local v2 = false
	for i = #v1, 1, -1 do
		if v1[i].Id == Id then
			v2 = i
			break
		end
	end
	if v2 then
		v12 = v1[v2]
		for v3, v4 in next, p1 do
			if v3 ~= "Id" and (v3 ~= "Inst" and v3 ~= "Tagged") then
				v12[v3] = v4
			end
		end
		t.UpdatedSignal:Fire(v12)
	else
		v12.Inst = nil
		table.insert(v1, v12)
		t.AddedSignal:Fire(v12)
	end
	if v12.Tagged then
		local v6 = ("NetSync_%d"):format(v12.Id)
		if not v12.InstanceAddedSignal then
			v12.InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(v6)
			local function InstanceAdded(p1) --[[ Line: 44 | Upvalues: v12 (ref), t (ref) ]]
				v12.Inst = p1
				t.InstAddedSignal:Fire(v12)
			end
			v12.InstanceAddedSignal:Connect(InstanceAdded)
			local v7 = next
			local v8, v9 = CollectionService:GetTagged(v6)
			for v10, v11 in v7, v8, v9 do
				v12.Inst = v11
				t.InstAddedSignal:Fire(v12)
			end
		end
		if not v12.InstanceRemovedSignal then
			v12.InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(v6)
			v12.InstanceRemovedSignal:Connect(function() --[[ Line: 55 | Upvalues: t (ref), v12 (ref) ]]
				t.InstRemovedSignal:Fire(v12)
			end)
		end
	end
end
local function NetSyncReplicateDestroy(p1) --[[ Line: 61 | Upvalues: v1 (ref), t (copy) ]]
	assert(v1)
	local v2 = false
	for i = #v1, 1, -1 do
		if v1[i].Id == p1 then
			v2 = i
			break
		end
	end
	t.RemovedSignal:Fire((table.remove(v1, (assert(v2)))))
	return false
end
local function NetSyncReplicateAll(p1) --[[ Line: 68 | Upvalues: NetSyncReplicateSingle (copy) ]]
	for i = 1, #p1 do
		NetSyncReplicateSingle(p1[i])
	end
end
return {
	Init = function(p1) --[[ Name: Init | Line: 73 | Upvalues: v1 (ref), v2 (ref), v3 (ref), NetSyncReplicateSingle (copy), NetSyncReplicateDestroy (copy), NetSyncReplicateAll (copy) ]]
		v1 = {}
		local em = p1.em
		v2 = p1.Event
		v3 = em
		em.ybfjndtk = NetSyncReplicateSingle
		em.icqxr6a0 = NetSyncReplicateDestroy
		em.u8darxdf = NetSyncReplicateAll
	end,
	Signals = t
}