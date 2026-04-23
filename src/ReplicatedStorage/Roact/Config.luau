local tbl = {
	internalTypeChecks = false,
	typeChecks = false,
	elementTracing = false,
	propValidation = false
}
local t = {}
for k in pairs(tbl) do
	table.insert(t, k)
end
local t2 = {}
function t2.new() --[[ Line: 35 | Upvalues: t (copy), t2 (copy), tbl (copy) ]]
	local t3 = {}
	t3._currentConfig = setmetatable({}, {
		__index = function(p1, p2) --[[ Name: __index | Line: 39 | Upvalues: t (ref) ]]
			error(("Invalid global configuration key %q. Valid configuration keys are: %s"):format(tostring(p2), table.concat(t, ", ")), 3)
		end
	})
	function t3.set(...) --[[ Line: 52 | Upvalues: t2 (ref), t3 (copy) ]]
		return t2.set(t3, ...)
	end
	function t3.get(...) --[[ Line: 56 | Upvalues: t2 (ref), t3 (copy) ]]
		return t2.get(t3, ...)
	end
	function t3.scoped(...) --[[ Line: 60 | Upvalues: t2 (ref), t3 (copy) ]]
		return t2.scoped(t3, ...)
	end
	t3.set(tbl)
	return t3
end
function t2.set(p1, p2) --[[ Line: 69 | Upvalues: tbl (copy), t (copy) ]]
	for k, v in pairs(p2) do
		if tbl[k] == nil then
			error(("Invalid global configuration key %q (type %s). Valid configuration keys are: %s"):format(tostring(k), typeof(k), table.concat(t, ", ")), 3)
		end
		if typeof(v) ~= "boolean" then
			error(("Invalid value %q (type %s) for global configuration key %q. Valid values are: true, false"):format(tostring(v), typeof(v), (tostring(k))), 3)
		end
		p1._currentConfig[k] = v
	end
end
function t2.get(p1) --[[ Line: 96 ]]
	return p1._currentConfig
end
function t2.scoped(p1, p2, p3) --[[ Line: 100 ]]
	local t = {}
	for k, v in pairs(p1._currentConfig) do
		t[k] = v
	end
	p1.set(p2)
	local v1, v2 = pcall(p3)
	p1.set(t)
	assert(v1, v2)
end
return t2