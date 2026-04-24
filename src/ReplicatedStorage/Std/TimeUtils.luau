-- Reviewed by Claude
local t = {
	isDST = function()
		local month = os.date("*t").month
		local day = os.date("*t").day
		local v1 = (8 - os.time({
			year = os.date("*t").year,
			month = 3,
			day = 1,
			hour = 0
		}) % 7) % 7 + 8
		if month > 3 and month < 11 or (month == 3 and v1 <= day or month == 11 and day < (8 - os.time({
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
function t.getETUnix()
	local v1 = workspace:GetServerTimeNow()
	return v1 + if t.isDST() then -4 else -5 * 3600
end
function t.getETDayString(p1)
	assert(p1 == nil or type(p1) == "number")
	local v2 = p1 or t.getETUnix()
	assert(v2)
	return DateTime.fromUnixTimestamp(v2):FormatUniversalTime("LLLL", "en-us")
end
function t.getETNextDayUnix(p1)
	assert(p1 == nil or type(p1) == "number")
	local v2 = p1 or t.getETUnix()
	assert(v2)
	return (math.floor(v2 / 86400) + 1) * 86400
end
function t.getETWeekUnix(p1)
	assert(p1 == nil or type(p1) == "number")
	local v2 = p1 or t.getETUnix()
	assert(v2)
	return math.floor(math.floor(v2 / 86400) / 7) * 86400 * 7 - 259200
end
function t.getETNextWeekUnix()
	return t.getETWeekUnix() + 604800
end
function t.getSecondsTilNextETDay()
	return t.getETNextDayUnix() - t.getETUnix()
end
return t
