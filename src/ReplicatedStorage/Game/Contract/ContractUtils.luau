local ContractConsts = require(script.Parent.ContractConsts)
local CollectionService = game:GetService("CollectionService")
local t = {}
local function validateObj(p1) --[[ Line: 5 | Upvalues: CollectionService (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, "Contract"))
end
function t.canReroll(p1, p2) --[[ Line: 9 | Upvalues: CollectionService (copy), t (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, "Contract"))
	assert(typeof(p2) == "boolean", "Incorrect hasVIP passed")
	return t.getNumTimesRerolled(p1) < if p2 then 2 else 1
end
function t.getNumTimesRerolled(p1) --[[ Line: 15 | Upvalues: CollectionService (copy), ContractConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, "Contract"))
	local v3 = p1:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if v3 then
		return v3.Value
	else
		return nil
	end
end
function t.getNumTimesRerolledObject(p1) --[[ Line: 23 | Upvalues: CollectionService (copy), ContractConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, "Contract"))
	local v3 = p1:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if v3 then
		return v3
	else
		return nil
	end
end
function t.setNumTimesRerolled(p1, p2) --[[ Line: 31 | Upvalues: CollectionService (copy), ContractConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, "Contract"))
	local v3 = p1:FindFirstChild(ContractConsts.REROLLED_VALUE_NAME)
	if not v3 then
		local v4 = Instance.new("NumberValue")
		v4.Name = ContractConsts.REROLLED_VALUE_NAME
		v4.Parent = p1
		v3 = v4
	end
	v3.Value = p2
	return true
end
function t.getQuantizedBlock(p1, p2) --[[ Line: 43 ]]
	assert(typeof(p1) == "number", "Duration must be a number")
	local v2 = p2 or 0
	if v2 then
		return math.ceil((workspace:GetServerTimeNow() - v2) / p1) * p1 + v2
	end
end
function t.getNextDeadline() --[[ Line: 53 | Upvalues: t (copy), ContractConsts (copy) ]]
	local t2 = {
		year = 2023,
		month = 7,
		day = 31,
		hour = 13
	}
	local UnixTimestamp = DateTime.fromUniversalTime(t2.year, t2.month, t2.day, t2.hour - -4).UnixTimestamp
	return t.getQuantizedBlock(ContractConsts.REFRESH_DURATION, UnixTimestamp)
end
return t