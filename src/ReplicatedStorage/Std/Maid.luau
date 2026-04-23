local t = {
	ClassName = "Maid"
}
function t.new() --[[ Line: 13 | Upvalues: t (copy) ]]
	return setmetatable({
		_tasks = {}
	}, t)
end
local function validateTask(p1) --[[ Line: 19 ]]
	if typeof(p1) == "RBXScriptSignal" then
		error("Task cannot be a RBXScriptSignal, did you mean RBXScriptConnection?", 2)
	end
	if type(p1) == "table" and not p1.Destroy then
		error("[Maid.GiveTask] - Gave table task without .Destroy\n\n", 2)
	end
end
function t._doTask(p1, p2) --[[ Line: 30 ]]
	if typeof(p2) == "function" then
		p2()
	elseif typeof(p2) == "RBXScriptConnection" then
		p2:Disconnect()
	elseif typeof(p2) == "thread" then
		task.cancel(p2)
	elseif p2.Destroy then
		p2:Destroy()
	else
		warn("[Maid.DoCleaning] - Unable to clean task of type", (typeof(p2)))
	end
end
function t.isMaid(p1) --[[ Line: 44 ]]
	return if type(p1) == "table" then p1.ClassName == "Maid" else false
end
function t.__index(p1, p2) --[[ Line: 50 | Upvalues: t (copy) ]]
	if t[p2] then
		return t[p2]
	else
		return p1._tasks[p2]
	end
end
function t.__newindex(p1, p2, p3) --[[ Line: 67 | Upvalues: t (copy) ]]
	if t[p2] ~= nil then
		error(("\'%s\' is reserved"):format((tostring(p2))), 2)
	end
	local _tasks = p1._tasks
	local v1 = _tasks[p2]
	if p3 then
		if typeof(p3) == "RBXScriptSignal" then
			error("Task cannot be a RBXScriptSignal, did you mean RBXScriptConnection?", 2)
		end
		if type(p3) == "table" and not p3.Destroy then
			error("[Maid.GiveTask] - Gave table task without .Destroy\n\n", 2)
		end
	end
	_tasks[p2] = p3
	if v1 then
		p1:_doTask(v1)
	end
end
function t.GiveTask(p1, p2) --[[ Line: 100 ]]
	if not p2 then
		error("Task cannot be false or nil", 2)
	end
	if typeof(p2) == "RBXScriptSignal" then
		error("Task cannot be a RBXScriptSignal, did you mean RBXScriptConnection?", 2)
	end
	if type(p2) == "table" and not p2.Destroy then
		error("[Maid.GiveTask] - Gave table task without .Destroy\n\n", 2)
	end
	local v1 = #p1._tasks + 1
	p1[v1] = p2
	return v1
end
function t.GivePromise(p1, p2) --[[ Line: 114 ]]
	local v1 = getmetatable(p2)
	if p2:getStatus() == v1.Status.Started then
		local v2 = p1:GiveTask(function() --[[ Line: 121 | Upvalues: p2 (copy) ]]
			p2:cancel()
		end)
		p2:finally(function() --[[ Line: 124 | Upvalues: p1 (copy), v2 (copy) ]]
			p1[v2] = nil
		end)
	end
	return p2
end
function t.DoCleaning(p1) --[[ Line: 147 ]]
	local _tasks = p1._tasks
	for k, v in pairs(_tasks) do
		if typeof(v) == "RBXScriptConnection" or typeof(v) == "thread" then
			_tasks[k] = nil
			p1:_doTask(v)
		end
	end
	local v1, v2 = next(_tasks)
	while v2 ~= nil do
		_tasks[v1] = nil
		p1:_doTask(v2)
		local v3, v4 = next(_tasks)
		v2, v1 = v4, v3
	end
end
t.Destroy = t.DoCleaning
return t