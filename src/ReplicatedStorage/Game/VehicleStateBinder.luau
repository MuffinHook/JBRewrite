-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StreamingHelperUtils = require(ReplicatedStorage.App.StreamingHelperUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local instance = BaseObject.new(p1)
	setmetatable(instance, t)
	local var3 = 0
	local var4 = nil
	local function update()
		local var12 = var3 + 1
		var3 = var12
		if var4 then
			task.cancel(var4)
			var4 = nil
		end
		var4 = task.delay(0.1, function()
			if var12 == var3 then
				StreamingHelperUtils.yieldForAllValuesPopulated(p1)
				if var12 == var3 then
					instance.packet = TableUtils.createTableFromObjectValues(p1)
				end
			end
		end)
	end
	instance.maid:GiveTask(p1.DescendantAdded:Connect(function(p12)
		if p12:IsA("ValueBase") then
			local var12 = var3 + 1
			var3 = var12
			if var4 then
				task.cancel(var4)
				var4 = nil
			end
			var4 = task.delay(0.1, function()
				if var12 == var3 then
					StreamingHelperUtils.yieldForAllValuesPopulated(p1)
					if var12 == var3 then
						instance.packet = TableUtils.createTableFromObjectValues(p1)
					end
				end
			end)
		end
	end))
	local var5 = var3 + 1
	var3 = var5
	if var4 then
		task.cancel(var4)
		var4 = nil
	end
	var4 = task.delay(0.1, function()
		if var5 == var3 then
			StreamingHelperUtils.yieldForAllValuesPopulated(p1)
			if var5 == var3 then
				instance.packet = TableUtils.createTableFromObjectValues(p1)
			end
		end
	end)
	return instance
end
return Binder.new("VehicleState", t)
