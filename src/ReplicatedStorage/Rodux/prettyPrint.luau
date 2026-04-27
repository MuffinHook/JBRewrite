local function prettyPrintValue(value, indentLevel)
	local indentSize = indentLevel or 0
	local resultParts = {}
	if typeof(value) == "table" then
 table.insert(resultParts, "{\n")
 for k, v in pairs(value) do
 table.insert(resultParts, (" "):rep(indentSize + 1))
 table.insert(resultParts, (tostring(k)))
 table.insert(resultParts, " = ")
 table.insert(resultParts, prettyPrintValue(v, indentSize + 1))
 table.insert(resultParts, "\n")
 end
 table.insert(resultParts, (" "):rep(indentSize))
 table.insert(resultParts, "}")
	elseif typeof(value) == "string" then
 table.insert(resultParts, string.format("%q", value))
 table.insert(resultParts, " (string)")
	else
 table.insert(resultParts, (tostring(value)))
 table.insert(resultParts, " (")
 table.insert(resultParts, (typeof(value)))
 table.insert(resultParts, ")")
	end
	return table.concat(resultParts, "")
end
return prettyPrintValue
