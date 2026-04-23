-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
return {
	yieldForAllValuesPopulated = function(p1)
		local v1 = coroutine.running()
		for v2, v3 in p1:GetDescendants() do
			if v3:IsA("ValueBase") and v3.Value == nil then
				local v4 = nil
				local v5 = task.delay(5, function()
					v4:Disconnect()
					v4 = nil
					warn("[StreamingHelperUtils] Timed out waiting for value to populate: ", v3:GetFullName())
					task.spawn(v1)
				end)
				v4 = v3.Changed:Connect(function()
					if v3.Value ~= nil then
						v4:Disconnect()
						v4 = nil
						task.cancel(v5)
						v5 = nil
						task.spawn(v1)
					end
				end)
				coroutine.yield()
			end
		end
	end,
	yieldForObjValuePopulated = function(p1)
		local v1 = coroutine.running()
		if p1.Value == nil then
			local v2 = nil
			v2 = p1.Changed:Connect(function()
				if p1.Value ~= nil then
					v2:Disconnect()
					v2 = nil
					task.spawn(v1)
				end
			end)
			coroutine.yield()
		end
	end,
	createTableFromObjectValuesAndListen = function(p1, p2)
		assert(if typeof(p1) == "Instance" then p1:IsA("Folder") else false, "Invalid objectValues passed")
		if not p2 then
			p2 = {}
		end
		local v2 = Maid.new()
		local function v3(p1, p2)
			local function processObject(p1)
				local v1 = p1.Name
				local v22 = if p1:GetAttribute("_TypeOfName") == "number" then tonumber(v1) else v1
				if p1:IsA("Folder") then
					local v32 = p2[v22]
					if not v32 then
						v32 = {}
						p2[v22] = v32
					end
					v3(p1, v32)
				else
					p2[v22] = p1.Value
					v2:GiveTask(p1.Changed:Connect(function()
						p2[v22] = p1.Value
					end))
				end
			end
			for v1, v22 in p1:GetChildren() do
				processObject(v22)
			end
			v2:GiveTask(p1.ChildAdded:Connect(function(p1)
				processObject(p1)
			end))
		end
		v3(p1, p2)
		return p2, v2
	end
}