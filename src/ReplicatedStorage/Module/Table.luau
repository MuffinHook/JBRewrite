local function deepCopy(inputTable)
	if type(inputTable) == "table" then
		local copiedTable = {}
		for key, value in next, inputTable do
			copiedTable[deepCopy(key)] = deepCopy(value)
		end
		setmetatable(copiedTable, deepCopy((getmetatable(inputTable))))
		return copiedTable
	else
		return inputTable
	end
end
return {
	DeepCopy = deepCopy,
	Concat = function(targetArray, sourceArray)
		for i = 1, #sourceArray do
			targetArray[#targetArray + 1] = sourceArray[i]
		end
		return targetArray
	end
}
