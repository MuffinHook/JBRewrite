local Maid = {
	ClassName = "Maid"
}
function Maid.new()
	return setmetatable({
		_tasks = {}
	}, Maid)
end
local function validateTask(task)
	if typeof(task) == "RBXScriptSignal" then
		error("Task cannot be a RBXScriptSignal, did you mean RBXScriptConnection?", 2)
	end
	if type(task) == "table" and not task.Destroy then
		error("[Maid.GiveTask] - Gave table task without .Destroy\n\n", 2)
	end
end
function Maid._doTask(self, task)
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
function Maid.isMaid(value)
	return if type(value) == "table" then value.ClassName == "Maid" else false
end
function Maid.__index(self, key)
	if Maid[key] then
		return Maid[key]
	else
		return self._tasks[key]
	end
end
function Maid.__newindex(self, key, newTask)
	if Maid[key] ~= nil then
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
function Maid.GiveTask(self, task)
	if not task then
		error("Task cannot be false or nil", 2)
	end
	if typeof(task) == "RBXScriptSignal" then
		error("Task cannot be a RBXScriptSignal, did you mean RBXScriptConnection?", 2)
	end
	if type(task) == "table" and not task.Destroy then
		error("[Maid.GiveTask] - Gave table task without .Destroy\n\n", 2)
	end
	local nextIndex = #self._tasks + 1
	self[nextIndex] = task
	return nextIndex
end
function Maid.GivePromise(self, promise)
	local promiseMetatable = getmetatable(promise)
	if promise:getStatus() == promiseMetatable.Status.Started then
		local taskIndex = self:GiveTask(function()
			promise:cancel()
		end)
		promise:finally(function()
			self[taskIndex] = nil
		end)
	end
	return promise
end
function Maid.DoCleaning(self)
	local _tasks = self._tasks
	for taskKey, taskValue in pairs(_tasks) do
		if typeof(taskValue) == "RBXScriptConnection" or typeof(taskValue) == "thread" then
			_tasks[taskKey] = nil
			self:_doTask(taskValue)
		end
	end
	local key, value = next(_tasks)
	while value ~= nil do
		_tasks[key] = nil
		self:_doTask(value)
		local nextKey, nextValue = next(_tasks)
		value, key = nextValue, nextKey
	end
end
Maid.Destroy = Maid.DoCleaning
return Maid
