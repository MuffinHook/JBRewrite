-- Reviewed by Claude
local tbl = {
	internalTypeChecks = false,
	typeChecks = false,
	elementTracing = false,
	propValidation = false
}
local tbl = {}
for k in pairs(tbl) do
	table.insert(tbl, k)
end
local tbl2 = {}
function tbl2.new()
	local tbl3 = {}
	tbl3._currentConfig = setmetatable({}, {
		__index = function(p1, p2)
			error(("Invalid global configuration key %q. Valid configuration keys are: %s"):format(tostring(p2), table.concat(tbl, ", ")), 3)
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
	tbl3.set(tbl)
	return tbl3
end
function tbl2.set(p1, p2)
	for k, v in pairs(p2) do
		if tbl[k] == nil then
			error(("Invalid global configuration key %q (type %s). Valid configuration keys are: %s"):format(tostring(k), typeof(k), table.concat(tbl, ", ")), 3)
		end
		if typeof(v) ~= "boolean" then
			error(("Invalid value %q (type %s) for global configuration key %q. Valid values are: true, false"):format(tostring(v), typeof(v), (tostring(k))), 3)
		end
		p1._currentConfig[k] = v
	end
end
function tbl2.get(p1)
	return p1._currentConfig
end
function tbl2.scoped(p1, p2, p3)
	local tbl = {}
	for k, v in pairs(p1._currentConfig) do
		tbl[k] = v
	end
	p1.set(p2)
	local v1, v2 = pcall(p3)
	p1.set(tbl)
	assert(v1, v2)
end
return tbl2
