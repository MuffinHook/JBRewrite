local insert = table.insert
return function(inputTable)
	if inputTable == nil then
		return "nil"
	end
	if typeof(inputTable) == "table" then
		local resultLines = {}
		local function formatTableRecursively(sourceTable, indentLevel, keyName)
			local indentString = ("\t"):rep(indentLevel)
			if keyName then
				if typeof(keyName) == "string" and (not keyName:find("\"") and (not keyName:find("\'") and keyName:sub(1, 1):match("[%w_]"))) then
					insert(resultLines, ("%s%s = {"):format(indentString, keyName))
				else
					insert(resultLines, ("%s[%q] = {"):format(indentString, keyName))
				end
			else
				insert(resultLines, ("%s{"):format(indentString))
			end
			local sortedEntries = {}
			for iteratorKey, iteratorValue in sourceTable do
				table.insert(sortedEntries, {
					k = iteratorKey,
					v = iteratorValue
				})
			end
			table.sort(sortedEntries, function(entryA, entryB)
				return entryA.k < entryB.k
			end)
			for entryIndex, currentEntry in sortedEntries do
				local formattedValue
				local entryKey = currentEntry.k
				local entryValue = currentEntry.v
				if type(entryValue) == "table" then
					formatTableRecursively(entryValue, indentLevel + 1, entryKey)
				else
					formattedValue = if typeof(entryValue) == "Vector3" then ("Vector3.new(%s)"):format((tostring(entryValue))) elseif typeof(entryValue) == "string" then ("%q"):format(entryValue) elseif typeof(entryValue) == "Instance" then ("[%s]"):format(entryValue:GetFullName()) else tostring(entryValue)
					if typeof(entryKey) == "string" and (not entryKey:find("\"") and (not entryKey:find("\'") and entryKey:sub(1, 1):match("[%w_]"))) then
						insert(resultLines, ("\t%s%s = %s,"):format(indentString, entryKey, formattedValue))
					else
						insert(resultLines, ("\t%s[%q] = %s"):format(indentString, entryKey, formattedValue))
					end
				end
			end
			insert(resultLines, ("%s},"):format(indentString))
		end
		formatTableRecursively(inputTable, 0)
		table.remove(resultLines)
		insert(resultLines, "}")
		return table.concat(resultLines, "\n")
	end
	warn("table2Lua: t must be a table, currently of type: " .. typeof(inputTable))
end
