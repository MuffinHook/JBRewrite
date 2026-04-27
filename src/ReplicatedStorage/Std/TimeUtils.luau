local TimeUtils = {
	isDST = function()
		local month = os.date("*t").month
		local day = os.date("*t").day
		local marchTransitionDay = (8 - os.time({
			year = os.date("*t").year,
			month = 3,
			day = 1,
			hour = 0
		}) % 7) % 7 + 8
		if month > 3 and month < 11 or (month == 3 and marchTransitionDay <= day or month == 11 and day < (8 - os.time({
			year = os.date("*t").year,
			month = 11,
			day = 1,
			hour = 0
		}) % 7) % 7 + 1) then
			return true
		else
			return false
		end
	end
}
function TimeUtils.getETUnix()
	local serverUnixTime = workspace:GetServerTimeNow()
	return serverUnixTime + if TimeUtils.isDST() then -4 else -5 * 3600
end
function TimeUtils.getETDayString(optionalTimestamp)
	assert(optionalTimestamp == nil or type(optionalTimestamp) == "number")
	local etUnixTime = optionalTimestamp or TimeUtils.getETUnix()
	assert(etUnixTime)
	return DateTime.fromUnixTimestamp(etUnixTime):FormatUniversalTime("LLLL", "en-us")
end
function TimeUtils.getETNextDayUnix(optionalTimestamp)
	assert(optionalTimestamp == nil or type(optionalTimestamp) == "number")
	local etUnixTime = optionalTimestamp or TimeUtils.getETUnix()
	assert(etUnixTime)
	return (math.floor(etUnixTime / 86400) + 1) * 86400
end
function TimeUtils.getETWeekUnix(optionalTimestamp)
	assert(optionalTimestamp == nil or type(optionalTimestamp) == "number")
	local etUnixTime = optionalTimestamp or TimeUtils.getETUnix()
	assert(etUnixTime)
	return math.floor(math.floor(etUnixTime / 86400) / 7) * 86400 * 7 - 259200
end
function TimeUtils.getETNextWeekUnix()
	return TimeUtils.getETWeekUnix() + 604800
end
function TimeUtils.getSecondsTilNextETDay()
	return TimeUtils.getETNextDayUnix() - TimeUtils.getETUnix()
end
return TimeUtils
