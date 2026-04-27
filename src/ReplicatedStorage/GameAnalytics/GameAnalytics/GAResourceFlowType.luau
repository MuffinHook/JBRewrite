local function readonlytable(sourceTable)
	return setmetatable({}, {
		__index = sourceTable,
		__metatable = false,
		__newindex = function(sourceTable, attemptedKey, attemptedValue)
			error("Attempt to modify read-only table: " .. sourceTable .. ", key=" .. attemptedKey .. ", value=" .. attemptedValue)
		end
	})
end
return readonlytable({
	Source = "Source",
	Sink = "Sink"
})
