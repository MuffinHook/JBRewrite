local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Maid = require(script.Parent.Maid)
local Signal = require(script.Parent.Signal)
local promiseBoundClass = require(script.promiseBoundClass)
local t = {}
t.__index = t
t.ClassName = "Binder"
function t.new(p1, p2, ...) --[[ Line: 43 | Upvalues: t (copy), Maid (copy) ]]
	local v2 = setmetatable({}, t)
	v2._maid = Maid.new()
	v2._tagName = p1 or error("Bad argument \'tagName\', expected string")
	v2._constructor = p2 or error("Bad argument \'constructor\', expected table or function")
	v2._instToClass = {}
	v2._allClassSet = {}
	v2._pendingInstSet = {}
	v2._listeners = {}
	v2._args = { ... }
	delay(5, function() --[[ Line: 57 | Upvalues: v2 (copy) ]]
		if not v2._loaded then
			warn(("Binder %q is not loaded. Call :Start() on it!"):format(v2._tagName))
		end
	end)
	return v2
end
function t.isBinder(p1) --[[ Line: 69 ]]
	return if type(p1) == "table" then p1.ClassName == "Binder" else false
end
local function setModelStreamingMode(p1) --[[ Line: 73 | Upvalues: RunService (copy) ]]
	if not RunService:IsClient() and (p1:IsA("Model") and p1.ModelStreamingMode == Enum.ModelStreamingMode.Default) then
		p1.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	end
end
function t.Start(p1) --[[ Line: 85 | Upvalues: CollectionService (copy), RunService (copy) ]]
	if not p1._loaded then
		p1._loaded = true
		for k, v in pairs(CollectionService:GetTagged(p1._tagName)) do
			if not RunService:IsClient() and (v:IsA("Model") and v.ModelStreamingMode == Enum.ModelStreamingMode.Default) then
				v.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
			end
			task.spawn(p1._add, p1, v)
		end
		p1._maid:GiveTask(CollectionService:GetInstanceAddedSignal(p1._tagName):Connect(function(p12) --[[ Line: 96 | Upvalues: RunService (ref), p1 (copy) ]]
			if not RunService:IsClient() and (p12:IsA("Model") and p12.ModelStreamingMode == Enum.ModelStreamingMode.Default) then
				p12.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
			end
			p1:_add(p12)
		end))
		p1._maid:GiveTask(CollectionService:GetInstanceRemovedSignal(p1._tagName):Connect(function(p12) --[[ Line: 100 | Upvalues: p1 (copy) ]]
			p1:_remove(p12)
		end))
	end
end
function t.GetTag(p1) --[[ Line: 106 ]]
	return p1._tagName
end
function t.GetConstructor(p1) --[[ Line: 111 ]]
	return p1._constructor
end
function t.ObserveInstance(p1, p2, p3) --[[ Line: 116 ]]
	p1._listeners[p2] = p1._listeners[p2] or {}
	p1._listeners[p2][p3] = true
	return function() --[[ Line: 120 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		if p1._listeners[p2] then
			p1._listeners[p2][p3] = nil
			if not next(p1._listeners[p2]) then
				p1._listeners[p2] = nil
			end
		end
	end
end
function t.GetClassAddedSignal(p1) --[[ Line: 145 | Upvalues: Signal (copy) ]]
	if not p1._classAddedSignal then
		p1._classAddedSignal = Signal.new()
		p1._maid:GiveTask(p1._classAddedSignal)
	end
	return p1._classAddedSignal
end
function t.GetClassRemovingSignal(p1) --[[ Line: 156 | Upvalues: Signal (copy) ]]
	if not p1._classRemovingSignal then
		p1._classRemovingSignal = Signal.new()
		p1._maid:GiveTask(p1._classRemovingSignal)
	end
	return p1._classRemovingSignal
end
function t.GetAll(p1) --[[ Line: 182 ]]
	local t = {}
	for k, v in pairs(p1._allClassSet) do
		t[#t + 1] = k
	end
	return t
end
function t.GetAllSet(p1) --[[ Line: 206 ]]
	return p1._allClassSet
end
function t.Bind(p1, p2) --[[ Line: 214 | Upvalues: RunService (copy), CollectionService (copy) ]]
	if RunService:IsClient() then
		warn(("[Binder.Bind] - Bindings \'%s\' done on the client! Will be disrupted upon server replication! %s"):format(p1._tagName, debug.traceback()))
	end
	CollectionService:AddTag(p2, p1._tagName)
	return p1:Get(p2)
end
function t.Unbind(p1, p2) --[[ Line: 229 | Upvalues: RunService (copy), CollectionService (copy) ]]
	assert(typeof(p2) == "Instance", "Bad inst\'")
	if RunService:IsClient() then
		warn(("[Binder.Bind] - Unbinding \'%s\' done on the client! Might be disrupted upon server replication! %s"):format(p1._tagName, debug.traceback()))
	end
	CollectionService:RemoveTag(p2, p1._tagName)
end
function t.BindClient(p1, p2) --[[ Line: 247 | Upvalues: RunService (copy), CollectionService (copy) ]]
	if not RunService:IsClient() then
		warn(("[Binder.BindClient] - Bindings \'%s\' done on the server! Will be replicated!"):format(p1._tagName))
	end
	CollectionService:AddTag(p2, p1._tagName)
	return p1:Get(p2)
end
function t.UnbindClient(p1, p2) --[[ Line: 257 | Upvalues: CollectionService (copy) ]]
	assert(typeof(p2) == "Instance", "Bad inst")
	CollectionService:RemoveTag(p2, p1._tagName)
end
function t.Get(p1, p2) --[[ Line: 263 ]]
	assert(typeof(p2) == "Instance", "Argument \'inst\' is not an Instance")
	return p1._instToClass[p2]
end
function t.Promise(p1, p2) --[[ Line: 268 | Upvalues: promiseBoundClass (copy) ]]
	assert(typeof(p2) == "Instance", "Argument \'inst\' is not an Instance")
	return promiseBoundClass(p1, p2)
end
function t._add(p1, p2) --[[ Line: 273 ]]
	assert(typeof(p2) == "Instance", "Argument \'inst\' is not an Instance")
	if not p1._instToClass[p2] then
		if p1._pendingInstSet[p2] == true then
			warn("[Binder._add] - Reentered add. Still loading, probably caused by error in constructor.")
			return
		end
		p1._pendingInstSet[p2] = true
		local v2 = if type(p1._constructor) == "function" then p1._constructor(p2, unpack(p1._args)) elseif p1._constructor.Create then p1._constructor:Create(p2, unpack(p1._args)) else p1._constructor.new(p2, unpack(p1._args))
		if p1._pendingInstSet[p2] == true then
			p1._pendingInstSet[p2] = nil
			if type(v2) == "table" and type(v2.Destroy) == "function" then
				assert(p1._instToClass[p2] == nil, "Overwrote")
				p1._allClassSet[v2] = true
				p1._instToClass[p2] = v2
				local v8 = p1._listeners[p2]
				if v8 then
					for k, v in pairs(v8) do
						task.spawn(k, v2)
					end
				end
				if p1._classAddedSignal then
					p1._classAddedSignal:Fire(v2, p2)
				end
			else
				warn(("[Binder._add] - Bad class constructed for tag %q"):format(p1._tagName))
			end
		else
			warn(("[Binder._add] - Failed to load instance %q of %q, removed while loading!"):format(p2:GetFullName(), (tostring(type(p1._constructor) == "table" and p1._constructor.ClassName or p1._constructor))))
		end
	end
end
function t._remove(p1, p2) --[[ Line: 335 ]]
	p1._pendingInstSet[p2] = nil
	local v1 = p1._instToClass[p2]
	if v1 == nil then
		return
	end
	if p1._classRemovingSignal then
		p1._classRemovingSignal:Fire(v1, p2)
	end
	p1._instToClass[p2] = nil
	p1._allClassSet[v1] = nil
	local v2 = p1._listeners[p2]
	if v2 then
		for k, v in pairs(v2) do
			task.spawn(k, nil)
		end
	end
	if v1.Destroy then
		v1:Destroy()
	else
		local v3 = warn
		v3(("[Binder._remove] - Class %q no longer has destroy, something destroyed it!"):format((tostring(p1._tagName))))
	end
end
function t.Destroy(p1) --[[ Line: 373 ]]
	local v1, v2 = next(p1._instToClass)
	while v2 ~= nil do
		p1:_remove(v1)
		assert(p1._instToClass[v1] == nil, "Failed to remove")
		local v4, v5 = next(p1._instToClass)
		v2, v1 = v5, v4
	end
	p1._maid:DoCleaning()
end
return t