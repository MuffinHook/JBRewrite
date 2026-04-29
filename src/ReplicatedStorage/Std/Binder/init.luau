local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Maid = require(script.Parent.Maid)
local Signal = require(script.Parent.Signal)
local promiseBoundClass = require(script.promiseBoundClass)
local Binder = {}
Binder.__index = Binder
Binder.ClassName = "Binder"
function Binder.new(tagName, constructor, ...)
	local boundInstance = setmetatable({}, Binder)
	boundInstance._maid = Maid.new()
	boundInstance._tagName = tagName or error("Bad argument \'tagName\', expected string")
	boundInstance._constructor = constructor or error("Bad argument \'constructor\', expected table or function")
	boundInstance._instToClass = {}
	boundInstance._allClassSet = {}
	boundInstance._pendingInstSet = {}
	boundInstance._listeners = {}
	boundInstance._args = { ... }
	task.delay(5, function()
		if not boundInstance._loaded then
			warn(("Binder %q is not loaded. Call :Start() on it!"):format(boundInstance._tagName))
		end
	end)
	return boundInstance
end
function Binder.isBinder(self)
	return if type(self) == "table" then self.ClassName == "Binder" else false
end
local function setModelStreamingMode(instance)
	if not RunService:IsClient() and (instance:IsA("Model") and instance.ModelStreamingMode == Enum.ModelStreamingMode.Default) then
		instance.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	end
end
function Binder.Start(self)
	if not self._loaded then
		self._loaded = true
		for k, taggedInstance in pairs(CollectionService:GetTagged(self._tagName)) do
			if not RunService:IsClient() and (taggedInstance:IsA("Model") and taggedInstance.ModelStreamingMode == Enum.ModelStreamingMode.Default) then
				taggedInstance.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
			end
			task.spawn(self._add, self, taggedInstance)
		end
		self._maid:GiveTask(CollectionService:GetInstanceAddedSignal(self._tagName):Connect(function(addedInstance)
			if not RunService:IsClient() and (addedInstance:IsA("Model") and addedInstance.ModelStreamingMode == Enum.ModelStreamingMode.Default) then
				addedInstance.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
			end
			self:_add(addedInstance)
		end))
		self._maid:GiveTask(CollectionService:GetInstanceRemovedSignal(self._tagName):Connect(function(removedInstance)
			self:_remove(removedInstance)
		end))
	end
end
function Binder.GetTag(self)
	return self._tagName
end
function Binder.GetConstructor(self)
	return self._constructor
end
function Binder.ObserveInstance(self, instance, listener)
	self._listeners[instance] = self._listeners[instance] or {}
	self._listeners[instance][listener] = true
	return function()
		if self._listeners[instance] then
			self._listeners[instance][listener] = nil
			if not next(self._listeners[instance]) then
				self._listeners[instance] = nil
			end
		end
	end
end
function Binder.GetClassAddedSignal(self)
	if not self._classAddedSignal then
		self._classAddedSignal = Signal.new()
		self._maid:GiveTask(self._classAddedSignal)
	end
	return self._classAddedSignal
end
function Binder.GetClassRemovingSignal(self)
	if not self._classRemovingSignal then
		self._classRemovingSignal = Signal.new()
		self._maid:GiveTask(self._classRemovingSignal)
	end
	return self._classRemovingSignal
end
function Binder.GetAll(self)
	local resultTable = {}
	for boundClass, k in pairs(self._allClassSet) do
		resultTable[#resultTable + 1] = boundClass
	end
	return resultTable
end
function Binder.GetAllSet(self)
	return self._allClassSet
end
function Binder.Bind(self, instance)
	if RunService:IsClient() then
		warn(("[Binder.Bind] - Bindings \'%s\' done on the client! Will be disrupted upon server replication! %s"):format(self._tagName, debug.traceback()))
	end
	CollectionService:AddTag(instance, self._tagName)
	return self:Get(instance)
end
function Binder.Unbind(self, instance)
	assert(typeof(instance) == "Instance", "Bad inst\'")
	if RunService:IsClient() then
		warn(("[Binder.Bind] - Unbinding \'%s\' done on the client! Might be disrupted upon server replication! %s"):format(self._tagName, debug.traceback()))
	end
	CollectionService:RemoveTag(instance, self._tagName)
end
function Binder.BindClient(self, instance)
	if not RunService:IsClient() then
		warn(("[Binder.BindClient] - Bindings \'%s\' done on the server! Will be replicated!"):format(self._tagName))
	end
	CollectionService:AddTag(instance, self._tagName)
	return self:Get(instance)
end
function Binder.UnbindClient(self, instance)
	assert(typeof(instance) == "Instance", "Bad inst")
	CollectionService:RemoveTag(instance, self._tagName)
end
function Binder.Get(self, instance)
	assert(typeof(instance) == "Instance", "Argument \'inst\' is not an Instance")
	return self._instToClass[instance]
end
function Binder.Promise(self, instance)
	assert(typeof(instance) == "Instance", "Argument \'inst\' is not an Instance")
	return promiseBoundClass(self, instance)
end
function Binder._add(self, instance)
	assert(typeof(instance) == "Instance", "Argument \'inst\' is not an Instance")
	if not self._instToClass[instance] then
		if self._pendingInstSet[instance] == true then
			warn("[Binder._add] - Reentered add. Still loading, probably caused by error in constructor.")
			return
		end
		self._pendingInstSet[instance] = true
		local boundClass = if type(self._constructor) == "function" then self._constructor(instance, unpack(self._args)) elseif self._constructor.Create then self._constructor:Create(instance, unpack(self._args)) else self._constructor.new(instance, unpack(self._args))
		if self._pendingInstSet[instance] == true then
			self._pendingInstSet[instance] = nil
			if type(boundClass) == "table" and type(boundClass.Destroy) == "function" then
				assert(self._instToClass[instance] == nil, "Overwrote")
				self._allClassSet[boundClass] = true
				self._instToClass[instance] = boundClass
				local instanceListeners = self._listeners[instance]
				if instanceListeners then
					for listenerCallback, v in pairs(instanceListeners) do
						task.spawn(listenerCallback, boundClass)
					end
				end
				if self._classAddedSignal then
					self._classAddedSignal:Fire(boundClass, instance)
				end
			else
				warn(("[Binder._add] - Bad class constructed for tag %q"):format(self._tagName))
			end
		else
			warn(("[Binder._add] - Failed to load instance %q of %q, removed while loading!"):format(instance:GetFullName(), (tostring(type(self._constructor) == "table" and self._constructor.ClassName or self._constructor))))
		end
	end
end
function Binder._remove(self, instance)
	self._pendingInstSet[instance] = nil
	local boundClass = self._instToClass[instance]
	if boundClass == nil then
		return
	end
	if self._classRemovingSignal then
		self._classRemovingSignal:Fire(boundClass, instance)
	end
	self._instToClass[instance] = nil
	self._allClassSet[boundClass] = nil
	local instanceListeners = self._listeners[instance]
	if instanceListeners then
		for listenerCallback, v in pairs(instanceListeners) do
			task.spawn(listenerCallback, nil)
		end
	end
	if boundClass.Destroy then
		boundClass:Destroy()
	else
		local warnFunction = warn
		warnFunction(("[Binder._remove] - Class %q no longer has destroy, something destroyed it!"):format((tostring(self._tagName))))
	end
end
function Binder.Destroy(self)
	local instKey, nextClass = next(self._instToClass)
	while nextClass ~= nil do
		self:_remove(instKey)
		assert(self._instToClass[instKey] == nil, "Failed to remove")
		local nextKey, nextValue = next(self._instToClass)
		nextClass, instKey = nextValue, nextKey
	end
	self._maid:DoCleaning()
end
return Binder
