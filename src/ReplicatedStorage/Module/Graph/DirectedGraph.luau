-- Reviewed by Claude
local t = {}
t.__index = t
function t.new()
	local t2 = {}
	setmetatable(t2, t)
	t2.MapNodeNode = {}
	t2.ListNode = {}
	return t2
end
function t.GetNeighbors(p1, p2)
	assert(p1.MapNodeNode[p2] ~= nil)
	local t = {}
	for k in pairs(p1.MapNodeNode[p2]) do
		table.insert(t, k)
	end
	return t
end
function t.GetUndirectedNeighbors(p1, p2)
	assert(p1.MapNodeNode[p2] ~= nil)
	local t = {}
	for k in pairs(p1.MapNodeNode[p2]) do
		table.insert(t, k)
	end
	for k, v in pairs(p1.MapNodeNode) do
		if v[p2] then
			table.insert(t, k)
		end
	end
	return t
end
function t.AddNode(p1, p2)
	if p1.MapNodeNode[p2] == nil then
		p1.MapNodeNode[p2] = {}
		table.insert(p1.ListNode, p2)
	end
end
function t.AddEdge(p1, p2, p3)
	if p1.MapNodeNode[p2] == nil then
		p1:AddNode(p2)
	end
	if p1.MapNodeNode[p3] == nil then
		p1:AddNode(p3)
	end
	if p1.MapNodeNode[p2][p3] ~= nil then
		error(("Edge already exists from `%s` to `%s`"):format(p2, p3))
	end
	p1.MapNodeNode[p2][p3] = true
end
function t.HasEdge(p1, p2, p3)
	return if p1.MapNodeNode[p2] == nil then false else p1.MapNodeNode[p2][p3] == true
end
function t.Inverse(p1)
	local instance = getmetatable(p1).new()
	for i, v in ipairs(p1.ListNode) do
		instance:AddNode(v)
	end
	for k, v in pairs(p1.MapNodeNode) do
		for k2 in pairs(v) do
			instance:AddEdge(k2, k)
		end
	end
	return instance
end
return t
