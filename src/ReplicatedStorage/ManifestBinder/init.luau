-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local promiseBoundClass = require(script.promiseBoundClass)
local parsePath = require(script.parsePath)
local function isManifestResolved(manifest, targetSize)
	local count = 0
	for k in pairs(manifest) do
		count = count + 1
	end
	assert(count <= targetSize, count)
	return count == targetSize
end
local function cleanupNode(node, manifest)
	if node.instance ~= nil then
		node.instance = nil
		local connections = node.connections
		if connections then
			for i, v in ipairs(connections) do
				v:Disconnect()
			end
			table.clear(connections)
		end
		if manifest and node.alias then
			manifest[node.alias] = nil
		end
		local children = node.children
		if children then
			for k, v in pairs(children) do
				cleanupNode(v, manifest)
			end
		end
	end
end
local t = {}
t.__index = t
function t.new(p1, p2, p3)
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
	task.delay(5, function()
		if not t2._loaded then
			warn(("ManifestBinder %q is not loaded. Call :Start() on it!"):format(t2._tagName))
		end
	end)
	return t2
end
function t.Start(p1)
	if p1._loaded then
		warn("ManifestBinder already loaded.")
	else
		p1._loaded = true
		for i, v in ipairs(CollectionService:GetTagged(p1._tagName)) do
			task.spawn(p1._bindRoot, p1, v)
		end
		table.insert(p1._connections, CollectionService:GetInstanceAddedSignal(p1._tagName):Connect(function(p12)
			p1:_bindRoot(p12)
		end))
		table.insert(p1._connections, CollectionService:GetInstanceRemovedSignal(p1._tagName):Connect(function(p12)
			p1:_unbindRoot(p12)
		end))
	end
end
function t._stopBoundFn(p1, p2)
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
			local var3 = warn
			var3(("[ManifestBinder._remove] - Class %q no longer has destroy, something destroyed it!"):format((tostring(p1._tagName))))
		end
		p1._rootInstToClass[p2] = nil
	end
end
function t._startBoundFn(p1, p2, p3)
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
				local var4 = p1._listeners[p2]
				if var4 then
					for k, v in pairs(var4) do
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
function t._bindRoot(p1, p2)
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
		local var3 = t2
		for i, v5 in ipairs(v2) do
			local var4
			var4 = i == #v2
			local table52 = var3.children[v5] or {}
			if var4 then
				if table52.alias ~= nil then
					error("Multiple aliases assigned to one instance")
				end
				table52.alias = k
			else
				table52.children = table52.children or {}
				table52.connections = table52.connections or {}
			end
			var3.children[v5] = table52
			var3 = table52
		end
	end
	debug.profileend()
	local function v8(p12)
		local var12 = assert(p12.instance)
		local children = p12.children
		local alias = p12.alias
		local v2 = not children
		if alias then
			t[alias] = var12
		end
		if not v2 then
			local function processAddChild(p1)
				local v1 = children[p1.Name]
				if v1 and v1.instance == nil then
					v1.instance = p1
					v8(v1)
				end
			end
			local function processDeleteChild(p12)
				local var13 = p12.Name
				local v2 = children[var13]
				if v2 and v2.instance == p12 then
					p1:_stopBoundFn(p2)
					v1(v2, t)
					assert(v2.instance == nil)
					local var3 = var12:FindFirstChild(var13)
					if var3 then
						local var4 = children[var3.Name]
						if var4 and var4.instance == nil then
							var4.instance = var3
							v8(var4)
						end
					end
				end
			end
			for i, v in ipairs(var12:GetChildren()) do
				local var3 = children[v.Name]
				if var3 and var3.instance == nil then
					var3.instance = v
					v8(var3)
				end
			end
			table.insert(p12.connections, var12.ChildAdded:Connect(processAddChild))
			table.insert(p12.connections, var12.ChildRemoved:Connect(processDeleteChild))
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
function t._unbindRoot(p1, p2)
	p1:_stopBoundFn(p2)
	local var12 = p1._rootInstToRootNode[p2]
	if var12 then
		v1(var12, (assert(p1._rootInstToManifest[p2])))
		p1._rootInstToRootNode[p2] = nil
	end
	p1._rootInstToManifest[p2] = nil
end
function t.GetAllSet(p1)
	return p1._rootInstToClass
end
function t.GetAll(p1)
	local t = {}
	for k, v in pairs(p1._rootInstToClass) do
		t[#t + 1] = v
	end
	return t
end
function t.GetTag(p1)
	return p1._tagName
end
function t.Get(p1, p2)
	return p1._rootInstToClass[p2]
end
function t.Promise(p1, p2)
	return promiseBoundClass(p1, p2)
end
function t.ObserveInstance(p1, p2, p3)
	p1._listeners[p2] = p1._listeners[p2] or {}
	p1._listeners[p2][p3] = true
	return function()
		if p1._listeners[p2] then
			p1._listeners[p2][p3] = nil
			if not next(p1._listeners[p2]) then
				p1._listeners[p2] = nil
			end
		end
	end
end
function t.GetClassAddedSignal(p1)
	if not p1._classAddedSignal then
		p1._classAddedSignal = Signal.new()
		table.insert(p1._connections, p1._classAddedSignal)
	end
	return p1._classAddedSignal
end
function t.GetClassRemovingSignal(p1)
	if not p1._classRemovingSignal then
		p1._classRemovingSignal = Signal.new()
		table.insert(p1._connections, p1._classRemovingSignal)
	end
	return p1._classRemovingSignal
end
function t.Destroy(p1)
	debug.profilebegin("ManifestBinder:Destroy")
	local var12 = next(p1._rootInstToClass)
	while var12 ~= nil do
		p1:_stopBoundFn(var12)
		assert(p1._rootInstToClass[var12] == nil, "Failed to remove")
		var12 = next(p1._rootInstToClass)
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
