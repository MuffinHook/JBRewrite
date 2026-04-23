local v1 = true
local t = {}
local t2 = {}
local function indent(p1, p2) --[[ Line: 24 ]]
	local v1 = ("\t"):rep(p2)
	return v1 .. p1:gsub("\n", "\n" .. v1)
end
local function indentLines(p1, p2) --[[ Line: 34 ]]
	local t = {}
	for i, v in ipairs(p1) do
		local v1 = ("\t"):rep(p2)
		table.insert(t, v1 .. v:gsub("\n", "\n" .. v1))
	end
	return table.concat(t, "\n")
end
local t3 = {
	__tostring = function(p1) --[[ Name: __tostring | Line: 50 | Upvalues: indentLines (copy) ]]
		local t = { "LogInfo {" }
		local v1 = #p1.errors
		local v2 = #p1.warnings
		local v3 = #p1.infos
		if v1 + v2 + v3 == 0 then
			table.insert(t, "\t(no messages)")
		end
		if v1 > 0 then
			table.insert(t, ("\tErrors (%d) {"):format(v1))
			table.insert(t, indentLines(p1.errors, 2))
			table.insert(t, "\t}")
		end
		if v2 > 0 then
			table.insert(t, ("\tWarnings (%d) {"):format(v2))
			table.insert(t, indentLines(p1.warnings, 2))
			table.insert(t, "\t}")
		end
		if v3 > 0 then
			table.insert(t, ("\tInfos (%d) {"):format(v3))
			table.insert(t, indentLines(p1.infos, 2))
			table.insert(t, "\t}")
		end
		table.insert(t, "}")
		return table.concat(t, "\n")
	end
}
local function createLogInfo() --[[ Line: 84 | Upvalues: t3 (copy) ]]
	local t = {
		errors = {},
		warnings = {},
		infos = {}
	}
	setmetatable(t, t3)
	return t
end
local t4 = {
	capture = function(p1) --[[ Name: capture | Line: 105 | Upvalues: createLogInfo (copy), v1 (ref), t (copy) ]]
		local v12 = createLogInfo()
		local v2 = v1
		v1 = false
		t[v12] = true
		local v3, v4 = pcall(p1)
		t[v12] = nil
		v1 = v2
		assert(v3, v4)
		return v12
	end,
	warn = function(p1, ...) --[[ Name: warn | Line: 125 | Upvalues: t (copy), v1 (ref) ]]
		local v12 = p1:format(...)
		for k in pairs(t) do
			table.insert(k.warnings, v12)
		end
		local v2 = debug.traceback("", 2):sub(2)
		local v3 = ("\t"):rep(1)
		local v4 = ("%s\n%s"):format(v12, v3 .. v2:gsub("\n", "\n" .. v3))
		if v1 then
			warn(v4)
		end
	end
}
function t4.warnOnce(p1, ...) --[[ Line: 148 | Upvalues: t2 (copy), t4 (copy) ]]
	local v1 = debug.traceback()
	if not t2[v1] then
		t2[v1] = true
		t4.warn(p1, ...)
	end
end
return t4