local TextService = game:GetService("TextService")
local t = {
	MakeDictionary = function(items)
		local result = {}
		for i = 1, #items do
			result[items[i]] = true
		end
		return result
	end,
	DictionaryKeys = function(dictionary)
		local keys = {}
		for k in pairs(dictionary) do
			table.insert(keys, k)
		end
		return keys
	end
}
local function transformInstanceSet(instances)
	local names = {}
	for i = 1, #instances do
		names[i] = instances[i].Name
	end
	return names, instances
end
function t.MakeFuzzyFinder(source)
	local namesTable = nil
	local objectsTable = {}
	if typeof(source) == "Enum" then
		source = source:GetEnumItems()
	end
	if typeof(source) == "Instance" then
		local children = source:GetChildren()
		local childNames = {}
		for i = 1, #children do
			childNames[i] = children[i].Name
		end
		objectsTable = children
		namesTable = childNames
	elseif typeof(source) == "table" then
		local instances, instanceNames
		if typeof(source[1]) == "Instance" then
			instances = source
			instanceNames = {}
			for j = 1, #source do
				instanceNames[j] = instances[j].Name
			end
			objectsTable = instances
			namesTable = instanceNames
		else
			if typeof(source[1]) == "EnumItem" or typeof(source[1]) == "table" and typeof(source[1].Name) == "string" then
				instances = source
				instanceNames = {}
				for j = 1, #source do
					instanceNames[j] = instances[j].Name
				end
				objectsTable = instances
				namesTable = instanceNames
			else
				local firstElement
				firstElement = source[1]
				if type(firstElement) == "string" then
					namesTable = source
				elseif source[1] == nil then
					namesTable = {}
				else
					error("[Cmdr] MakeFuzzyFinder only accepts tables of instances or strings.")
				end
			end
		end
	else
		error("[Cmdr] MakeFuzzyFinder only accepts a table, Enum, or Instance.")
	end
	return function(query, exactOnly, prefixOnly)
		local matchResults = {}
		for k, v in pairs(namesTable) do
			local matchValue = objectsTable and objectsTable[k] or v
			if v:lower() == query:lower() then
				if exactOnly then
					return matchValue
				end
				table.insert(matchResults, 1, matchValue)
			elseif prefixOnly then
				if v:lower():sub(1, #query) == query:lower() then
					matchResults[#matchResults + 1] = matchValue
				end
			elseif v:lower():find(query:lower(), 1, true) then
				matchResults[#matchResults + 1] = matchValue
			end
		end
		if exactOnly then
			return matchResults[1]
		else
			return matchResults
		end
	end
end
function t.GetNames(instances)
	local names = {}
	for i = 1, #instances do
		local name = instances[i].Name
		if not name then
			name = tostring(instances[i])
		end
		names[i] = name
	end
	return names
end
function t.SplitStringSimple(str, delimiter)
	if delimiter == nil then
		delimiter = "%s"
	end
	local result = {}
	local count = 1
	for token in string.gmatch(str, "([^" .. delimiter .. "]+)") do
		result[count] = token
		count = count + 1
	end
	return result
end
local function charCode(hexString)
	return utf8.char((tonumber(hexString, 16)))
end
function t.ParseEscapeSequences(str)
	return str:gsub("\\(.)", {
		t = "\t",
		n = "\n"
	}):gsub("\\u(%x%x%x%x)", charCode):gsub("\\x(%x%x)", charCode)
end
function t.EncodeEscapedOperator(str, operator)
	return str:gsub("(" .. ("%" .. operator:sub(1, 1)) .. "+)(" .. operator:gsub(".", "%%%1") .. ")", function(captured, replacement)
		return (captured:sub(1, #captured - 1) .. replacement):gsub(".", function(char)
			return "\\u" .. string.format("%04x", string.byte(char), 16)
		end)
	end)
end
local operatorsList = { "&&", "||", ";" }
function t.EncodeEscapedOperators(str)
	for i, v in ipairs(operatorsList) do
		str = t.EncodeEscapedOperator(str, v)
	end
	return str
end
local function encodeControlChars(str)
	return str:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___")
end
local function decodeControlChars(str)
	return str:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
end
function t.SplitString(str, maxTokensParam)
	local currentQuote = nil
	local isQuoted = nil
	local tokens = {}
	local maxTokens = maxTokensParam or (1 / 0)
	for token in str:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
		local shouldInsert
		local parsed = t.ParseEscapeSequences(token)
		local openQuote = parsed:match("^([\'\"])")
		local closeQuote = parsed:match("([\'\"])$")
		local escapeSequence = parsed:match("(\\*)[\'\"]$")
		if openQuote and not (currentQuote or closeQuote) then
			isQuoted = parsed
			currentQuote = openQuote
			token = parsed
		elseif isQuoted and (closeQuote == currentQuote and #escapeSequence % 2 == 0) then
			isQuoted = nil
			currentQuote = nil
			token = isQuoted .. " " .. parsed
		elseif isQuoted then
			isQuoted, token = isQuoted .. " " .. parsed, parsed
		else
			token = parsed
		end
		if not isQuoted then
			shouldInsert = if maxTokens < #tokens then 0 else 1
			tokens[#tokens + shouldInsert] = token:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
		end
	end
	if isQuoted then
		tokens[#tokens + if maxTokens < #tokens then 0 else 1] = isQuoted:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
	end
	return tokens
end
function t.MashExcessArguments(args, maxIndex)
	local result = {}
	for i = 1, #args do
		if maxIndex < i then
			result[maxIndex] = ("%s %s"):format(result[maxIndex] or "", args[i])
		else
			result[i] = args[i]
		end
	end
	return result
end
function t.TrimString(str)
	local _, firstNonWhitespaceIndex = string.find(str, "^%s*")
	if firstNonWhitespaceIndex == #str then
		return ""
	else
		return string.match(str, ".*%S", firstNonWhitespaceIndex + 1)
	end
end
function t.GetTextSize(str, guiObject, constraintSize)
	return TextService:GetTextSize(str, guiObject.TextSize, guiObject.Font, constraintSize or Vector2.new(guiObject.AbsoluteSize.X, 0))
end
function t.MakeEnumType(typeName, sourceTable)
	local fuzzyFinder = t.MakeFuzzyFinder(sourceTable)
	return {
		Validate = function(value)
			return fuzzyFinder(value, true) ~= nil, ("Value %q is not a valid %s."):format(value, typeName)
		end,
		Autocomplete = function(input)
			local results = fuzzyFinder(input)
			return if type(results[1]) == "string" then results else t.GetNames(results) or results
		end,
		Parse = function(input)
			return fuzzyFinder(input, true)
		end
	}
end
function t.ParsePrefixedUnionType(str, input)
	local parts = t.SplitStringSimple(str)
	local typeList = {}
	for i = 1, #parts, 2 do
		typeList[#typeList + 1] = {
			prefix = parts[i - 1] or "",
			type = parts[i]
		}
	end
	table.sort(typeList, function(a, b)
		return #a.prefix > #b.prefix
	end)
	for j = 1, #typeList do
		local typeEntry = typeList[j]
		if input:sub(1, #typeEntry.prefix) == typeEntry.prefix then
			return typeEntry.type, input:sub(#typeEntry.prefix + 1), typeEntry.prefix
		end
	end
end
function t.MakeListableType(baseType, overrides)
	local result = {
		Listable = true,
		Transform = baseType.Transform,
		Validate = baseType.Validate,
		ValidateOnce = baseType.ValidateOnce,
		Autocomplete = baseType.Autocomplete,
		Default = baseType.Default,
		ArgumentOperatorAliases = baseType.ArgumentOperatorAliases,
		Parse = function(...)
			return { baseType.Parse(...) }
		end
	}
	if overrides then
		for k, v in pairs(overrides) do
			result[k] = v
		end
	end
	return result
end
local function encodeCommandEscape(str)
	return str:gsub("\\%$", "___!CMDR_DOLLAR!___")
end
local function decodeCommandEscape(str)
	return str:gsub("___!CMDR_DOLLAR!___", "$")
end
function t.RunCommandString(dispatcher, command)
	local commands = t.EncodeEscapedOperators((t.ParseEscapeSequences(command))):split("&&")
	local lastResult = ""
	for i, v in ipairs(commands) do
		local escapedResult = lastResult:gsub("%$", "\\x24"):gsub("%%", "%%%%")
		local currentResult = tostring(dispatcher:EvaluateAndRun((t.RunEmbeddedCommands(dispatcher, (v:gsub("||", lastResult:find("%s") and ("%q"):format(escapedResult) or escapedResult))))))
		if i == #commands then
			return currentResult
		end
		lastResult = currentResult
	end
end
function t.RunEmbeddedCommands(dispatcher, str)
	local encoded = str:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local substitutions, result = {}, encoded
	for placeholder in encoded:gmatch("$(%b{})") do
		local isQuoted
		local content = placeholder:sub(2, #placeholder - 1)
		if content:match("^{.+}$") then
			content, isQuoted = content:sub(2, #content - 1), false
		else
			isQuoted = true
		end
		substitutions[placeholder] = t.RunCommandString(dispatcher, content)
		if isQuoted and (substitutions[placeholder]:find("%s") or substitutions[placeholder] == "") then
			substitutions[placeholder] = string.format("%q", substitutions[placeholder])
		end
	end
	return result:gsub("$(%b{})", substitutions):gsub("___!CMDR_DOLLAR!___", "$")
end
function t.SubstituteArgs(str, argsTable)
	local encoded = str:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local result
	if type(argsTable) == "table" then
		result = encoded
		for i = 1, #argsTable do
			local indexStr = tostring(i)
			argsTable[indexStr] = argsTable[i]
			if argsTable[indexStr]:find("%s") then
				argsTable[indexStr] = string.format("%q", argsTable[indexStr])
			end
		end
	else
		result = encoded
	end
	return result:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", argsTable):gsub("___!CMDR_DOLLAR!___", "$")
end
function t.MakeAliasCommand(header, body)
	local name, aliases = unpack(header:split("|"))
	local encoded = t.EncodeEscapedOperators(body)
	local processedParams = {}
	local arguments = {}
	for paramNum in encoded:gmatch("$(%d+)") do
		local paramType, paramName, paramDesc, isOptional, paramTypeName, defaultDesc
		if processedParams[paramNum] == nil then
			processedParams[paramNum] = true
			local paramSpec = encoded:match((("$%*(%%b{})"):format(paramNum)))
			if paramSpec then
				local specType, specName, specDesc = unpack(paramSpec:sub(2, #paramSpec - 1):split("|"))
				paramType = specType
				paramName = specName
				paramDesc = specDesc
			else
				paramType = nil
				paramName = nil
				paramDesc = nil
			end
			isOptional = paramType and (paramType:match("%?$") and true or false)
			paramTypeName = if paramType then paramType:match("^%w+") else "string"
			defaultDesc = paramName or ("Argument %*"):format(paramNum)
			table.insert(arguments, {
				Type = paramTypeName,
				Name = defaultDesc,
				Description = paramDesc or "",
				Optional = isOptional
			})
		end
	end
	return {
		Name = name,
		Aliases = {},
		Description = ("<Alias> %*"):format(aliases or encoded),
		Group = "UserAlias",
		Args = arguments,
		ClientRun = function(context)
			return t.RunCommandString(context.Dispatcher, t.SubstituteArgs(encoded, context.RawArguments))
		end
	}
end
function t.MakeSequenceType(config)
	local sequenceConfig = config or {}
	assert(if sequenceConfig.Parse == nil then sequenceConfig.Constructor ~= nil else true, "[Cmdr] MakeSequenceType: Must provide one of: Constructor, Parse")
	sequenceConfig.TransformEach = sequenceConfig.TransformEach or function(...)
		return ...
	end
	sequenceConfig.ValidateEach = sequenceConfig.ValidateEach or function()
		return true
	end
	local sequenceType = {
		Prefixes = sequenceConfig.Prefixes,
		Transform = function(value)
			return t.Map(t.SplitPrioritizedDelimeter(value, { ",", "%s" }), function(item)
				return sequenceConfig.TransformEach(item)
			end)
		end,
		Validate = function(value)
			if sequenceConfig.Length and #value > sequenceConfig.Length then
				return false, ("Maximum of %d values allowed in sequence"):format(sequenceConfig.Length)
			else
				for i = 1, sequenceConfig.Length or #value do
					local isValid, errorMsg = sequenceConfig.ValidateEach(value[i], i)
					if not isValid then
						return false, errorMsg
					end
				end
				return true
			end
		end
	}
	sequenceType.Parse = sequenceConfig.Parse or function(value)
		return sequenceConfig.Constructor(unpack(value))
	end
	return sequenceType
end
function t.SplitPrioritizedDelimeter(str, delimiters)
	for i, v in ipairs(delimiters) do
		if str:find(v) or i == #delimiters then
			return t.SplitStringSimple(str, v)
		end
	end
end
function t.Map(array, fn)
	local result = {}
	for i, v in ipairs(array) do
		result[i] = fn(v, i)
	end
	return result
end
function t.Each(fn, ...)
	local result = {}
	for i, v in ipairs({ ... }) do
		result[i] = fn(v)
	end
	return unpack(result)
end
function t.EmulateTabstops(str, tabSize)
	local length = #str
	local output = table.create(length)
	local columnPos = 0
	for i = 1, length do
		local char = string.sub(str, i, i)
		if char == "\t" then
			local spacesNeeded = tabSize - columnPos % tabSize
			table.insert(output, string.rep(" ", spacesNeeded))
			columnPos = columnPos + spacesNeeded
		else
			table.insert(output, char)
			if char == "\n" then
				columnPos = 0
			elseif char ~= "\r" then
				columnPos = columnPos + 1
			end
		end
	end
	return table.concat(output)
end
function t.Mutex()
	local queue = {}
	local locked = false
	return function()
		if locked then
			table.insert(queue, coroutine.running())
			coroutine.yield()
		else
			locked = true
		end
		return function()
			if #queue > 0 then
				coroutine.resume(table.remove(queue, 1))
			else
				locked = false
			end
		end
	end
end
return t
