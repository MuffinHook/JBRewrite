local t = {
	dfs = function(graph, startVertex, conditionFunction, customNeighborsFunction)
		assert(graph ~= nil, "missing Graph G")
		assert(startVertex ~= nil, "missing start vertex v")
		assert(typeof(conditionFunction) == "nil" or typeof(conditionFunction) == "function", "invalid condition")
		local neighborsFunction = customNeighborsFunction or graph.GetNeighbors
		local t = {}
		local function visitVertex(vertex)
			t[vertex] = true
			for i, neighbor in ipairs(neighborsFunction(graph, vertex)) do
				if not t[neighbor] and (conditionFunction == nil or conditionFunction(neighbor)) then
					visitVertex(neighbor)
				end
			end
		end
		visitVertex(startVertex)
		return t
	end,
	bfsSearch = function(graph, startNode, conditionFunction)
		local queue = {}
		table.insert(queue, startNode)
		local visitedSet = {
			[startNode] = true
		}
		while #queue > 0 do
			local currentNode = table.remove(queue)
			if conditionFunction(currentNode) then
				return currentNode
			end
			for i, neighbor in ipairs(graph:GetNeighbors(currentNode)) do
				if not visitedSet[neighbor] then
					visitedSet[neighbor] = true
					table.insert(queue, neighbor)
				end
			end
		end
	end
}
function t.weaklyConnectedComponents(graph)
	assert(graph ~= nil, "missing Graph G")
	local visitedGlobal = {}
	local components = {}
	for i, v in ipairs(graph.ListNode) do
		if not visitedGlobal[v] then
			visitedGlobal[v] = true
			local componentVertices = t.dfs(graph, v, nil, graph.GetUndirectedNeighbors)
			local componentGraph = getmetatable(graph).new()
			for nodeKey in pairs(componentVertices) do
				visitedGlobal[nodeKey] = true
				componentGraph:AddNode(nodeKey)
				for targetVertex in pairs(graph.MapNodeNode[nodeKey]) do
					if componentVertices[targetVertex] then
						componentGraph:AddEdge(nodeKey, targetVertex)
					end
				end
			end
			table.insert(components, componentGraph)
		end
	end
	return components
end
return t
