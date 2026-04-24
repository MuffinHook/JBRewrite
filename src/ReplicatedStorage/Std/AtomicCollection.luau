-- Reviewed by Claude
local function parsePath(p1)
	local v1 = string.split(p1, "/")
	for i = #v1, 1, -1 do
		if v1[i] == "" then
			table.remove(v1, i)
		end
	end
	return v1
end
local function isManifestResolved(p1, p2)
	local count = 0
	for k in pairs(p1) do
		count = count + 1
	end
	assert(count <= p2, count)
	return count == p2
end
local function v1(p1, p2)
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
return function(p1, p2, p3)
	local count = 1
	for k in pairs(p2) do
		count = count + 1
	end
	local t = {}
	local v12 = nil
	local function stopBoundFn()
		local v1 = v12
		if v1 then
			v12 = nil
			if typeof(v1) == "function" then
				v1()
				return
			end
			if typeof(task) == "RBXScriptConnection" then
				v1:Disconnect()
				return
			end
			if v1.Destroy then
				v1:Destroy()
				return
			end
			warn("Unknown dtor return value")
		end
	end
	local function startBoundFn()
		stopBoundFn()
		local v1 = p3(t)
		if v1 then
			v12 = v1
		end
	end
	debug.profilebegin("initializeBoundTree")
	local t2 = {
		alias = "root",
		instance = p1
	}
	if next(p2) then
		t2.children = {}
		t2.connections = {}
	end
	for k, v in pairs(p2) do
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
	local function v8(p1)
		local v13 = assert(p1.instance)
		local children = p1.children
		local alias = p1.alias
		local v2 = not children
		if alias then
			t[alias] = v13
		end
		if not v2 then
			local function processAddChild(p1)
				local v1 = children[p1.Name]
				if v1 and v1.instance == nil then
					v1.instance = p1
					v8(v1)
				end
			end
			local function processDeleteChild(p1)
				local v12 = p1.Name
				local v2 = children[v12]
				if v2 and v2.instance == p1 then
					stopBoundFn()
					v1(v2, t)
					assert(v2.instance == nil)
					local v3 = v13:FindFirstChild(v12)
					if v3 then
						local v4 = children[v3.Name]
						if v4 and v4.instance == nil then
							v4.instance = v3
							v8(v4)
						end
					end
				end
			end
			for i, v in ipairs(v13:GetChildren()) do
				local v3 = children[v.Name]
				if v3 and v3.instance == nil then
					v3.instance = v
					v8(v3)
				end
			end
			table.insert(p1.connections, v13.ChildAdded:Connect(processAddChild))
			table.insert(p1.connections, v13.ChildRemoved:Connect(processDeleteChild))
		end
		if v2 then
			local v5 = count
			local count_2 = 0
			for k in pairs(t) do
				count_2 = count_2 + 1
			end
			assert(count_2 <= v5, count_2)
			if count_2 == v5 then
				stopBoundFn()
				local v82 = p3(t)
				if v82 then
					v12 = v82
				end
			end
		end
	end
	debug.profilebegin("resolveBoundTree")
	v8(t2)
	debug.profileend()
	return function()
		stopBoundFn()
		if t2 then
			v1(t2, t)
			t2 = nil
		end
		t = nil
	end
end
