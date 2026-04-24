-- Reviewed by Claude
local Logging = require(script.Parent.Logging)
local t = {
	Disabled = "Disabled",
	Suspended = "Suspended",
	Enabled = "Enabled"
}
local t2 = {}
t2.__index = t2
function t2.new(p1)
	return setmetatable({
 _suspendedEventQueue = {},
 _connections = {},
 _listeners = {},
 _status = t.Disabled,
 _isResuming = false,
 _instance = p1
	}, t2)
end
function t2.connectEvent(p1, p2, p3)
	p1:_connect(p2, p1._instance[p2], p3)
end
function t2.connectPropertyChange(p1, p2, p3)
	local v1, v2 = pcall(function()
 return p1._instance:GetPropertyChangedSignal(p2)
	end)
	if not v1 then
 error(("Cannot get changed signal on property %q: %s"):format(tostring(p2), v2), 0)
	end
	p1:_connect("Change." .. p2, v2, p3)
end
function t2._connect(p1, p2, p3, p4)
	if p4 == nil then
 if p1._connections[p2] ~= nil then
 p1._connections[p2]:Disconnect()
 p1._connections[p2] = nil
 end
 p1._listeners[p2] = nil
	else
 if p1._connections[p2] == nil then
 p1._connections[p2] = p3:Connect(function(...)
 if p1._status == t.Enabled then
 p1._listeners[p2](p1._instance, ...)
 elseif p1._status == t.Suspended then
 local v1 = select("#", ...)
 table.insert(p1._suspendedEventQueue, { p2, v1, ... })
 end
 end)
 end
 p1._listeners[p2] = p4
	end
end
function t2.suspend(p1)
	p1._status = t.Suspended
end
function t2.resume(p1)
	if not p1._isResuming then
 p1._isResuming = true
 local count = 1
 while count <= #p1._suspendedEventQueue do
 local v1 = p1._suspendedEventQueue[count]
 local v2 = p1._listeners[v1[1]]
 local v3 = v1[2]
 if v2 ~= nil then
 local v5, v6 = coroutine.resume(coroutine.create(v2), p1._instance, unpack(v1, 3, 2 + v3))
 if not v5 then
 Logging.warn("%s", v6)
 end
 end
 count = count + 1
 end
 p1._isResuming = false
 p1._status = t.Enabled
 p1._suspendedEventQueue = {}
	end
end
return t2