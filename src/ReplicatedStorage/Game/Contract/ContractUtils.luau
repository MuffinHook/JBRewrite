local ContractConsts = require(script.Parent.ContractConsts)
local CollectionService = game:GetService("CollectionService")
local ContractUtils = {}
local function validateObj(contractObj)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
end
function ContractUtils.canReroll(contractObj, hasVIP)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
	assert(typeof(hasVIP) == "boolean", "Incorrect hasVIP passed")
	return ContractUtils.getNumTimesRerolled(contractObj) < if hasVIP then 2 else 1
end
function ContractUtils.getNumTimesRerolled(contractObj)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
	local rerollValue = contractObj:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if rerollValue then
		return rerollValue.Value
	else
		return nil
	end
end
function ContractUtils.getNumTimesRerolledObject(contractObj)
	assert(typeof(contractObj) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(contractObj, "Contract"))
	local rerollValue = contractObj:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if rerollValue then
		return rerollValue
	else
		return nil
	end
end
function ContractUtils.setNumTimesRerolled(contractObj, rerollCount)
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
function ContractUtils.getQuantizedBlock(blockDuration, offsetTime)
	assert(typeof(blockDuration) == "number", "Duration must be a number")
	local defaultValue = offsetTime or 0
	if defaultValue then
		return math.ceil((workspace:GetServerTimeNow() - defaultValue) / blockDuration) * blockDuration + defaultValue
	end
end
function ContractUtils.getNextDeadline()
	local deadlineDateTime = {
		year = 2023,
		month = 7,
		day = 31,
		hour = 13
	}
	local UnixTimestamp = DateTime.fromUniversalTime(deadlineDateTime.year, deadlineDateTime.month, deadlineDateTime.day, deadlineDateTime.hour - -4).UnixTimestamp
	return ContractUtils.getQuantizedBlock(ContractConsts.REFRESH_DURATION, UnixTimestamp)
end
return ContractUtils
