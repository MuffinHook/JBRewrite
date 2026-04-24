-- Reviewed by Claude
-- variables reassigned
local tableObj = {
	internalTypeChecks = false,
	typeChecks = false,
	elementTracing = false,
	propValidation = false
}
local tableObj = {}
for k in pairs(tableObj) do
	table.insert(tableObj, k)
end
local tbl2 = {}
function tbl2.new()
	local tbl3 = {}
	tbl3._currentConfig = setmetatable({}, {
		__index = function(self, callback)
			error(("Invalid global configuration key %q. Valid configuration keys are: %s"):format(tostring(callback), table.concat(tableObj, ", ")), 3)
		end
	})
	function tbl3.set(...)
		return tbl2.set(tbl3, ...)
	end
	function tbl3.get(...)
		return tbl2.get(tbl3, ...)
	end
	function tbl3.scoped(...)
		return tbl2.scoped(tbl3, ...)
	end
	tbl3.set(tableObj)
	return tbl3
end
function tbl2.set(self, callback)
	for k, v in pairs(callback) do
		if tableObj[k] == nil then
			error(("Invalid global configuration key %q (type %s). Valid configuration keys are: %s"):format(tostring(k), typeof(k), table.concat(tableObj, ", ")), 3)
		end
		if typeof(v) ~= "boolean" then
			error(("Invalid value %q (type %s) for global configuration key %q. Valid values are: true, false"):format(tostring(v), typeof(v), (tostring(k))), 3)
		end
		self._currentConfig[k] = v
	end
end
function tbl2.get(self)
	return self._currentConfig
end
function tbl2.scoped(self, callback, self)
	local tableObj = {}
	for k, v in pairs(self._currentConfig) do
		tableObj[k] = v
	end
	self.set(callback)
	local var1, var2 = pcall(self)
	self.set(tableObj)
	assert(var1, var2)
end
return tbl2
