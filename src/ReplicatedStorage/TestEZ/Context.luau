-- Reviewed by Claude
-- variables reassigned
return {
	new = function(parentContext)
		local contextMeta = {}
		local contextData = {}
		contextMeta.__index = contextData
		if parentContext then
			for k, v in pairs(getmetatable(parentContext).__index) do
				contextData[k] = v
			end
		end
		function contextMeta.__newindex(self, key, value)
			assert(contextData[key] == nil, string.format("Cannot reassign %s in context", (tostring(key))))
			contextData[key] = value
		end
		return setmetatable({}, contextMeta)
	end
}
