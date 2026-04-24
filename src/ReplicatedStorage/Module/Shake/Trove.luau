-- Reviewed by Claude
local v1 = newproxy()
local v2 = newproxy()
local RunService = game:GetService("RunService")
local function GetObjectCleanupFunction(p1, p2)
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
function t.new()
	local v2 = setmetatable({}, t)
	v2._objects = {}
	return v2
end
function t.Extend(p1)
	return p1:Construct(t)
end
function t.Clone(p1, p2)
	return p1:Add(p2:Clone())
end
function t.Construct(p1, p2, ...)
	local v1 = nil
	local v2 = type(p2)
	if v2 == "table" then
		v1 = p2.new(...)
	elseif v2 == "function" then
		v1 = p2(...)
	end
	return p1:Add(v1)
end
function t.Connect(p1, p2, p3)
	return p1:Add(p2:Connect(p3))
end
function t.BindToRenderStep(p1, p2, p3, p4)
	RunService:BindToRenderStep(p2, p3, p4)
	p1:Add(function()
		RunService:UnbindFromRenderStep(p2)
	end)
end
function t.Add(p1, p2, p3)
	local v1 = GetObjectCleanupFunction(p2, p3)
	table.insert(p1._objects, { p2, v1 })
	return p2
end
function t.Remove(p1, p2)
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
function t.Clean(p1)
	for i, v in ipairs(p1._objects) do
		p1:_cleanupObject(v[1], v[2])
	end
	table.clear(p1._objects)
end
function t._cleanupObject(p1, p2, p3)
	if p3 == v1 then
		p2()
	elseif p3 == v2 then
		coroutine.close(p2)
	else
		p2[p3](p2)
	end
end
function t.AttachToInstance(p1, p2)
	assert(p2:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy")
	return p1:Connect(p2.AncestryChanged, function(p12, p2)
		if not p2 then
			p1:Destroy()
		end
	end)
end
function t.Destroy(p1)
	p1:Clean()
end
return t
