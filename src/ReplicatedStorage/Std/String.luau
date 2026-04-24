-- Reviewed by Claude
-- variables reassigned
local StringUtils = {
	comma = function(number)
		local before, middle, after = string.match(tostring(number), "^([^%d]*%d)(%d*)(.-)$")
		return before .. middle:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. after
	end,
	getSortableStringFromNumber = function(number, precision)
		assert(number ~= nil)
		assert(precision ~= nil)
		assert(precision >= 0)
		return ("%0." .. tostring(precision) .. "d"):format(number)
	end,
	base85UUID = function(length)
		local chars = {}
		for i = 1, length do
			local randomIndex = math.random(1, 85)
			table.insert(chars, (string.sub("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&<>()[]{}@%$#", randomIndex, randomIndex)))
		end
		return table.concat(chars)
	end,
	getSuffixForNumber = function(number)
		local twoDigits = number % 100
		if twoDigits == 11 or (twoDigits == 12 or twoDigits == 13) then
			return "th"
		else
			local lastDigit = number % 10
			if lastDigit == 1 then
				return "st"
			elseif lastDigit == 2 then
				return "nd"
			elseif lastDigit == 3 then
				return "rd"
			else
				return "th"
			end
		end
	end
}
local function formatCount(number)
	if number % 1 <= 0.001 then
		return tostring((math.floor(number)))
	else
		return ("%.1f"):format(number)
	end
end
function StringUtils.getShortHand(number)
	local suffixes = { "", "K", "M", "B", "T", "Q" }
	local suffixIndex = 1
	while number >= 1000 and suffixIndex < #suffixes do
		number = number / 1000
		suffixIndex = suffixIndex + 1
	end
	if suffixIndex > 1 then
		return if number % 1 <= 0.001 then tostring((math.floor(number))) else ("%.1f"):format(number) .. suffixes[suffixIndex]
	else
		return tostring(number)
	end
end
return StringUtils
