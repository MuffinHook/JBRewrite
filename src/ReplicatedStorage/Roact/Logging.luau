-- Reviewed by Claude
-- variables reassigned
local count = true
local tableObj = {}
local tbl2 = {}
local function indent(self, callback)
	local count = ("\tableObj"):rep(callback)
	return count .. self:gsub("\n", "\n" .. count)
end
local function indentLines(self, callback)
	local tableObj = {}
	for i, v in ipairs(self) do
 local count = ("\tableObj"):rep(callback)
 table.insert(tableObj, count .. v:gsub("\n", "\n" .. count))
	end
	return table.concat(tableObj, "\n")
end
local metadata = {
	__tostring = function(self)
 local tableObj = { "LogInfo {" }
 local count = #self.errors
 local count2 = #self.warnings
 local count3 = #self.infos
 if count + count2 + count3 == 0 then
 table.insert(tableObj, "\tableObj(no messages)")
 end
 if count > 0 then
 table.insert(tableObj, ("\tErrors (%d) {"):format(count))
 table.insert(tableObj, indentLines(self.errors, 2))
 table.insert(tableObj, "\tableObj}")
 end
 if count2 > 0 then
 table.insert(tableObj, ("\tWarnings (%d) {"):format(count2))
 table.insert(tableObj, indentLines(self.warnings, 2))
 table.insert(tableObj, "\tableObj}")
 end
 if count3 > 0 then
 table.insert(tableObj, ("\tInfos (%d) {"):format(count3))
 table.insert(tableObj, indentLines(self.infos, 2))
 table.insert(tableObj, "\tableObj}")
 end
 table.insert(tableObj, "}")
 return table.concat(tableObj, "\n")
	end
}
local function createLogInfo()
	local tableObj = {
 errors = {},
 warnings = {},
 infos = {}
	}
	setmetatable(tableObj, metadata)
	return tableObj
end
local tbl4 = {
	capture = function(self)
 local internalData = createLogInfo()
 local count2 = count
 count = false
 tableObj[internalData] = true
 local count3, currentState = pcall(self)
 tableObj[internalData] = nil
 count = count2
 assert(count3, currentState)
 return internalData
	end,
	warn = function(self, ...)
 local internalData = self:format(...)
 for k in pairs(tableObj) do
 table.insert(k.warnings, internalData)
 end
 local count2 = debug.traceback("", 2):sub(2)
 local count3 = ("\tableObj"):rep(1)
 local currentState = ("%s\n%s"):format(internalData, count3 .. count2:gsub("\n", "\n" .. count3))
 if count then
 warn(currentState)
 end
	end
}
function tbl4.warnOnce(self, ...)
	local count = debug.traceback()
	if not tbl2[count] then
 tbl2[count] = true
 tbl4.warn(self, ...)
	end
end
return tbl4
