-- Reviewed by Claude
-- variables reassigned
local Util = require(script.Parent.Parent.Shared.Util)
local durationUnits = {
	Years = 31556926,
	Months = 2629744,
	Weeks = 604800,
	Days = 86400,
	Hours = 3600,
	Minutes = 60,
	Seconds = 1
}
local unitKeys = {}
for k, v in pairs(durationUnits) do
	table.insert(unitKeys, k)
end
local fuzzyFindUnit = Util.MakeFuzzyFinder(unitKeys)
local function stringToSecondDuration(input)
	if input == nil or input == "" then
		return nil
	else
		local parsedNum = tonumber(input)
		if parsedNum and parsedNum == 0 then
			return 0, 0, true
		else
			local remainder = input:gsub("-?%d+%a+", ""):match("-?%d+")
			if remainder then
				return nil, tonumber(remainder), true
			else
				local sum = nil
				local lastUnitValue = nil
				for durationComponent in input:gmatch("-?%d+%a+") do
					local unitMultiplier
					local numPart, unitPart = durationComponent:match("(-?%d+)(%a+)")
					local matchedUnits = fuzzyFindUnit(unitPart, false, true)
					if #matchedUnits == 0 then
						return nil, tonumber(numPart)
					end
					if sum == nil then
						sum = 0
					end
					if unitPart:lower() == "m" then
						lastUnitValue = numPart
						unitMultiplier = 60
					else
						unitMultiplier = durationUnits[matchedUnits[1]]
						lastUnitValue = numPart
					end
					sum = sum + unitMultiplier * tonumber(lastUnitValue)
				end
				if sum == nil then
					return nil
				else
					return sum, tonumber(lastUnitValue)
				end
			end
		end
	end
end
local function mapUnits(unitTable, prefix, shouldTruncate, offset)
	local startIndex = offset or 1
	local result = {}
	for k, v in pairs(unitTable) do
		if shouldTruncate == 1 then
			result[k] = prefix .. v:sub(startIndex, #v - 1)
		else
			result[k] = prefix .. v:sub(startIndex)
		end
	end
	return result
end
local durationTypeDefinition = {
	Transform = function(input)
		return input, stringToSecondDuration(input)
	end,
	Validate = function(input, result)
		return result ~= nil
	end,
	Autocomplete = function(input, currentValue, truncateFlag, fuzzyBool, manualUnits)
		local result = {}
		if fuzzyBool or manualUnits then
			local fuzzyResults = fuzzyBool == true and fuzzyFindUnit("", false, true) or manualUnits
			if fuzzyBool == true then
				return mapUnits(fuzzyResults, input, truncateFlag)
			else
				return mapUnits(fuzzyResults, input, input:match("^.*(%a+)$"):len() + 1)
			end
		else
			if currentValue ~= nil then
				local matchedUnit = input:match("^.*-?%d+(%a+)%s?$")
				local mappedUnits = mapUnits(fuzzyFindUnit(matchedUnit, false, true), input, truncateFlag, #matchedUnit + 1)
				table.sort(mappedUnits)
				result = mappedUnits
			end
			return result
		end
	end,
	Parse = function(input, result)
		return result
	end
}
return function(typeRegistry)
	typeRegistry:RegisterType("duration", durationTypeDefinition)
	typeRegistry:RegisterType("durations", Util.MakeListableType(durationTypeDefinition))
end
