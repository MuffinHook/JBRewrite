local CollectionService = game:GetService("CollectionService")
local function parsePath(p1) --[[ Line: 6 ]]
	local v1 = string.split(p1, "/")
	for i = #v1, 1, -1 do
		if v1[i] == "" then
			table.remove(v1, i)
		end
	end
	return v1
end
local function isManifestResolved(p1, p2) --[[ Line: 16 ]]
	local count = 0
	for k in pairs(p1) do
		count = count + 1
	end
	assert(count <= p2, count)
	return count == p2
end
local function v1(p1, p2) --[[ Line: 26 | Upvalues: v1 (copy) ]]
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
local t = {}
t.__index = t
function t.new(p1, p2, p3) --[[ Line: 56 | Upvalues: parsePath (copy), v1 (copy), CollectionService (copy), t (copy) ]]
	debug.profilebegin("AtomicBinding.new")
	local count = 1
	local t2 = {}
	local t3 = {}
	local t4 = {}
	local t5 = {}
	for k in pairs(p2) do
		count = count + 1
	end
	local function stopBoundFn(p1) --[[ Line: 69 | Upvalues: t2 (copy) ]]
		local v1 = t2[p1]
		if v1 then
			v1:Destroy()
			t2[p1] = nil
		end
	end
	local function startBoundFn(p1, p2) --[[ Line: 77 | Upvalues: t2 (copy), p3 (copy) ]]
		local v1 = t2[p1]
		if v1 then
			v1:Destroy()
			t2[p1] = nil
		end
		local v2 = p3(p2)
		if v2 then
			t2[p1] = v2
		end
	end
	local function bindRoot(p1) --[[ Line: 86 | Upvalues: t3 (copy), p2 (copy), parsePath (ref), t2 (copy), v1 (ref), count (ref), p3 (copy) ]]
		assert(t3[p1] == nil)
		local t = {}
		t3[p1] = t
		debug.profilebegin("initializeBoundTree")
		local t4 = {
			alias = "root",
			instance = p1
		}
		if next(p2) then
			t4.children = {}
			t4.connections = {}
		end
		for k, v in pairs(p2) do
			local v2 = parsePath(v)
			local v3 = t4
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
		local function v8(p12) --[[ Line: 130 | Upvalues: t (copy), v8 (copy), p1 (copy), t2 (ref), v1 (ref), count (ref), p3 (ref) ]]
			local v12 = assert(p12.instance)
			local children = p12.children
			local alias = p12.alias
			local v2 = not children
			if alias then
				t[alias] = v12
			end
			if not v2 then
				local function processAddChild(p1) --[[ Line: 142 | Upvalues: children (copy), v8 (ref) ]]
					local v1 = children[p1.Name]
					if v1 and v1.instance == nil then
						v1.instance = p1
						v8(v1)
					end
				end
				local function processDeleteChild(p12) --[[ Line: 153 | Upvalues: children (copy), p1 (ref), t2 (ref), v1 (ref), t (ref), v12 (copy), v8 (ref) ]]
					local v13 = p12.Name
					local v2 = children[v13]
					if v2 and v2.instance == p12 then
						local v3 = p1
						local v4 = t2[v3]
						if v4 then
							v4:Destroy()
							t2[v3] = nil
						end
						v1(v2, t)
						assert(v2.instance == nil)
						local v6 = v12:FindFirstChild(v13)
						if v6 then
							local v7 = children[v6.Name]
							if v7 and v7.instance == nil then
								v7.instance = v6
								v8(v7)
							end
						end
					end
				end
				for i, v in ipairs(v12:GetChildren()) do
					local v3 = children[v.Name]
					if v3 and v3.instance == nil then
						v3.instance = v
						v8(v3)
					end
				end
				table.insert(p12.connections, v12.ChildAdded:Connect(processAddChild))
				table.insert(p12.connections, v12.ChildRemoved:Connect(processDeleteChild))
			end
			if v2 then
				local v5 = count
				local count_2 = 0
				for k in pairs(t) do
					count_2 = count_2 + 1
				end
				assert(count_2 <= v5, count_2)
				if count_2 == v5 then
					local v82 = p1
					local v10 = t2[v82]
					if v10 then
						v10:Destroy()
						t2[v82] = nil
					end
					local v11 = p3(t)
					if v11 then
						t2[v82] = v11
					end
				end
			end
		end
		debug.profilebegin("resolveBoundTree")
		v8(t4)
		debug.profileend()
	end
	local function unbindRoot(p1) --[[ Line: 204 | Upvalues: t2 (copy), t4 (copy), t3 (copy), v1 (ref) ]]
		local v12 = t2[p1]
		if v12 then
			v12:Destroy()
			t2[p1] = nil
		end
		local v2 = t4[p1]
		if v2 then
			v1(v2, (assert(t3[p1])))
			t4[p1] = nil
		end
		t3[p1] = nil
	end
	for i, v in ipairs(CollectionService:GetTagged(p1)) do
		task.spawn(bindRoot, v)
	end
	table.insert(t5, CollectionService:GetInstanceAddedSignal(p1):Connect(bindRoot))
	table.insert(t5, CollectionService:GetInstanceRemovedSignal(p1):Connect(unbindRoot))
	return setmetatable({
		_dtorMap = t2,
		_connections = t5,
		_rootInstToRootNode = t4,
		_rootInstToManifest = t3
	}, t)
end
function t.Destroy(p1) --[[ Line: 232 | Upvalues: v1 (copy) ]]
	debug.profilebegin("AtomicBinding:Destroy")
	for k, v in pairs(p1._dtorMap) do
		v:Destroy()
	end
	table.clear(p1._dtorMap)
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