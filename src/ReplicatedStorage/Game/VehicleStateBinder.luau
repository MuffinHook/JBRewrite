local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StreamingHelperUtils = require(ReplicatedStorage.App.StreamingHelperUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1) --[[ Line: 11 | Upvalues: BaseObject (copy), t (copy), StreamingHelperUtils (copy), TableUtils (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local v3 = 0
	local v4 = nil
	local function update() --[[ Line: 16 | Upvalues: v3 (ref), v4 (ref), StreamingHelperUtils (ref), p1 (copy), TableUtils (ref), v1 (copy) ]]
		local v12 = v3 + 1
		v3 = v12
		if v4 then
			task.cancel(v4)
			v4 = nil
		end
		v4 = task.delay(0.1, function() --[[ Line: 23 | Upvalues: v12 (copy), v3 (ref), StreamingHelperUtils (ref), p1 (ref), TableUtils (ref), v1 (ref) ]]
			if v12 == v3 then
				StreamingHelperUtils.yieldForAllValuesPopulated(p1)
				if v12 == v3 then
					v1.packet = TableUtils.createTableFromObjectValues(p1)
				end
			end
		end)
	end
	v1.maid:GiveTask(p1.DescendantAdded:Connect(function(p12) --[[ Line: 35 | Upvalues: v3 (ref), v4 (ref), StreamingHelperUtils (ref), p1 (copy), TableUtils (ref), v1 (copy) ]]
		if p12:IsA("ValueBase") then
			local v12 = v3 + 1
			v3 = v12
			if v4 then
				task.cancel(v4)
				v4 = nil
			end
			v4 = task.delay(0.1, function() --[[ Line: 23 | Upvalues: v12 (copy), v3 (ref), StreamingHelperUtils (ref), p1 (ref), TableUtils (ref), v1 (ref) ]]
				if v12 == v3 then
					StreamingHelperUtils.yieldForAllValuesPopulated(p1)
					if v12 == v3 then
						v1.packet = TableUtils.createTableFromObjectValues(p1)
					end
				end
			end)
		end
	end))
	local v5 = v3 + 1
	v3 = v5
	if v4 then
		task.cancel(v4)
		v4 = nil
	end
	v4 = task.delay(0.1, function() --[[ Line: 23 | Upvalues: v5 (copy), v3 (ref), StreamingHelperUtils (ref), p1 (copy), TableUtils (ref), v1 (copy) ]]
		if v5 == v3 then
			StreamingHelperUtils.yieldForAllValuesPopulated(p1)
			if v5 == v3 then
				v1.packet = TableUtils.createTableFromObjectValues(p1)
			end
		end
	end)
	return v1
end
return Binder.new("VehicleState", t)