-- Reviewed by Claude
local t = {
	dfs = function(p1, p2, p3, p4)
		assert(p1 ~= nil, "missing Graph G")
		assert(p2 ~= nil, "missing start vertex v")
		assert(typeof(p3) == "nil" or typeof(p3) == "function", "invalid condition")
		local var5 = p4 or p1.GetNeighbors
		local t = {}
		local function v6(p12)
			t[p12] = true
			for i, v in ipairs(var5(p1, p12)) do
				if not t[v] and (p3 == nil or p3(v)) then
					v6(v)
				end
			end
		end
		v6(p2)
		return t
	end,
	bfsSearch = function(p1, p2, p3)
		local t = {}
		table.insert(t, p2)
		local t2 = {
			[p2] = true
		}
		while #t > 0 do
			local tbl = table.remove(t)
			if p3(tbl) then
				return tbl
			end
			for i, v in ipairs(p1:GetNeighbors(tbl)) do
				if not t2[v] then
					t2[v] = true
					table.insert(t, v)
				end
			end
		end
	end
}
function t.weaklyConnectedComponents(p1)
	assert(p1 ~= nil, "missing Graph G")
	local t2 = {}
	local t3 = {}
	for i, v in ipairs(p1.ListNode) do
		if not t2[v] then
			t2[v] = true
			local v2 = t.dfs(p1, v, nil, p1.GetUndirectedNeighbors)
			local instance3 = getmetatable(p1).new()
			for k in pairs(v2) do
				t2[k] = true
				instance3:AddNode(k)
				for k2 in pairs(p1.MapNodeNode[k]) do
					if v2[k2] then
						instance3:AddEdge(k, k2)
					end
				end
			end
			table.insert(t3, instance3)
		end
	end
	return t3
end
return t
