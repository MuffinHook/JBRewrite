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
local ManifestBinder = {}
ManifestBinder.__index = ManifestBinder
function ManifestBinder.new(tagName, manifest, constructor)
	local self = {}
	setmetatable(self, ManifestBinder)
	self._tagName = tagName or error("Bad argument \'tagName\', expected string")
	self._manifest = manifest or error("Bad argument `manifest`, expected table")
	self._constructor = constructor or error("Bad argument `constructor`, expected table or function")
	self._connections = {}
	self._rootInstToClass = {}
	self._rootInstToRootNode = {}
	self._rootInstToManifest = {}
	self._pendingRootInstSet = {}
	self._listeners = {}
	local count = 1
	for k in pairs(manifest) do
		count = count + 1
	end
	self._manifestSizeTarget = count
	task.delay(5, function()
		if not self._loaded then
			warn(("ManifestBinder %q is not loaded. Call :Start() on it!"):format(self._tagName))
		end
	end)
	return self
end
function ManifestBinder.Start(self)
	if self._loaded then
		warn("ManifestBinder already loaded.")
	else
		self._loaded = true
		for i, v in ipairs(CollectionService:GetTagged(self._tagName)) do
			task.spawn(self._bindRoot, self, v)
		end
		table.insert(self._connections, CollectionService:GetInstanceAddedSignal(self._tagName):Connect(function(instance)
			self:_bindRoot(instance)
		end))
		table.insert(self._connections, CollectionService:GetInstanceRemovedSignal(self._tagName):Connect(function(instance)
			self:_unbindRoot(instance)
		end))
	end
end
function ManifestBinder._stopBoundFn(self, rootInstance)
	local boundClass = self._rootInstToClass[rootInstance]
	if boundClass then
		if self._classRemovingSignal then
			self._classRemovingSignal:Fire(boundClass, rootInstance)
		end
		local listeners = self._listeners[rootInstance]
		if listeners then
			for k, v in pairs(listeners) do
				task.spawn(k, nil)
			end
		end
		if boundClass.Destroy then
			boundClass:Destroy()
		else
			local warnFunc = warn
			warnFunc(("[ManifestBinder._remove] - Class %q no longer has destroy, something destroyed it!"):format((tostring(self._tagName))))
		end
		self._rootInstToClass[rootInstance] = nil
	end
end
function ManifestBinder._startBoundFn(self, rootInstance, manifestTable)
	self:_stopBoundFn(rootInstance)
	if self._pendingRootInstSet[rootInstance] == true then
		warn("[ManifestBinder._startBoundFn] - Re-entered add. Still loading, probably caused by error in constructor.")
		return
	end
	self._pendingRootInstSet[rootInstance] = true
	local constructedClass = nil
	if typeof(self._constructor) == "function" then
		constructedClass = self._constructor(rootInstance, manifestTable)
	elseif self._constructor.new then
		constructedClass = self._constructor.new(rootInstance, manifestTable)
	else
		error("Invalid constructor, expected table or function")
	end
	if self._pendingRootInstSet[rootInstance] == true then
		self._pendingRootInstSet[rootInstance] = nil
		if typeof(constructedClass) == "table" then
			if typeof(constructedClass.Destroy) == "function" then
				self._rootInstToClass[rootInstance] = constructedClass
				local listeners = self._listeners[rootInstance]
				if listeners then
					for k, v in pairs(listeners) do
						task.spawn(k, constructedClass)
					end
				end
				if self._classAddedSignal then
					self._classAddedSignal:Fire(constructedClass, rootInstance)
				end
			else
				warn(("[ManifestBinder._startBoundFn] - Bad class constructed for tag %q"):format(self._tagName))
			end
		else
			warn(("[ManifestBinder._startBoundFn] - Bad class constructed for tag %q"):format(self._tagName))
		end
	else
		warn(("[ManifestBinder._startBoundFn] - Failed to load instance %q of %q, removed while loading!"):format(rootInstance:GetFullName(), (tostring(type(self._constructor) == "table" and self._constructor.ClassName or self._constructor))))
	end
end
function ManifestBinder._bindRoot(self, rootInstance)
	assert(self._rootInstToManifest[rootInstance] == nil)
	local manifestResult = {}
	self._rootInstToManifest[rootInstance] = manifestResult
	debug.profilebegin("initializeBoundTree")
	local rootNode = {
		alias = "root",
		instance = rootInstance
	}
	if next(self._manifest) then
		rootNode.children = {}
		rootNode.connections = {}
	end
	self._rootInstToRootNode[rootInstance] = rootNode
	for k, v in pairs(self._manifest) do
		local pathParts = parsePath(v)
		local currentNode = rootNode
		for i, pathPart in ipairs(pathParts) do
			local isLeafNode
			isLeafNode = i == #pathParts
			local treeNode = currentNode.children[pathPart] or {}
			if isLeafNode then
				if treeNode.alias ~= nil then
					error("Multiple aliases assigned to one instance")
				end
				treeNode.alias = k
			else
				treeNode.children = treeNode.children or {}
				treeNode.connections = treeNode.connections or {}
			end
			currentNode.children[pathPart] = treeNode
			currentNode = treeNode
		end
	end
	debug.profileend()
	local function initializeNodeTree(node)
		local nodeInstance = assert(node.instance)
		local children = node.children
		local alias = node.alias
		local isLeafNode = not children
		if alias then
			manifestResult[alias] = nodeInstance
		end
		if not isLeafNode then
			local function processAddChild(addedChild)
				local childNode = children[addedChild.Name]
				if childNode and childNode.instance == nil then
					childNode.instance = addedChild
					initializeNodeTree(childNode)
				end
			end
			local function processDeleteChild(removedChild)
				local childName = removedChild.Name
				local childNode = children[childName]
				if childNode and childNode.instance == removedChild then
					self:_stopBoundFn(rootInstance)
					cleanupNode(childNode, manifestResult)
					assert(childNode.instance == nil)
					local sibling = nodeInstance:FindFirstChild(childName)
					if sibling then
						local siblingNode = children[sibling.Name]
						if siblingNode and siblingNode.instance == nil then
							siblingNode.instance = sibling
							initializeNodeTree(siblingNode)
						end
					end
				end
			end
			for i, v in ipairs(nodeInstance:GetChildren()) do
				local childNode = children[v.Name]
				if childNode and childNode.instance == nil then
					childNode.instance = v
					initializeNodeTree(childNode)
				end
			end
			table.insert(node.connections, nodeInstance.ChildAdded:Connect(processAddChild))
			table.insert(node.connections, nodeInstance.ChildRemoved:Connect(processDeleteChild))
		end
		if isLeafNode then
			local manifestSizeTarget = self._manifestSizeTarget
			local count = 0
			for k in pairs(manifestResult) do
				count = count + 1
			end
			assert(count <= manifestSizeTarget, count)
			if count == manifestSizeTarget then
				self:_startBoundFn(rootInstance, manifestResult)
			end
		end
	end
	initializeNodeTree(rootNode)
end
function ManifestBinder._unbindRoot(self, rootInstance)
	self:_stopBoundFn(rootInstance)
	local rootNode = self._rootInstToRootNode[rootInstance]
	if rootNode then
		cleanupNode(rootNode, (assert(self._rootInstToManifest[rootInstance])))
		self._rootInstToRootNode[rootInstance] = nil
	end
	self._rootInstToManifest[rootInstance] = nil
end
function ManifestBinder.GetAllSet(self)
	return self._rootInstToClass
end
function ManifestBinder.GetAll(self)
	local resultList = {}
	for k, v in pairs(self._rootInstToClass) do
		resultList[#resultList + 1] = v
	end
	return resultList
end
function ManifestBinder.GetTag(self)
	return self._tagName
end
function ManifestBinder.Get(self, rootInstance)
	return self._rootInstToClass[rootInstance]
end
function ManifestBinder.Promise(self, rootInstance)
	return promiseBoundClass(self, rootInstance)
end
function ManifestBinder.ObserveInstance(self, rootInstance, callback)
	self._listeners[rootInstance] = self._listeners[rootInstance] or {}
	self._listeners[rootInstance][callback] = true
	return function()
		if self._listeners[rootInstance] then
			self._listeners[rootInstance][callback] = nil
			if not next(self._listeners[rootInstance]) then
				self._listeners[rootInstance] = nil
			end
		end
	end
end
function ManifestBinder.GetClassAddedSignal(self)
	if not self._classAddedSignal then
		self._classAddedSignal = Signal.new()
		table.insert(self._connections, self._classAddedSignal)
	end
	return self._classAddedSignal
end
function ManifestBinder.GetClassRemovingSignal(self)
	if not self._classRemovingSignal then
		self._classRemovingSignal = Signal.new()
		table.insert(self._connections, self._classRemovingSignal)
	end
	return self._classRemovingSignal
end
function ManifestBinder.Destroy(self)
	debug.profilebegin("ManifestBinder:Destroy")
	local currentRootInstance = next(self._rootInstToClass)
	while currentRootInstance ~= nil do
		self:_stopBoundFn(currentRootInstance)
		assert(self._rootInstToClass[currentRootInstance] == nil, "Failed to remove")
		currentRootInstance = next(self._rootInstToClass)
	end
	table.clear(self._rootInstToClass)
	for i, v in ipairs(self._connections) do
		v:Disconnect()
	end
	table.clear(self._connections)
	local manifestMap = self._rootInstToManifest
	for k, v in pairs(self._rootInstToRootNode) do
		cleanupNode(v, (assert(manifestMap[k])))
	end
	table.clear(self._rootInstToManifest)
	table.clear(self._rootInstToRootNode)
	debug.profileend()
end
return ManifestBinder
