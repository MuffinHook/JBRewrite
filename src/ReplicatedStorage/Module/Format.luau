local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Localization = require(ReplicatedStorage.Module.Localization)
local Format = {
	Comma = function(amount)
		local leadingPart, digitsToFormat, suffix = string.match(amount, "^([^%d]*%d)(%d*)(.-)$")
		return leadingPart .. digitsToFormat:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
	end
}
function Format.Currency(amount)
	assert(amount ~= nil)
	local roundedAmount = math.floor(amount + 0.5)
	return if roundedAmount >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", { Format.Comma((math.abs(roundedAmount))) })
end
function Format.MinSec(amount)
	local result = ""
	local minutes = math.floor(amount / 60)
	local seconds = amount % 60
	if minutes > 0 then
		result = result .. ("%d minute"):format(minutes)
		if minutes ~= 1 then
			result = result .. "s"
		end
	end
	if minutes > 0 and seconds > 0 then
		result = result .. " and "
	end
	if seconds > 0 then
		result = result .. ("%d second"):format(seconds)
		if seconds ~= 1 then
			result = result .. "s"
		end
	end
	return result
end
return Format
