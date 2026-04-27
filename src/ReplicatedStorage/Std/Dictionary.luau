local noneValue = newproxy(true)
getmetatable(noneValue).__tostring = function()
	return "None"
end
return {
	None = noneValue,
	merge = function(...)
		local resultTable = {}
		for i = 1, select("#", ...) do
			local sourceTable = select(i, ...)
			if sourceTable ~= nil then
				for k, sourceValue in pairs(sourceTable) do
					if sourceValue == noneValue then
						resultTable[k] = nil
					else
						resultTable[k] = sourceValue
					end
				end
			end
		end
		return resultTable
	end
}
