local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local CollectionService = game:GetService("CollectionService")
local data = nil
local function GetById(searchId)
	for i = #data, 1, -1 do
		if data[i].Id == searchId then
			return i
		end
	end
	return false
end
local module = {
	InstAddedSignal = Signal.new(),
	InstRemovedSignal = Signal.new(),
	AddedSignal = Signal.new(),
	RemovedSignal = Signal.new(),
	UpdatedSignal = Signal.new()
}
local eventManager = nil
local eventManagerRef = nil
local function NetSyncReplicateSingle(itemData)
	local currentItem = itemData
	local Id = currentItem.Id
	local foundIndex = false
	for i = #data, 1, -1 do
		if data[i].Id == Id then
			foundIndex = i
			break
		end
	end
	if foundIndex then
		currentItem = data[foundIndex]
		for fieldName, fieldValue in next, itemData do
			if fieldName ~= "Id" and (fieldName ~= "Inst" and fieldName ~= "Tagged") then
				currentItem[fieldName] = fieldValue
			end
		end
		module.UpdatedSignal:Fire(currentItem)
	else
		currentItem.Inst = nil
		table.insert(data, currentItem)
		module.AddedSignal:Fire(currentItem)
	end
	if currentItem.Tagged then
		local tagLabel = ("NetSync_%d"):format(currentItem.Id)
		if not currentItem.InstanceAddedSignal then
			currentItem.InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(tagLabel)
			local function InstanceAdded(instance)
				currentItem.Inst = instance
				module.InstAddedSignal:Fire(currentItem)
			end
			currentItem.InstanceAddedSignal:Connect(InstanceAdded)
			local nextFunction = next
			local instances, endIndex = CollectionService:GetTagged(tagLabel)
			for instanceKey, instance in nextFunction, instances, endIndex do
				currentItem.Inst = instance
				module.InstAddedSignal:Fire(currentItem)
			end
		end
		if not currentItem.InstanceRemovedSignal then
			currentItem.InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(tagLabel)
			currentItem.InstanceRemovedSignal:Connect(function()
				module.InstRemovedSignal:Fire(currentItem)
			end)
		end
	end
end
local function NetSyncReplicateDestroy(itemId)
	assert(data)
	local foundIndex = false
	for i = #data, 1, -1 do
		if data[i].Id == itemId then
			foundIndex = i
			break
		end
	end
	module.RemovedSignal:Fire((table.remove(data, (assert(foundIndex)))))
	return false
end
local function NetSyncReplicateAll(itemsList)
	for i = 1, #itemsList do
		NetSyncReplicateSingle(itemsList[i])
	end
end
return {
	Init = function(config)
		data = {}
		local em = config.em
		eventManager = config.Event
		eventManagerRef = em
		em.ybfjndtk = NetSyncReplicateSingle
		em.icqxr6a0 = NetSyncReplicateDestroy
		em.u8darxdf = NetSyncReplicateAll
	end,
	Signals = module
}
