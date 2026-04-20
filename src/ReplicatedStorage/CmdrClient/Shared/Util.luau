local TextService = game:GetService("TextService")

local Util = {}

-- Decomp Error: Konstant failed this public Cmdr helper module; rebuilt the helper surface used by local Cmdr code.
function Util.MakeDictionary(list)
	local dictionary = {}
	for _, value in pairs(list) do
		dictionary[value] = true
	end
	return dictionary
end

function Util.DictionaryKeys(dictionary)
	local keys = {}
	for key in pairs(dictionary) do
		table.insert(keys, key)
	end
	table.sort(keys)
	return keys
end

function Util.GetNames(values)
	local names = {}
	for _, value in pairs(values) do
		table.insert(names, typeof(value) == "Instance" and value.Name or tostring(value))
	end
	return names
end

function Util.MakeFuzzyFinder(values)
	local names = values
	if typeof(values) == "Enum" then
		names = values:GetEnumItems()
	elseif typeof(values) == "Instance" then
		names = values:GetChildren()
	end
	if typeof(names) ~= "table" then
		error("[Cmdr] MakeFuzzyFinder only accepts a table, Enum, or Instance.")
	end
	local entries = Util.GetNames(names)
	return function(text)
		text = tostring(text or ""):lower()
		local matches = {}
		for _, name in ipairs(entries) do
			local lowerName = tostring(name):lower()
			if text == "" or lowerName:find(text, 1, true) then
				table.insert(matches, name)
			end
		end
		return matches
	end
end

function Util.SplitStringSimple(text, separator)
	separator = separator or " "
	local result = {}
	if text == "" then
		return result
	end
	local escaped = separator:gsub("%W", "%%%0")
	for value in tostring(text):gmatch("([^" .. escaped .. "]+)") do
		table.insert(result, value)
	end
	return result
end

function Util.TrimString(text)
	return (tostring(text):match("^%s*(.-)%s*$"))
end

function Util.ParseEscapeSequences(text)
	text = tostring(text)
	text = text:gsub("\\n", "\n")
	text = text:gsub("\\t", "\t")
	text = text:gsub("\\r", "\r")
	text = text:gsub("\\\\", "\\")
	return text
end

function Util.EncodeEscapedOperators(text)
	return tostring(text):gsub("%%", "____!CMDR_ESCAPE!____")
end

function Util.DecodeEscapedOperators(text)
	return tostring(text):gsub("____!CMDR_ESCAPE!____", "%%")
end

function Util.SplitString(text)
	local result = {}
	for token in tostring(text):gmatch("[^ ]+") do
		table.insert(result, token)
	end
	return result
end

function Util.Trim(text)
	return Util.TrimString(text)
end

function Util.MashExcessArguments(args, max)
	if #args <= max then
		return args
	end
	local mashed = {}
	for i = 1, max - 1 do
		mashed[i] = args[i]
	end
	mashed[max] = table.concat(args, " ", max)
	return mashed
end

function Util.GetTextSize(text, font, size, bounds)
	return TextService:GetTextSize(tostring(text), size or 14, font or Enum.Font.SourceSans, bounds or Vector2.new(10000, 10000))
end

function Util.MakeEnumType(name, enum)
	local finder = Util.MakeFuzzyFinder(enum)
	return {
		Transform = function(text)
			return finder(text)
		end,
		Validate = function(items)
			return #items > 0, string.format("Value %q is not a valid %s.", tostring(items), name)
		end,
		Autocomplete = finder,
		Parse = function(items)
			return typeof(items) == "table" and items[1] or items
		end,
	}
end

function Util.ParsePrefixedUnionType(typeName, rawValue)
	local currentType = tostring(typeName or "")
	for prefix, targetType in currentType:gmatch("(%S+)%s+(%S+)") do
		if tostring(rawValue):sub(1, #prefix) == prefix then
			return targetType, tostring(rawValue):sub(#prefix + 1), prefix
		end
	end
	return currentType:match("%S+$") or currentType, rawValue, ""
end

function Util.MakeListableType(typeDef)
	local copy = {}
	for key, value in pairs(typeDef) do
		copy[key] = value
	end
	copy.Listable = true
	return copy
end

function Util.MakeAliasCommand(alias, commandName, args)
	return {
		Name = alias,
		Aliases = {},
		Description = string.format("Alias for %s", commandName),
		Group = "Aliases",
		Args = args or {},
		Run = function(context)
			return context.Dispatcher:EvaluateAndRun(commandName, context.Executor)
		end,
	}
end

function Util.TransformEach(values, transform)
	local result = {}
	for index, value in ipairs(values) do
		result[index] = transform(value, index)
	end
	return result
end

function Util.Map(values, transform)
	return Util.TransformEach(values, transform)
end

function Util.SplitPrioritizedDelimitedString(text, delimiter)
	return Util.SplitStringSimple(text, delimiter or ",")
end

function Util.EmulateTabstops(text)
	return tostring(text):gsub("\t", "    ")
end

function Util.RunEmbeddedCommands(dispatcher, commandString, context)
	return tostring(commandString):gsub("%$%b{}", function(match)
		local inner = match:sub(3, -2)
		local ok, result = pcall(function()
			return dispatcher:EvaluateAndRun(inner, context and context.Executor)
		end)
		return ok and tostring(result) or ""
	end)
end

function Util.SubstituteArgs(text, args)
	return tostring(text):gsub("%$(%d+)", function(index)
		return tostring(args[tonumber(index)] or "")
	end)
end

function Util.MakeSequenceType(config)
	assert(config.Constructor or config.Parse, "[Cmdr] MakeSequenceType: Must provide one of: Constructor, Parse")
	return config
end

return Util
