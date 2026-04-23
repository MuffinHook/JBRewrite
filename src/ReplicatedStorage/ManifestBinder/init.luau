local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local promiseBoundClass = require(script.promiseBoundClass)
local parsePath = require(script.parsePath)
local function isManifestResolved(p1, p2) --[[ Line: 16 ]]
	local count = 0
	for k in pairs(p1) do
		count = count + 1
	end
	assert(count <= p2, count)
	return count == p2
end
local function v1(p1, p2) --[[ Line: 26 | Upvalues: v1 (copy) ]]
	if p1.instance ~= nil then
		p1.instance = nil
		local connections = p1.connections
		if connections then
			for i, v in ipairs(connections) do
				v:Disconnect()
			end
			table.clear(connections)
		end
		if p2 and p1.alias then
			p2[p1.alias] = nil
		end
		local children = p1.children
		if children then
			for k, v in pairs(children) do
				v1(v, p2)
			end
		end
	end
end
local t = {}
t.__index = t
function t.new(p1, p2, p3) --[[ Line: 56 | Upvalues: t (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._tagName = p1 or error("Bad argument \'tagName\', expected string")
	t2._manifest = p2 or error("Bad argument `manifest`, expected table")
	t2._constructor = p3 or error("Bad argument `constructor`, expected table or function")
	t2._connections = {}
	t2._rootInstToClass = {}
	t2._rootInstToRootNode = {}
	t2._rootInstToManifest = {}
	t2._pendingRootInstSet = {}
	t2._listeners = {}
	local count = 1
	for k in pairs(p2) do
		count = count + 1
	end
	t2._manifestSizeTarget = count
	task.delay(5, function() --[[ Line: 77 | Upvalues: t2 (copy) ]]
		if not t2._loaded then
			warn(("ManifestBinder %q is not loaded. Call :Start() on it!"):format(t2._tagName))
		end
	end)
	return t2
end
function t.Start(p1) --[[ Line: 85 | Upvalues: CollectionService (copy) ]]
	if p1._loaded then
		warn("ManifestBinder already loaded.")
	else
		p1._loaded = true
		for i, v in ipairs(CollectionService:GetTagged(p1._tagName)) do
			task.spawn(p1._bindRoot, p1, v)
		end
		table.insert(p1._connections, CollectionService:GetInstanceAddedSignal(p1._tagName):Connect(function(p12) --[[ Line: 98 | Upvalues: p1 (copy) ]]
			p1:_bindRoot(p12)
		end))
		table.insert(p1._connections, CollectionService:GetInstanceRemovedSignal(p1._tagName):Connect(function(p12) --[[ Line: 104 | Upvalues: p1 (copy) ]]
			p1:_unbindRoot(p12)
		end))
	end
end
function t._stopBoundFn(p1, p2) --[[ Line: 109 ]]
	local v1 = p1._rootInstToClass[p2]
	if v1 then
		if p1._classRemovingSignal then
			p1._classRemovingSignal:Fire(v1, p2)
		end
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
			v3(("[ManifestBinder._remove] - Class %q no longer has destroy, something destroyed it!"):format((tostring(p1._tagName))))
		end
		p1._rootInstToClass[p2] = nil
	end
end
function t._startBoundFn(p1, p2, p3) --[[ Line: 135 ]]
	p1:_stopBoundFn(p2)
	if p1._pendingRootInstSet[p2] == true then
		warn("[ManifestBinder._startBoundFn] - Re-entered add. Still loading, probably caused by error in constructor.")
		return
	end
	p1._pendingRootInstSet[p2] = true
	local v1 = nil
	if typeof(p1._constructor) == "function" then
		v1 = p1._constructor(p2, p3)
	elseif p1._constructor.new then
		v1 = p1._constructor.new(p2, p3)
	else
		error("Invalid constructor, expected table or function")
	end
	if p1._pendingRootInstSet[p2] == true then
		p1._pendingRootInstSet[p2] = nil
		if typeof(v1) == "table" then
			if typeof(v1.Destroy) == "function" then
				p1._rootInstToClass[p2] = v1
				local v4 = p1._listeners[p2]
				if v4 then
					for k, v in pairs(v4) do
						task.spawn(k, v1)
					end
				end
				if p1._classAddedSignal then
					p1._classAddedSignal:Fire(v1, p2)
				end
			else
				warn(("[ManifestBinder._startBoundFn] - Bad class constructed for tag %q"):format(p1._tagName))
			end
		else
			warn(("[ManifestBinder._startBoundFn] - Bad class constructed for tag %q"):format(p1._tagName))
		end
	else
		warn(("[ManifestBinder._startBoundFn] - Failed to load instance %q of %q, removed while loading!"):format(p2:GetFullName(), (tostring(type(p1._constructor) == "table" and p1._constructor.ClassName or p1._constructor))))
	end
end
function t._bindRoot(p1, p2) --[[ Line: 186 | Upvalues: parsePath (copy), v1 (copy) ]]
	assert(p1._rootInstToManifest[p2] == nil)
	local t = {}
	p1._rootInstToManifest[p2] = t
	debug.profilebegin("initializeBoundTree")
	local t2 = {
		alias = "root",
		instance = p2
	}
	if next(p1._manifest) then
		t2.children = {}
		t2.connections = {}
	end
	p1._rootInstToRootNode[p2] = t2
	for k, v in pairs(p1._manifest) do
		local v2 = parsePath(v)
		local v3 = t2
		for i, v5 in ipairs(v2) do
			local v4
			v4 = i == #v2
			local v52 = v3.children[v5] or {}
			if v4 then
				if v52.alias ~= nil then
					error("Multiple aliases assigned to one instance")
				end
				v52.alias = k
			else
				v52.children = v52.children or {}
				v52.connections = v52.connections or {}
			end
			v3.children[v5] = v52
			v3 = v52
		end
	end
	debug.profileend()
	local function v8(p12) --[[ Line: 232 | Upvalues: t (copy), v8 (copy), p1 (copy), p2 (copy), v1 (ref) ]]
		local v12 = assert(p12.instance)
		local children = p12.children
		local alias = p12.alias
		local v2 = not children
		if alias then
			t[alias] = v12
		end
		if not v2 then
			local function processAddChild(p1) --[[ Line: 244 | Upvalues: children (copy), v8 (ref) ]]
				local v1 = children[p1.Name]
				if v1 and v1.instance == nil then
					v1.instance = p1
					v8(v1)
				end
			end
			local function processDeleteChild(p12) --[[ Line: 255 | Upvalues: children (copy), p1 (ref), p2 (ref), v1 (ref), t (ref), v12 (copy), v8 (ref) ]]
				local v13 = p12.Name
				local v2 = children[v13]
				if v2 and v2.instance == p12 then
					p1:_stopBoundFn(p2)
					v1(v2, t)
					assert(v2.instance == nil)
					local v3 = v12:FindFirstChild(v13)
					if v3 then
						local v4 = children[v3.Name]
						if v4 and v4.instance == nil then
							v4.instance = v3
							v8(v4)
						end
					end
				end
			end
			for i, v in ipairs(v12:GetChildren()) do
				local v3 = children[v.Name]
				if v3 and v3.instance == nil then
					v3.instance = v
					v8(v3)
				end
			end
			table.insert(p12.connections, v12.ChildAdded:Connect(processAddChild))
			table.insert(p12.connections, v12.ChildRemoved:Connect(processDeleteChild))
		end
		if v2 then
			local _manifestSizeTarget = p1._manifestSizeTarget
			local count = 0
			for k in pairs(t) do
				count = count + 1
			end
			assert(count <= _manifestSizeTarget, count)
			if count == _manifestSizeTarget then
				p1:_startBoundFn(p2, t)
			end
		end
	end
	v8(t2)
end
function t._unbindRoot(p1, p2) --[[ Line: 305 | Upvalues: v1 (copy) ]]
	p1:_stopBoundFn(p2)
	local v12 = p1._rootInstToRootNode[p2]
	if v12 then
		v1(v12, (assert(p1._rootInstToManifest[p2])))
		p1._rootInstToRootNode[p2] = nil
	end
	p1._rootInstToManifest[p2] = nil
end
function t.GetAllSet(p1) --[[ Line: 317 ]]
	return p1._rootInstToClass
end
function t.GetAll(p1) --[[ Line: 321 ]]
	local t = {}
	for k, v in pairs(p1._rootInstToClass) do
		t[#t + 1] = v
	end
	return t
end
function t.GetTag(p1) --[[ Line: 328 ]]
	return p1._tagName
end
function t.Get(p1, p2) --[[ Line: 331 ]]
	return p1._rootInstToClass[p2]
end
function t.Promise(p1, p2) --[[ Line: 334 | Upvalues: promiseBoundClass (copy) ]]
	return promiseBoundClass(p1, p2)
end
function t.ObserveInstance(p1, p2, p3) --[[ Line: 338 ]]
	p1._listeners[p2] = p1._listeners[p2] or {}
	p1._listeners[p2][p3] = true
	return function() --[[ Line: 342 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		if p1._listeners[p2] then
			p1._listeners[p2][p3] = nil
			if not next(p1._listeners[p2]) then
				p1._listeners[p2] = nil
			end
		end
	end
end
function t.GetClassAddedSignal(p1) --[[ Line: 353 | Upvalues: Signal (copy) ]]
	if not p1._classAddedSignal then
		p1._classAddedSignal = Signal.new()
		table.insert(p1._connections, p1._classAddedSignal)
	end
	return p1._classAddedSignal
end
function t.GetClassRemovingSignal(p1) --[[ Line: 364 | Upvalues: Signal (copy) ]]
	if not p1._classRemovingSignal then
		p1._classRemovingSignal = Signal.new()
		table.insert(p1._connections, p1._classRemovingSignal)
	end
	return p1._classRemovingSignal
end
function t.Destroy(p1) --[[ Line: 374 | Upvalues: v1 (copy) ]]
	debug.profilebegin("ManifestBinder:Destroy")
	local v12 = next(p1._rootInstToClass)
	while v12 ~= nil do
		p1:_stopBoundFn(v12)
		assert(p1._rootInstToClass[v12] == nil, "Failed to remove")
		v12 = next(p1._rootInstToClass)
	end
	table.clear(p1._rootInstToClass)
	for i, v in ipairs(p1._connections) do
		v:Disconnect()
	end
	table.clear(p1._connections)
	local _rootInstToManifest = p1._rootInstToManifest
	for k, v in pairs(p1._rootInstToRootNode) do
		v1(v, (assert(_rootInstToManifest[k])))
	end
	table.clear(p1._rootInstToManifest)
	table.clear(p1._rootInstToRootNode)
	debug.profileend()
end
return t