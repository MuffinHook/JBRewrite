-- Reviewed by Claude
local count = true
local tbl = {}
local tbl2 = {}
local function indent(p1, p2)
	local count = ("\tbl"):rep(p2)
	return count .. p1:gsub("\n", "\n" .. count)
end
local function indentLines(p1, p2)
	local tbl = {}
	for i, v in ipairs(p1) do
 local count = ("\tbl"):rep(p2)
 table.insert(tbl, count .. v:gsub("\n", "\n" .. count))
	end
	return table.concat(tbl, "\n")
end
local t3 = {
	__tostring = function(p1)
 local tbl = { "LogInfo {" }
 local count = #p1.errors
 local count2 = #p1.warnings
 local count3 = #p1.infos
 if count + count2 + count3 == 0 then
 table.insert(tbl, "\tbl(no messages)")
 end
 if count > 0 then
 table.insert(tbl, ("\tErrors (%d) {"):format(count))
 table.insert(tbl, indentLines(p1.errors, 2))
 table.insert(tbl, "\tbl}")
 end
 if count2 > 0 then
 table.insert(tbl, ("\tWarnings (%d) {"):format(count2))
 table.insert(tbl, indentLines(p1.warnings, 2))
 table.insert(tbl, "\tbl}")
 end
 if count3 > 0 then
 table.insert(tbl, ("\tInfos (%d) {"):format(count3))
 table.insert(tbl, indentLines(p1.infos, 2))
 table.insert(tbl, "\tbl}")
 end
 table.insert(tbl, "}")
 return table.concat(tbl, "\n")
	end
}
local function createLogInfo()
	local tbl = {
 errors = {},
 warnings = {},
 infos = {}
	}
	setmetatable(tbl, t3)
	return tbl
end
local t4 = {
	capture = function(p1)
 local v12 = createLogInfo()
 local count2 = count
 count = false
 tbl[v12] = true
 local count3, v4 = pcall(p1)
 tbl[v12] = nil
 count = count2
 assert(count3, v4)
 return v12
	end,
	warn = function(p1, ...)
 local v12 = p1:format(...)
 for k in pairs(tbl) do
 table.insert(k.warnings, v12)
 end
 local count2 = debug.traceback("", 2):sub(2)
 local count3 = ("\tbl"):rep(1)
 local v4 = ("%s\n%s"):format(v12, count3 .. count2:gsub("\n", "\n" .. count3))
 if count then
 warn(v4)
 end
	end
}
function t4.warnOnce(p1, ...)
	local count = debug.traceback()
	if not tbl2[count] then
 tbl2[count] = true
 t4.warn(p1, ...)
	end
end
return t4