local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StreamingHelperUtils = require(ReplicatedStorage.App.StreamingHelperUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(stateContainer)
	local instance = BaseObject.new(stateContainer)
	setmetatable(instance, t)
	local updateCounter = 0
	local delayTask = nil
	local function update()
		local updateVersion = updateCounter + 1
		updateCounter = updateVersion
		if delayTask then
			task.cancel(delayTask)
			delayTask = nil
		end
		delayTask = task.delay(0.1, function()
			if updateVersion == updateCounter then
				StreamingHelperUtils.yieldForAllValuesPopulated(stateContainer)
				if updateVersion == updateCounter then
					instance.packet = TableUtils.createTableFromObjectValues(stateContainer)
				end
			end
		end)
	end
	instance.maid:GiveTask(stateContainer.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("ValueBase") then
			local updateVersion = updateCounter + 1
			updateCounter = updateVersion
			if delayTask then
				task.cancel(delayTask)
				delayTask = nil
			end
			delayTask = task.delay(0.1, function()
				if updateVersion == updateCounter then
					StreamingHelperUtils.yieldForAllValuesPopulated(stateContainer)
					if updateVersion == updateCounter then
						instance.packet = TableUtils.createTableFromObjectValues(stateContainer)
					end
				end
			end)
		end
	end))
	local initialUpdateCounter = updateCounter + 1
	updateCounter = initialUpdateCounter
	if delayTask then
		task.cancel(delayTask)
		delayTask = nil
	end
	delayTask = task.delay(0.1, function()
		if initialUpdateCounter == updateCounter then
			StreamingHelperUtils.yieldForAllValuesPopulated(stateContainer)
			if initialUpdateCounter == updateCounter then
				instance.packet = TableUtils.createTableFromObjectValues(stateContainer)
			end
		end
	end)
	return instance
end
return Binder.new("VehicleState", t)
