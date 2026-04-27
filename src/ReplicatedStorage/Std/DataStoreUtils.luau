local HttpService = game:GetService("HttpService")
local t = {}
local function validateTableSafety(tableToValidate)
	for keyOrIndex, valueInTable in tableToValidate do
		if typeof(keyOrIndex) == "string" then
			if #keyOrIndex >= 1000 then
				warn("Key is too long")
				return false
			elseif not utf8.len(keyOrIndex) then
				warn("Key is not valid utf8")
				return false
			end
		elseif typeof(keyOrIndex) == "number" then
			if keyOrIndex ~= keyOrIndex then
				warn("Key is NaN")
				return false
			end
		else
			warn("Key is not a string or number")
			return false
		end
		if typeof(valueInTable) == "table" then
			if not validateTableSafety(valueInTable) then
				warn((("SubTable at %* was not safe"):format((tostring(keyOrIndex)))))
				return false
			end
		elseif typeof(valueInTable) ~= "number" then
			if typeof(valueInTable) == "string" then
				if #valueInTable >= 4000000 then
					warn("Value is too long")
					return false
				end
				if not utf8.len(valueInTable) then
					warn("Value is not valid utf8")
					return false
				end
			elseif typeof(valueInTable) ~= "boolean" then
				warn("Value is not a table, number, or string")
				return false
			end
		end
	end
	return true
end
function t.isTableSafe(tableToValidate, options)
	if typeof(tableToValidate) == "table" then
		local encodedSize = nil
		local success, errorMessage = pcall(function()
			encodedSize = #HttpService:JSONEncode(tableToValidate)
		end)
		if success then
			if if options and options.maxTotalLength then options.maxTotalLength else 4194304 <= encodedSize then
				return false
			else
				return validateTableSafety(tableToValidate)
			end
		else
			warn("Failed to encode to JSON: " .. tostring(errorMessage))
			return false
		end
	else
		return false
	end
end
function t.isStringSafe(inputString)
	if typeof(inputString) == "string" then
		if utf8.len(inputString) == nil then
			return false
		else
			return not (#inputString > 1000000)
		end
	else
		return false
	end
end
return t
