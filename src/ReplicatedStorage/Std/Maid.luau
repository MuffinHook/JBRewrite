-- Reviewed by Claude
-- variables reassigned
local t = {
	ClassName = "Maid"
}
function t.new()
	return setmetatable({
		_tasks = {}
	}, t)
end
local function validateTask(task)
	if typeof(task) == "RBXScriptSignal" then
		error("Task cannot be a RBXScriptSignal, did you mean RBXScriptConnection?", 2)
	end
	if type(task) == "table" and not task.Destroy then
		error("[Maid.GiveTask] - Gave table task without .Destroy\n\n", 2)
	end
end
function t._doTask(self, task)
	if typeof(task) == "function" then
		task()
	elseif typeof(task) == "RBXScriptConnection" then
		task:Disconnect()
	elseif typeof(task) == "thread" then
		task.cancel(task)
	elseif task.Destroy then
		task:Destroy()
	else
		warn("[Maid.DoCleaning] - Unable to clean task of type", (typeof(task)))
	end
end
function t.isMaid(p1)
	return if type(p1) == "table" then p1.ClassName == "Maid" else false
end
function t.__index(self, key)
	if t[key] then
		return t[key]
	else
		return self._tasks[key]
	end
end
function t.__newindex(self, key, newTask)
	if t[key] ~= nil then
		error(("\'%s\' is reserved"):format((tostring(key))), 2)
	end
	local tasks = self._tasks
	local oldTask = tasks[key]
	if newTask then
		if typeof(newTask) == "RBXScriptSignal" then
			error("Task cannot be a RBXScriptSignal, did you mean RBXScriptConnection?", 2)
		end
		if type(newTask) == "table" and not newTask.Destroy then
			error("[Maid.GiveTask] - Gave table task without .Destroy\n\n", 2)
		end
	end
	tasks[key] = newTask
	if oldTask then
		self:_doTask(oldTask)
	end
end
function t.GiveTask(p1, p2)
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
function t.GivePromise(p1, p2)
	local v1 = getmetatable(p2)
	if p2:getStatus() == v1.Status.Started then
		local v2 = p1:GiveTask(function()
			p2:cancel()
		end)
		p2:finally(function()
			p1[v2] = nil
		end)
	end
	return p2
end
function t.DoCleaning(p1)
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
