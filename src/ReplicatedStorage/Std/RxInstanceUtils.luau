local Promise = require(script.Parent.Promise)
local Maid = require(script.Parent.Maid)
local rxInstanceUtils = {
	waitForChild = require(script.Parent.waitForChild)
}
local function defaultValidator()
	return true
end
function rxInstanceUtils.waitForProperty(instance, propertyName, validator)
	if validator == nil then
		validator = defaultValidator
	end
	local validationFunction = validator
	return Promise.new(function(resolvePromise, rejectPromise, onCancel)
		if instance[propertyName] and validationFunction(instance[propertyName]) then
			resolvePromise(instance[propertyName])
		else
			local connection = nil
			connection = instance:GetPropertyChangedSignal(propertyName):Connect(function()
				if instance[propertyName] and validationFunction(instance[propertyName]) then
					connection:Disconnect()
					connection = nil
					resolvePromise(instance[propertyName])
				end
			end)
			onCancel(function()
				connection:Disconnect()
				connection = nil
			end)
		end
	end)
end
function rxInstanceUtils.observeProperty(instance, propertyName, callback)
	local lifecycle = Maid.new()
	lifecycle._property = Maid.new()
	callback(instance[propertyName], lifecycle._property)
	lifecycle:GiveTask(instance:GetPropertyChangedSignal(propertyName):Connect(function()
		lifecycle._property:DoCleaning()
		callback(instance[propertyName], lifecycle._property)
	end))
	return lifecycle
end
function rxInstanceUtils.observeAttribute(instance, attributeName, callback)
	local lifecycle = Maid.new()
	lifecycle._property = Maid.new()
	callback(instance:GetAttribute(attributeName), lifecycle._property)
	lifecycle:GiveTask(instance:GetAttributeChangedSignal(attributeName):Connect(function()
		lifecycle._property:DoCleaning()
		callback(instance:GetAttribute(attributeName), lifecycle._property)
	end))
	return lifecycle
end
function rxInstanceUtils.observeChildren(instance, callback)
	local lifecycle = Maid.new()
	local function handleChildAdded(child)
		assert(lifecycle[child] == nil)
		local childMaid = Maid.new()
		lifecycle[child] = childMaid
		callback(child, childMaid)
	end
	for i, child in ipairs(instance:GetChildren()) do
		local isNewChild
		isNewChild = lifecycle[child] == nil
		assert(isNewChild)
		local childMaid = Maid.new()
		lifecycle[child] = childMaid
		callback(child, childMaid)
	end
	lifecycle:GiveTask(instance.ChildAdded:Connect(handleChildAdded))
	lifecycle:GiveTask(instance.ChildRemoved:Connect(function(child)
		lifecycle[child] = nil
	end))
	return lifecycle
end
function rxInstanceUtils.observeChildrenNamed(instance, childName, callback)
	local lifecycle = Maid.new()
	local function handleChildAdded(child)
		if child.Name == childName then
			assert(lifecycle[child] == nil)
			local childMaid = Maid.new()
			lifecycle[child] = childMaid
			callback(child, childMaid)
		end
	end
	for i, child in ipairs(instance:GetChildren()) do
		local childMaid
		if child.Name == childName then
			childMaid = lifecycle[child] == nil
			assert(childMaid)
			local newChildMaid = Maid.new()
			lifecycle[child] = newChildMaid
			callback(child, newChildMaid)
		end
	end
	lifecycle:GiveTask(instance.ChildAdded:Connect(handleChildAdded))
	lifecycle:GiveTask(instance.ChildRemoved:Connect(function(child)
		lifecycle[child] = nil
	end))
	return lifecycle
end
function rxInstanceUtils.observeOneChildNamed(instance, childName, callback)
	local lifecycle = Maid.new()
	local function handleChildAdded(child)
		assert(lifecycle[child] == nil)
		local childMaid = Maid.new()
		lifecycle[child] = childMaid
		callback(child, childMaid)
	end
	local setupListener = nil
	local cleanupListener = nil
	local function check()
		local foundChild = instance:FindFirstChild(childName)
		if foundChild then
			assert(lifecycle[foundChild] == nil)
			local foundChildMaid = Maid.new()
			lifecycle[foundChild] = foundChildMaid
			callback(foundChild, foundChildMaid)
			cleanupListener()
		else
			setupListener()
		end
	end
	setupListener = function()
		lifecycle.childAdded = instance.ChildAdded:Connect(function(child)
			if child.Name == childName then
				lifecycle.childAdded = nil
				local foundChild = instance:FindFirstChild(childName)
				if foundChild then
					assert(lifecycle[foundChild] == nil)
					local foundChildMaid = Maid.new()
					lifecycle[foundChild] = foundChildMaid
					callback(foundChild, foundChildMaid)
					cleanupListener()
					return
				end
				setupListener()
			end
		end)
	end
	cleanupListener = function()
		lifecycle.childRemoved = instance.ChildRemoved:Connect(function(child)
			if lifecycle[child] then
				lifecycle[child] = nil
				lifecycle.childRemoved = nil
				local foundChild = instance:FindFirstChild(childName)
				if foundChild then
					assert(lifecycle[foundChild] == nil)
					local foundChildMaid = Maid.new()
					lifecycle[foundChild] = foundChildMaid
					callback(foundChild, foundChildMaid)
					cleanupListener()
					return
				end
				setupListener()
			end
		end)
	end
	local initialChild = instance:FindFirstChild(childName)
	if initialChild then
		assert(lifecycle[initialChild] == nil)
		local initialChildMaid = Maid.new()
		lifecycle[initialChild] = initialChildMaid
		callback(initialChild, initialChildMaid)
		cleanupListener()
	else
		setupListener()
	end
	return lifecycle
end
function rxInstanceUtils.observeDescendants(instance, callback)
	local lifecycle = Maid.new()
	local function handleDescendantAdded(descendant)
		assert(lifecycle[descendant] == nil)
		local descendantMaid = Maid.new()
		lifecycle[descendant] = descendantMaid
		callback(descendant, descendantMaid)
	end
	for i, descendant in ipairs(instance:GetDescendants()) do
		local isNewDescendant
		isNewDescendant = lifecycle[descendant] == nil
		assert(isNewDescendant)
		local descendantMaid = Maid.new()
		lifecycle[descendant] = descendantMaid
		callback(descendant, descendantMaid)
	end
	lifecycle:GiveTask(instance.DescendantAdded:Connect(handleDescendantAdded))
	lifecycle:GiveTask(instance.DescendantRemoving:Connect(function(descendant)
		if lifecycle[descendant] then
			lifecycle[descendant] = nil
		end
	end))
	return lifecycle
end
function rxInstanceUtils.waitForAttribute(instance, attributeName)
	return Promise.new(function(resolvePromise, rejectPromise, onCancel)
		local attributeValue = instance:GetAttribute(attributeName)
		if attributeValue == nil then
			local connection = nil
			if not onCancel(function()
				if connection then
					connection:Disconnect()
					connection = nil
				end
			end) then
				connection = instance:GetAttributeChangedSignal(attributeName):Connect(function()
					attributeValue = instance:GetAttribute(attributeName)
					if attributeValue ~= nil then
						resolvePromise(attributeValue)
					end
				end)
			end
		else
			resolvePromise(attributeValue)
			return
		end
	end)
end
function rxInstanceUtils.yieldForProperty(instance, propertyName)
	if not instance[propertyName] then
		local runningCoroutine = coroutine.running()
		local lifecycle = Maid.new()
		lifecycle:GiveTask(instance:GetPropertyChangedSignal(propertyName):Connect(function()
			if instance[propertyName] then
				lifecycle:DoCleaning()
				task.spawn(runningCoroutine)
			end
		end))
		local timeoutMessage = debug.traceback("[yieldForProperty] Timeout on " .. instance:GetFullName() .. "." .. propertyName, 2)
		lifecycle:GiveTask(task.delay(5, function()
			warn(timeoutMessage)
			task.defer(lifecycle.DoCleaning, lifecycle)
		end))
		coroutine.yield()
	end
end
return rxInstanceUtils
