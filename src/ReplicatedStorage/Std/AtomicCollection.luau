local function parsePath(pathString)
	local pathSegments = string.split(pathString, "/")
	for i = #pathSegments, 1, -1 do
		if pathSegments[i] == "" then
			table.remove(pathSegments, i)
		end
	end
	return pathSegments
end
local function isManifestResolved(manifestDict, expectedCount)
	local count = 0
	for k in pairs(manifestDict) do
		count = count + 1
	end
	assert(count <= expectedCount, count)
	return count == expectedCount
end
local function clearAtomicNode(nodeData, aliasTable)
	if nodeData.instance ~= nil then
		nodeData.instance = nil
		local connections = nodeData.connections
		if connections then
			for i, connection in ipairs(connections) do
				connection:Disconnect()
			end
			table.clear(connections)
		end
		if aliasTable and nodeData.alias then
			aliasTable[nodeData.alias] = nil
		end
		local children = nodeData.children
		if children then
			for k, childNode in pairs(children) do
				clearAtomicNode(childNode, aliasTable)
			end
		end
	end
end
return function(rootInstance, manifestDict, boundFnCallback)
	local count = 1
	for k in pairs(manifestDict) do
		count = count + 1
	end
	local resultTable = {}
	local boundFnOrConnection = nil
	local function stopBoundFn()
		local boundValue = boundFnOrConnection
		if boundValue then
			boundFnOrConnection = nil
			if typeof(boundValue) == "function" then
				boundValue()
				return
			end
			if typeof(task) == "RBXScriptConnection" then
				boundValue:Disconnect()
				return
			end
			if boundValue.Destroy then
				boundValue:Destroy()
				return
			end
			warn("Unknown dtor return value")
		end
	end
	local function startBoundFn()
		stopBoundFn()
		local boundValue = boundFnCallback(resultTable)
		if boundValue then
			boundFnOrConnection = boundValue
		end
	end
	debug.profilebegin("initializeBoundTree")
	local rootNode = {
		alias = "root",
		instance = rootInstance
	}
	if next(manifestDict) then
		rootNode.children = {}
		rootNode.connections = {}
	end
	for k, v in pairs(manifestDict) do
		local pathSegments = parsePath(v)
		local currentNode = rootNode
		for i, pathSegment in ipairs(pathSegments) do
			local isLastSegment
			isLastSegment = i == #pathSegments
			local childNode = currentNode.children[pathSegment] or {}
			if isLastSegment then
				if childNode.alias ~= nil then
					error("Multiple aliases assigned to one instance")
				end
				childNode.alias = k
			else
				childNode.children = childNode.children or {}
				childNode.connections = childNode.connections or {}
			end
			currentNode.children[pathSegment] = childNode
			currentNode = childNode
		end
	end
	debug.profileend()
	local function resolveTreeNode(nodeData)
		local nodeInstance = assert(nodeData.instance)
		local children = nodeData.children
		local alias = nodeData.alias
		local isLeaf = not children
		if alias then
			resultTable[alias] = nodeInstance
		end
		if not isLeaf then
			local function processAddChild(childInstance)
				local foundChild = children[childInstance.Name]
				if foundChild and foundChild.instance == nil then
					foundChild.instance = childInstance
					resolveTreeNode(foundChild)
				end
			end
			local function processDeleteChild(deletedInstance)
				local deletedName = deletedInstance.Name
				local targetChild = children[deletedName]
				if targetChild and targetChild.instance == deletedInstance then
					stopBoundFn()
					clearAtomicNode(targetChild, resultTable)
					assert(targetChild.instance == nil)
					local replacementChild = nodeInstance:FindFirstChild(deletedName)
					if replacementChild then
						local replacementData = children[replacementChild.Name]
						if replacementData and replacementData.instance == nil then
							replacementData.instance = replacementChild
							resolveTreeNode(replacementData)
						end
					end
				end
			end
			for i, childInstance in ipairs(nodeInstance:GetChildren()) do
				local foundChild = children[childInstance.Name]
				if foundChild and foundChild.instance == nil then
					foundChild.instance = childInstance
					resolveTreeNode(foundChild)
				end
			end
			table.insert(nodeData.connections, nodeInstance.ChildAdded:Connect(processAddChild))
			table.insert(nodeData.connections, nodeInstance.ChildRemoved:Connect(processDeleteChild))
		end
		if isLeaf then
			local expectedCount = count
			local resolvedCount = 0
			for k in pairs(resultTable) do
				resolvedCount = resolvedCount + 1
			end
			assert(resolvedCount <= expectedCount, resolvedCount)
			if resolvedCount == expectedCount then
				stopBoundFn()
				local boundValue = boundFnCallback(resultTable)
				if boundValue then
					boundFnOrConnection = boundValue
				end
			end
		end
	end
	debug.profilebegin("resolveBoundTree")
	resolveTreeNode(rootNode)
	debug.profileend()
	return function()
		stopBoundFn()
		if rootNode then
			clearAtomicNode(rootNode, resultTable)
			rootNode = nil
		end
		resultTable = nil
	end
end
