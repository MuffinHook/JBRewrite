local v1 = newproxy()
local v2 = newproxy()
local RunService = game:GetService("RunService")
local function GetObjectCleanupFunction(p1, p2) --[[ Line: 10 | Upvalues: v1 (copy), v2 (copy) ]]
	local v12 = typeof(p1)
	if v12 == "function" then
		return v1
	elseif v12 == "thread" then
		return v2
	elseif p2 then
		return p2
	elseif v12 == "Instance" then
		return "Destroy"
	elseif v12 == "RBXScriptConnection" then
		return "Disconnect"
	else
		if v12 == "table" then
			if typeof(p1.Destroy) == "function" then
				return "Destroy"
			end
			if typeof(p1.Disconnect) == "function" then
				return "Disconnect"
			end
		end
		error("Failed to get cleanup function for object " .. v12 .. ": " .. tostring(p1))
	end
end
local t = {}
t.__index = t
function t.new() --[[ Line: 46 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	v2._objects = {}
	return v2
end
function t.Extend(p1) --[[ Line: 71 | Upvalues: t (copy) ]]
	return p1:Construct(t)
end
function t.Clone(p1, p2) --[[ Line: 79 ]]
	return p1:Add(p2:Clone())
end
function t.Construct(p1, p2, ...) --[[ Line: 116 ]]
	local v1 = nil
	local v2 = type(p2)
	if v2 == "table" then
		v1 = p2.new(...)
	elseif v2 == "function" then
		v1 = p2(...)
	end
	return p1:Add(v1)
end
function t.Connect(p1, p2, p3) --[[ Line: 142 ]]
	return p1:Add(p2:Connect(p3))
end
function t.BindToRenderStep(p1, p2, p3, p4) --[[ Line: 159 | Upvalues: RunService (copy) ]]
	RunService:BindToRenderStep(p2, p3, p4)
	p1:Add(function() --[[ Line: 161 | Upvalues: RunService (ref), p2 (copy) ]]
		RunService:UnbindFromRenderStep(p2)
	end)
end
function t.Add(p1, p2, p3) --[[ Line: 214 | Upvalues: GetObjectCleanupFunction (copy) ]]
	local v1 = GetObjectCleanupFunction(p2, p3)
	table.insert(p1._objects, { p2, v1 })
	return p2
end
function t.Remove(p1, p2) --[[ Line: 230 ]]
	local _objects = p1._objects
	for i, v in ipairs(_objects) do
		if v[1] == p2 then
			local v1 = #_objects
			_objects[i] = _objects[v1]
			_objects[v1] = nil
			p1:_cleanupObject(v[1], v[2])
			return true
		end
	end
	return false
end
function t.Clean(p1) --[[ Line: 249 ]]
	for i, v in ipairs(p1._objects) do
		p1:_cleanupObject(v[1], v[2])
	end
	table.clear(p1._objects)
end
function t._cleanupObject(p1, p2, p3) --[[ Line: 256 | Upvalues: v1 (copy), v2 (copy) ]]
	if p3 == v1 then
		p2()
	elseif p3 == v2 then
		coroutine.close(p2)
	else
		p2[p3](p2)
	end
end
function t.AttachToInstance(p1, p2) --[[ Line: 279 ]]
	assert(p2:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy")
	return p1:Connect(p2.AncestryChanged, function(p12, p2) --[[ Line: 281 | Upvalues: p1 (copy) ]]
		if not p2 then
			p1:Destroy()
		end
	end)
end
function t.Destroy(p1) --[[ Line: 291 ]]
	p1:Clean()
end
return t