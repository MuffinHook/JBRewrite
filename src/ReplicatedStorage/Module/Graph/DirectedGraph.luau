local DirectedGraph = {}
DirectedGraph.__index = DirectedGraph
function DirectedGraph.new()
	local newInstance = {}
	setmetatable(newInstance, DirectedGraph)
	newInstance.MapNodeNode = {}
	newInstance.ListNode = {}
	return newInstance
end
function DirectedGraph.GetNeighbors(graph, sourceNode)
	assert(graph.MapNodeNode[sourceNode] ~= nil)
	local neighbors = {}
	for node in pairs(graph.MapNodeNode[sourceNode]) do
		table.insert(neighbors, node)
	end
	return neighbors
end
function DirectedGraph.GetUndirectedNeighbors(graph, sourceNode)
	assert(graph.MapNodeNode[sourceNode] ~= nil)
	local neighbors = {}
	for node in pairs(graph.MapNodeNode[sourceNode]) do
		table.insert(neighbors, node)
	end
	for node, incomingNodes in pairs(graph.MapNodeNode) do
		if incomingNodes[sourceNode] then
			table.insert(neighbors, node)
		end
	end
	return neighbors
end
function DirectedGraph.AddNode(graph, sourceNode)
	if graph.MapNodeNode[sourceNode] == nil then
		graph.MapNodeNode[sourceNode] = {}
		table.insert(graph.ListNode, sourceNode)
	end
end
function DirectedGraph.AddEdge(graph, sourceNode, destinationNode)
	if graph.MapNodeNode[sourceNode] == nil then
		graph:AddNode(sourceNode)
	end
	if graph.MapNodeNode[destinationNode] == nil then
		graph:AddNode(destinationNode)
	end
	if graph.MapNodeNode[sourceNode][destinationNode] ~= nil then
		error(("Edge already exists from `%s` to `%s`"):format(sourceNode, destinationNode))
	end
	graph.MapNodeNode[sourceNode][destinationNode] = true
end
function DirectedGraph.HasEdge(graph, sourceNode, destinationNode)
	return if graph.MapNodeNode[sourceNode] == nil then false else graph.MapNodeNode[sourceNode][destinationNode] == true
end
function DirectedGraph.Inverse(graph)
	local instance = getmetatable(graph).new()
	for i, node in ipairs(graph.ListNode) do
		instance:AddNode(node)
	end
	for sourceNode, edgesFromSource in pairs(graph.MapNodeNode) do
		for destinationNode in pairs(edgesFromSource) do
			instance:AddEdge(destinationNode, sourceNode)
		end
	end
	return instance
end
return DirectedGraph
