-- Reviewed by Claude
-- variables reassigned
return {
	isStringNullOrEmpty = function(self, inputString)
		return not inputString or #inputString == 0
	end,
	stringArrayContainsString = function(self, stringArray, searchString)
		if #stringArray ~= 0 then
			for i, v in ipairs(stringArray) do
				if v == searchString then
					return true
				end
			end
		end
		return false
	end,
	copyTable = function(self, sourceTable)
		local copiedTable = {}
		for k, v in pairs(sourceTable) do
			if typeof(v) == "table" then
				copiedTable[k] = self:copyTable(v)
			else
				copiedTable[k] = v
			end
		end
		return copiedTable
	end
}
