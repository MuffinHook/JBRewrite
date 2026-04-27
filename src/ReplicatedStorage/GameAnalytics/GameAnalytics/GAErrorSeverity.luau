local function readonlytable(sourceTable)
	return setmetatable({}, {
		__index = sourceTable,
		__metatable = false,
		__newindex = function(readonlyTable, attemptedKey, attemptedValue)
			error("Attempt to modify read-only table: " .. readonlyTable .. ", key=" .. attemptedKey .. ", value=" .. attemptedValue)
		end
	})
end
return readonlytable({
	debug = "debug",
	info = "info",
	warning = "warning",
	error = "error",
	critical = "critical"
})
