-- Reviewed by Claude
local function readonlytable(p1)
	return setmetatable({}, {
		__index = p1,
		__metatable = false,
		__newindex = function(p1, p2, p3)
			error("Attempt to modify read-only table: " .. p1 .. ", key=" .. p2 .. ", value=" .. p3)
		end
	})
end
return readonlytable({
	Source = "Source",
	Sink = "Sink"
})
