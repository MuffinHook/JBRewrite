local t = {
	dfs = function(p1, p2, p3, p4) --[[ Name: dfs | Line: 2 ]]
		assert(p1 ~= nil, "missing Graph G")
		assert(p2 ~= nil, "missing start vertex v")
		assert(typeof(p3) == "nil" or typeof(p3) == "function", "invalid condition")
		local v5 = p4 or p1.GetNeighbors
		local t = {}
		local function v6(p12) --[[ Line: 10 | Upvalues: t (copy), v5 (ref), p1 (copy), p3 (copy), v6 (copy) ]]
			t[p12] = true
			for i, v in ipairs(v5(p1, p12)) do
				if not t[v] and (p3 == nil or p3(v)) then
					v6(v)
				end
			end
		end
		v6(p2)
		return t
	end,
	bfsSearch = function(p1, p2, p3) --[[ Name: bfsSearch | Line: 23 ]]
		local t = {}
		table.insert(t, p2)
		local t2 = {
			[p2] = true
		}
		while #t > 0 do
			local v1 = table.remove(t)
			if p3(v1) then
				return v1
			end
			for i, v in ipairs(p1:GetNeighbors(v1)) do
				if not t2[v] then
					t2[v] = true
					table.insert(t, v)
				end
			end
		end
	end
}
function t.weaklyConnectedComponents(p1) --[[ Line: 41 | Upvalues: t (copy) ]]
	assert(p1 ~= nil, "missing Graph G")
	local t2 = {}
	local t3 = {}
	for i, v in ipairs(p1.ListNode) do
		if not t2[v] then
			t2[v] = true
			local v2 = t.dfs(p1, v, nil, p1.GetUndirectedNeighbors)
			local v3 = getmetatable(p1).new()
			for k in pairs(v2) do
				t2[k] = true
				v3:AddNode(k)
				for k2 in pairs(p1.MapNodeNode[k]) do
					if v2[k2] then
						v3:AddEdge(k, k2)
					end
				end
			end
			table.insert(t3, v3)
		end
	end
	return t3
end
return t