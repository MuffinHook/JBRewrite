-- Reviewed by Claude
-- variables reassigned
local ContractConsts = require(script.Parent.ContractConsts)
local CollectionService = game:GetService("CollectionService")
local t = {}
local function validateObj(contractObj)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
end
function t.canReroll(contractObj, hasVIP)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
	assert(typeof(hasVIP) == "boolean", "Incorrect hasVIP passed")
	return t.getNumTimesRerolled(contractObj) < if hasVIP then 2 else 1
end
function t.getNumTimesRerolled(contractObj)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
	local rerollValue = contractObj:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if rerollValue then
		return rerollValue.Value
	else
		return nil
	end
end
function t.getNumTimesRerolledObject(contractObj)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
	local rerollValue = contractObj:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if rerollValue then
		return rerollValue
	else
		return nil
	end
end
function t.setNumTimesRerolled(contractObj, rerollCount)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
	local rerollValue = contractObj:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if not rerollValue then
		local newRerollValue = Instance.new("NumberValue")
		newRerollValue.Name = ContractConsts.REROLLED_VALUE_NAME
		newRerollValue.Parent = contractObj
		rerollValue = newRerollValue
	end
	rerollValue.Value = rerollCount
	return true
end
function t.getQuantizedBlock(p1, p2)
	assert(typeof(p1) == "number", "Duration must be a number")
	local defaultValue = p2 or 0
	if defaultValue then
		return math.ceil((workspace:GetServerTimeNow() - defaultValue) / p1) * p1 + defaultValue
	end
end
function t.getNextDeadline()
	local deadlineDateTime = {
		year = 2023,
		month = 7,
		day = 31,
		hour = 13
	}
	local UnixTimestamp = DateTime.fromUniversalTime(deadlineDateTime.year, deadlineDateTime.month, deadlineDateTime.day, deadlineDateTime.hour - -4).UnixTimestamp
	return t.getQuantizedBlock(ContractConsts.REFRESH_DURATION, UnixTimestamp)
end
return t
