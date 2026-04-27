local CollectionService = game:GetService("CollectionService")
local function parsePath(path)
	local parts = string.split(path, "/")
	for i = #parts, 1, -1 do
		if parts[i] == "" then
			table.remove(parts, i)
		end
	end
	return parts
end
local function isManifestResolved(manifest, expectedCount)
	local count = 0
	for k in pairs(manifest) do
		count = count + 1
	end
	assert(count <= expectedCount, count)
	return count == expectedCount
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
local AtomicBinding = {}
AtomicBinding.__index = AtomicBinding
function AtomicBinding.new(tagName, manifestDict, destructorFn)
	debug.profilebegin("AtomicBinding.new")
	local count = 1
	local dtorMap = {}
	local rootInstToManifest = {}
	local rootInstToRootNode = {}
	local connections = {}
	for k in pairs(manifestDict) do
		count = count + 1
	end
	local function stopBoundFn(key)
		local dtor = dtorMap[key]
		if dtor then
			dtor:Destroy()
			dtorMap[key] = nil
		end
	end
	local function startBoundFn(key, manifestEntry)
		local dtor = dtorMap[key]
		if dtor then
			dtor:Destroy()
			dtorMap[key] = nil
		end
		local newDtor = destructorFn(manifestEntry)
		if newDtor then
			dtorMap[key] = newDtor
		end
	end
	local function bindRoot(rootInst)
		assert(rootInstToManifest[rootInst] == nil)
		local manifest = {}
		rootInstToManifest[rootInst] = manifest
		debug.profilebegin("initializeBoundTree")
		local rootNode = {
			alias = "root",
			instance = rootInst
		}
		if next(manifestDict) then
			rootNode.children = {}
			rootNode.connections = {}
		end
		for k, v in pairs(manifestDict) do
			local pathParts = parsePath(v)
			local currentNode = rootNode
			for i, pathSegment in ipairs(pathParts) do
				local isLeaf
				isLeaf = i == #pathParts
				local nextNode = currentNode.children[pathSegment] or {}
				if isLeaf then
					if nextNode.alias ~= nil then
						error("Multiple aliases assigned to one instance")
					end
					nextNode.alias = k
				else
					nextNode.children = nextNode.children or {}
					nextNode.connections = nextNode.connections or {}
				end
				currentNode.children[pathSegment] = nextNode
				currentNode = nextNode
			end
		end
		debug.profileend()
		local function resolveBoundTree(node)
			local nodeInstance = assert(node.instance)
			local children = node.children
			local alias = node.alias
			local isLeafNode = not children
			if alias then
				manifest[alias] = nodeInstance
			end
			if not isLeafNode then
				local function processAddChild(childInst)
					local childNode = children[childInst.Name]
					if childNode and childNode.instance == nil then
						childNode.instance = childInst
						resolveBoundTree(childNode)
					end
				end
				local function processDeleteChild(deletedChild)
					local childName = deletedChild.Name
					local childNode = children[childName]
					if childNode and childNode.instance == deletedChild then
						local rootKey = rootInst
						local rootDtor = dtorMap[rootKey]
						if rootDtor then
							rootDtor:Destroy()
							dtorMap[rootKey] = nil
						end
						cleanupNode(childNode, manifest)
						assert(childNode.instance == nil)
						local sibling = nodeInstance:FindFirstChild(childName)
						if sibling then
							local siblingNode = children[sibling.Name]
							if siblingNode and siblingNode.instance == nil then
								siblingNode.instance = sibling
								resolveBoundTree(siblingNode)
							end
						end
					end
				end
				for i, v in ipairs(nodeInstance:GetChildren()) do
					local childNode = children[v.Name]
					if childNode and childNode.instance == nil then
						childNode.instance = v
						resolveBoundTree(childNode)
					end
				end
				table.insert(node.connections, nodeInstance.ChildAdded:Connect(processAddChild))
				table.insert(node.connections, nodeInstance.ChildRemoved:Connect(processDeleteChild))
			end
			if isLeafNode then
				local expectedCount = count
				local resolvedCount = 0
				for k in pairs(manifest) do
					resolvedCount = resolvedCount + 1
				end
				assert(resolvedCount <= expectedCount, resolvedCount)
				if resolvedCount == expectedCount then
					local rootKey = rootInst
					local rootDtor = dtorMap[rootKey]
					if rootDtor then
						rootDtor:Destroy()
						dtorMap[rootKey] = nil
					end
					local newDtor = destructorFn(manifest)
					if newDtor then
						dtorMap[rootKey] = newDtor
					end
				end
			end
		end
		debug.profilebegin("resolveBoundTree")
		resolveBoundTree(rootNode)
		debug.profileend()
	end
	local function unbindRoot(rootInst)
		local rootDtor = dtorMap[rootInst]
		if rootDtor then
			rootDtor:Destroy()
			dtorMap[rootInst] = nil
		end
		local rootNode = rootInstToRootNode[rootInst]
		if rootNode then
			cleanupNode(rootNode, (assert(rootInstToManifest[rootInst])))
			rootInstToRootNode[rootInst] = nil
		end
		rootInstToManifest[rootInst] = nil
	end
	for i, v in ipairs(CollectionService:GetTagged(tagName)) do
		task.spawn(bindRoot, v)
	end
	table.insert(connections, CollectionService:GetInstanceAddedSignal(tagName):Connect(bindRoot))
	table.insert(connections, CollectionService:GetInstanceRemovedSignal(tagName):Connect(unbindRoot))
	return setmetatable({
		_dtorMap = dtorMap,
		_connections = connections,
		_rootInstToRootNode = rootInstToRootNode,
		_rootInstToManifest = rootInstToManifest
	}, AtomicBinding)
end
function AtomicBinding.Destroy(self)
	debug.profilebegin("AtomicBinding:Destroy")
	for k, v in pairs(self._dtorMap) do
		v:Destroy()
	end
	table.clear(self._dtorMap)
	for i, v in ipairs(self._connections) do
		v:Disconnect()
	end
	table.clear(self._connections)
	local manifest = self._rootInstToManifest
	for k, v in pairs(self._rootInstToRootNode) do
		cleanupNode(v, (assert(manifest[k])))
	end
	table.clear(self._rootInstToManifest)
	table.clear(self._rootInstToRootNode)
	debug.profileend()
end
return AtomicBinding
