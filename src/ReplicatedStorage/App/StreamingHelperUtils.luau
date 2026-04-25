-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
return {
	yieldForAllValuesPopulated = function(folder)
		local currentCoroutine = coroutine.running()
		for index, descendant in folder:GetDescendants() do
			if descendant:IsA("ValueBase") and descendant.Value == nil then
				local connection = nil
				local delayTask = task.delay(5, function()
					connection:Disconnect()
					connection = nil
					warn("[StreamingHelperUtils] Timed out waiting for value to populate: ", descendant:GetFullName())
					task.spawn(currentCoroutine)
				end)
				connection = descendant.Changed:Connect(function()
					if descendant.Value ~= nil then
						connection:Disconnect()
						connection = nil
						task.cancel(delayTask)
						delayTask = nil
						task.spawn(currentCoroutine)
					end
				end)
				coroutine.yield()
			end
		end
	end,
	yieldForObjValuePopulated = function(objectValue)
		local currentCoroutine = coroutine.running()
		if objectValue.Value == nil then
			local connection = nil
			connection = objectValue.Changed:Connect(function()
				if objectValue.Value ~= nil then
					connection:Disconnect()
					connection = nil
					task.spawn(currentCoroutine)
				end
			end)
			coroutine.yield()
		end
	end,
	createTableFromObjectValuesAndListen = function(folder, resultTable)
		assert(if typeof(folder) == "Instance" then folder:IsA("Folder") else false, "Invalid objectValues passed")
		if not resultTable then
			resultTable = {}
		end
		local maid = Maid.new()
		local function processRecursive(folder, resultTable)
			local function processObject(instance)
				local name = instance.Name
				local convertedName = if instance:GetAttribute("_TypeOfName") == "number" then tonumber(name) else name
				if instance:IsA("Folder") then
					local folderTable = resultTable[convertedName]
					if not folderTable then
						folderTable = {}
						resultTable[convertedName] = folderTable
					end
					processRecursive(instance, folderTable)
				else
					resultTable[convertedName] = instance.Value
					maid:GiveTask(instance.Changed:Connect(function()
						resultTable[convertedName] = instance.Value
					end))
				end
			end
			for index, instance in folder:GetChildren() do
				processObject(instance)
			end
			maid:GiveTask(folder.ChildAdded:Connect(function(instance)
				processObject(instance)
			end))
		end
		processRecursive(folder, resultTable)
		return resultTable, maid
	end
}