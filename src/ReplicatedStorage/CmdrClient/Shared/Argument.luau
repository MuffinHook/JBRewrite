-- Reviewed by Claude
-- variables reassigned
local Util = require(script.Parent.Util)
local function unescapeOperators(p1)
	for i, v in ipairs({ "%.", "%?", "%*", "%*%*" }) do
		p1 = p1:gsub("\\" .. v, v:gsub("%%", ""))
	end
	return p1
end
local Argument = {}
Argument.__index = Argument
function Argument.new(p1, p2, rawValue)
	local instance = {
		Command = p1,
		Type = nil,
		Name = p2.Name,
		Object = p2
	}
	instance.Required = if p2.Default == nil then p2.Optional ~= true else false
	instance.Executor = p1.Executor
	instance.RawValue = rawValue
	instance.RawSegments = {}
	instance.TransformedValues = {}
	instance.Prefix = ""
	instance.TextSegmentInProgress = ""
	instance.RawSegmentsAreAutocomplete = false
	if type(p2.Type) == "table" then
		instance.Type = p2.Type
	else
		local prefixedTypeName, processedValue, prefix = Util.ParsePrefixedUnionType(p1.Cmdr.Registry:GetTypeName(p2.Type), rawValue)
		instance.Type = p1.Dispatcher.Registry:GetType(prefixedTypeName)
		instance.RawValue = processedValue
		instance.Prefix = prefix
		if instance.Type == nil then
			error(("[Cmdr] %* has an unregistered type %%q"):format(instance.Name or "none"):format(prefixedTypeName or "<none>"))
		end
	end
	setmetatable(instance, Argument)
	instance:Transform()
	return instance
end
function Argument.GetDefaultAutocomplete(p1)
	if p1.Type.Autocomplete then
		local defaultOptions, defaultMetadata = p1.Type.Autocomplete(p1:TransformSegment(""))
		return defaultOptions, defaultMetadata or {}
	else
		return {}
	end
end
function Argument.Transform(p1)
	if #p1.TransformedValues == 0 then
		local RawValue = p1.RawValue
		if p1.Type.ArgumentOperatorAliases then
			RawValue = p1.Type.ArgumentOperatorAliases[RawValue] or RawValue
		end
		if RawValue == "." and p1.Type.Default then
			RawValue = p1.Type.Default(p1.Executor) or ""
			p1.RawSegmentsAreAutocomplete = true
		end
		if RawValue == "?" and p1.Type.Autocomplete then
			local defaultOptions, defaultMetadata = p1:GetDefaultAutocomplete()
			if not defaultMetadata.IsPartial and #defaultOptions > 0 then
				RawValue = defaultOptions[math.random(1, #defaultOptions)]
				p1.RawSegmentsAreAutocomplete = true
			end
		end
		if p1.Type.Listable and #p1.RawValue > 0 then
			local countMatch = RawValue:match("^%?(%d+)$")
			if countMatch then
				local count = tonumber(countMatch)
				if count and count > 0 then
					local randomList = {}
					local defaultOptions, defaultMetadata = p1:GetDefaultAutocomplete()
					if not defaultMetadata.IsPartial and #defaultOptions > 0 then
						for i = 1, math.min(count, #defaultOptions) do
							local remove = table.remove
							table.insert(randomList, remove(defaultOptions, math.random(1, #defaultOptions)))
						end
						local joinedResult = table.concat(randomList, ",")
						p1.RawSegmentsAreAutocomplete = true
						RawValue = joinedResult
					end
				end
			elseif RawValue == "*" or RawValue == "**" then
				local allOptions, allMetadata = p1:GetDefaultAutocomplete()
				if not allMetadata.IsPartial and #allOptions > 0 then
					if RawValue == "**" and p1.Type.Default then
						local defaultValue = p1.Type.Default(p1.Executor) or ""
						for i, v in ipairs(allOptions) do
							if v == defaultValue then
								table.remove(allOptions, i)
							end
						end
					end
					local joinedAll = table.concat(allOptions, ",")
					p1.RawSegmentsAreAutocomplete = true
					RawValue = joinedAll
				end
			end
			local unescapedValue = unescapeOperators(RawValue)
			local splitSegments = Util.SplitStringSimple(unescapedValue, ",")
			if #splitSegments == 0 then
				splitSegments = { "" }
			end
			if unescapedValue:sub(#unescapedValue, #unescapedValue) == "," then
				splitSegments[#splitSegments + 1] = ""
			end
			for i, v in ipairs(splitSegments) do
				p1.RawSegments[i] = v
				p1.TransformedValues[i] = { p1:TransformSegment(v) }
			end
			p1.TextSegmentInProgress = splitSegments[#splitSegments]
		else
			local unescapedSingleValue = unescapeOperators(RawValue)
			p1.RawSegments[1] = unescapeOperators(unescapedSingleValue)
			p1.TransformedValues[1] = { p1:TransformSegment(unescapedSingleValue) }
			p1.TextSegmentInProgress = p1.RawValue
		end
	end
end
function Argument.TransformSegment(p1, p2)
	if p1.Type.Transform then
		return p1.Type.Transform(p2, p1.Executor)
	else
		return p2
	end
end
function Argument.GetTransformedValue(p1, p2)
	return unpack(p1.TransformedValues[p2])
end
function Argument.Validate(p1, p2)
	if p1.RawValue ~= nil and (#p1.RawValue ~= 0 or p1.Required ~= false) then
		if p1.Required and (p1.RawSegments[1] == nil or #p1.RawSegments[1] == 0) then
			return false, "This argument is required."
		elseif p1.Type.Validate or p1.Type.ValidateOnce then
			for i = 1, #p1.TransformedValues do
				if p1.Type.Validate then
					local isValid, errorMessage = p1.Type.Validate(p1:GetTransformedValue(i))
					if not isValid then
						return isValid, errorMessage or "Invalid value"
					end
				end
				if p2 and p1.Type.ValidateOnce then
					local isValidOnce, errorMessageOnce = p1.Type.ValidateOnce(p1:GetTransformedValue(i))
					if not isValidOnce then
						return isValidOnce, errorMessageOnce
					end
				end
			end
		end
	end
	return true
end
function Argument.GetAutocomplete(p1)
	if p1.Type.Autocomplete then
		return p1.Type.Autocomplete(p1:GetTransformedValue(#p1.TransformedValues))
	else
		return {}
	end
end
function Argument.ParseValue(p1, p2)
	if p1.Type.Parse then
		return p1.Type.Parse(p1:GetTransformedValue(p2))
	else
		return p1:GetTransformedValue(p2)
	end
end
function Argument.GetValue(p1)
	if #p1.RawValue == 0 and (not p1.Required and p1.Object.Default ~= nil) then
		return p1.Object.Default
	elseif p1.Type.Listable then
		local tbl = {}
		for i = 1, #p1.TransformedValues do
			local parsedValue = p1:ParseValue(i)
			if type(parsedValue) ~= "table" then
				error((("[Cmdr] Listable types must return a table from Parse %*"):format(p1.Type.Name)))
			end
			for k, v in pairs(parsedValue) do
				tbl[v] = true
			end
		end
		local resultTable = {}
		for k in pairs(tbl) do
			resultTable[#resultTable + 1] = k
		end
		return resultTable
	else
		return p1:ParseValue(1)
	end
end
return Argument