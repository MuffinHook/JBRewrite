local Util = require(script.Parent.Util)
local function unescapeOperators(input)
	for i, pattern in ipairs({ "%.", "%?", "%*", "%*%*" }) do
		input = input:gsub("\\" .. pattern, pattern:gsub("%%", ""))
	end
	return input
end
local Argument = {}
Argument.__index = Argument
function Argument.new(command, argumentDefinition, rawValue)
	local instance = {
		Command = command,
		Type = nil,
		Name = argumentDefinition.Name,
		Object = argumentDefinition
	}
	instance.Required = if argumentDefinition.Default == nil then argumentDefinition.Optional ~= true else false
	instance.Executor = command.Executor
	instance.RawValue = rawValue
	instance.RawSegments = {}
	instance.TransformedValues = {}
	instance.Prefix = ""
	instance.TextSegmentInProgress = ""
	instance.RawSegmentsAreAutocomplete = false
	if type(argumentDefinition.Type) == "table" then
		instance.Type = argumentDefinition.Type
	else
		local prefixedTypeName, processedValue, prefix = Util.ParsePrefixedUnionType(command.Cmdr.Registry:GetTypeName(argumentDefinition.Type), rawValue)
		instance.Type = command.Dispatcher.Registry:GetType(prefixedTypeName)
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
function Argument.GetDefaultAutocomplete(self)
	if self.Type.Autocomplete then
		local defaultOptions, defaultMetadata = self.Type.Autocomplete(self:TransformSegment(""))
		return defaultOptions, defaultMetadata or {}
	else
		return {}
	end
end
function Argument.Transform(self)
	if #self.TransformedValues == 0 then
		local RawValue = self.RawValue
		if self.Type.ArgumentOperatorAliases then
			RawValue = self.Type.ArgumentOperatorAliases[RawValue] or RawValue
		end
		if RawValue == "." and self.Type.Default then
			RawValue = self.Type.Default(self.Executor) or ""
			self.RawSegmentsAreAutocomplete = true
		end
		if RawValue == "?" and self.Type.Autocomplete then
			local defaultOptions, defaultMetadata = self:GetDefaultAutocomplete()
			if not defaultMetadata.IsPartial and #defaultOptions > 0 then
				RawValue = defaultOptions[math.random(1, #defaultOptions)]
				self.RawSegmentsAreAutocomplete = true
			end
		end
		if self.Type.Listable and #self.RawValue > 0 then
			local countMatch = RawValue:match("^%?(%d+)$")
			if countMatch then
				local count = tonumber(countMatch)
				if count and count > 0 then
					local randomList = {}
					local defaultOptions, defaultMetadata = self:GetDefaultAutocomplete()
					if not defaultMetadata.IsPartial and #defaultOptions > 0 then
						for i = 1, math.min(count, #defaultOptions) do
							local remove = table.remove
							table.insert(randomList, remove(defaultOptions, math.random(1, #defaultOptions)))
						end
						local joinedResult = table.concat(randomList, ",")
						self.RawSegmentsAreAutocomplete = true
						RawValue = joinedResult
					end
				end
			elseif RawValue == "*" or RawValue == "**" then
				local allOptions, allMetadata = self:GetDefaultAutocomplete()
				if not allMetadata.IsPartial and #allOptions > 0 then
					if RawValue == "**" and self.Type.Default then
						local defaultValue = self.Type.Default(self.Executor) or ""
						for i, v in ipairs(allOptions) do
							if v == defaultValue then
								table.remove(allOptions, i)
							end
						end
					end
					local joinedAll = table.concat(allOptions, ",")
					self.RawSegmentsAreAutocomplete = true
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
				self.RawSegments[i] = v
				self.TransformedValues[i] = { self:TransformSegment(v) }
			end
			self.TextSegmentInProgress = splitSegments[#splitSegments]
		else
			local unescapedSingleValue = unescapeOperators(RawValue)
			self.RawSegments[1] = unescapeOperators(unescapedSingleValue)
			self.TransformedValues[1] = { self:TransformSegment(unescapedSingleValue) }
			self.TextSegmentInProgress = self.RawValue
		end
	end
end
function Argument.TransformSegment(self, segment)
	if self.Type.Transform then
		return self.Type.Transform(segment, self.Executor)
	else
		return segment
	end
end
function Argument.GetTransformedValue(self, index)
	return unpack(self.TransformedValues[index])
end
function Argument.Validate(self, isRetry)
	if self.RawValue ~= nil and (#self.RawValue ~= 0 or self.Required ~= false) then
		if self.Required and (self.RawSegments[1] == nil or #self.RawSegments[1] == 0) then
			return false, "This argument is required."
		elseif self.Type.Validate or self.Type.ValidateOnce then
			for i = 1, #self.TransformedValues do
				if self.Type.Validate then
					local isValid, errorMessage = self.Type.Validate(self:GetTransformedValue(i))
					if not isValid then
						return isValid, errorMessage or "Invalid value"
					end
				end
				if isRetry and self.Type.ValidateOnce then
					local isValidOnce, errorMessageOnce = self.Type.ValidateOnce(self:GetTransformedValue(i))
					if not isValidOnce then
						return isValidOnce, errorMessageOnce
					end
				end
			end
		end
	end
	return true
end
function Argument.GetAutocomplete(self)
	if self.Type.Autocomplete then
		return self.Type.Autocomplete(self:GetTransformedValue(#self.TransformedValues))
	else
		return {}
	end
end
function Argument.ParseValue(self, index)
	if self.Type.Parse then
		return self.Type.Parse(self:GetTransformedValue(index))
	else
		return self:GetTransformedValue(index)
	end
end
function Argument.GetValue(self)
	if #self.RawValue == 0 and (not self.Required and self.Object.Default ~= nil) then
		return self.Object.Default
	elseif self.Type.Listable then
		local tbl = {}
		for i = 1, #self.TransformedValues do
			local parsedValue = self:ParseValue(i)
			if type(parsedValue) ~= "table" then
				error((("[Cmdr] Listable types must return a table from Parse %*"):format(self.Type.Name)))
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
		return self:ParseValue(1)
	end
end
return Argument
