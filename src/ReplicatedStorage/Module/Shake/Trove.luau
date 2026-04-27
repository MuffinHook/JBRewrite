local functionProxy = newproxy()
local threadProxy = newproxy()
local RunService = game:GetService("RunService")
local function GetObjectCleanupFunction(objectToClean, customCleanupFunction)
	local objectType = typeof(objectToClean)
	if objectType == "function" then
		return functionProxy
	elseif objectType == "thread" then
		return threadProxy
	elseif customCleanupFunction then
		return customCleanupFunction
	elseif objectType == "Instance" then
		return "Destroy"
	elseif objectType == "RBXScriptConnection" then
		return "Disconnect"
	else
		if objectType == "table" then
			if typeof(objectToClean.Destroy) == "function" then
				return "Destroy"
			end
			if typeof(objectToClean.Disconnect) == "function" then
				return "Disconnect"
			end
		end
		error("Failed to get cleanup function for object " .. objectType .. ": " .. tostring(objectToClean))
	end
end
local Trove = {}
Trove.__index = Trove
function Trove.new()
	local self = setmetatable({}, Trove)
	self._objects = {}
	return self
end
function Trove.Extend(self)
	return self:Construct(Trove)
end
function Trove.Clone(self, objectToClone)
	return self:Add(objectToClone:Clone())
end
function Trove.Construct(self, constructorOrTable, ...)
	local constructedObject = nil
	local constructorType = type(constructorOrTable)
	if constructorType == "table" then
		constructedObject = constructorOrTable.new(...)
	elseif constructorType == "function" then
		constructedObject = constructorOrTable(...)
	end
	return self:Add(constructedObject)
end
function Trove.Connect(self, signal, callback)
	return self:Add(signal:Connect(callback))
end
function Trove.BindToRenderStep(self, bindName, priority, callback)
	RunService:BindToRenderStep(bindName, priority, callback)
	self:Add(function()
		RunService:UnbindFromRenderStep(bindName)
	end)
end
function Trove.Add(self, objectToAdd, customCleanupFunction)
	local cleanupFunction = GetObjectCleanupFunction(objectToAdd, customCleanupFunction)
	table.insert(self._objects, { objectToAdd, cleanupFunction })
	return objectToAdd
end
function Trove.Remove(self, objectToRemove)
	local objectsList = self._objects
	for i, objectEntry in ipairs(objectsList) do
		if objectEntry[1] == objectToRemove then
			local lastIndex = #objectsList
			objectsList[i] = objectsList[lastIndex]
			objectsList[lastIndex] = nil
			self:_cleanupObject(objectEntry[1], objectEntry[2])
			return true
		end
	end
	return false
end
function Trove.Clean(self)
	for i, objectEntry in ipairs(self._objects) do
		self:_cleanupObject(objectEntry[1], objectEntry[2])
	end
	table.clear(self._objects)
end
function Trove._cleanupObject(self, objectToClean, cleanupMethod)
	if cleanupMethod == functionProxy then
		objectToClean()
	elseif cleanupMethod == threadProxy then
		coroutine.close(objectToClean)
	else
		objectToClean[cleanupMethod](objectToClean)
	end
end
function Trove.AttachToInstance(self, instanceToMonitor)
	assert(instanceToMonitor:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy")
	return self:Connect(instanceToMonitor.AncestryChanged, function(changedInstance, parent)
		if not parent then
			self:Destroy()
		end
	end)
end
function Trove.Destroy(self)
	self:Clean()
end
return Trove
