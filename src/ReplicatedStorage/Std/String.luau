-- Reviewed by Claude
local t = {
	comma = function(p1)
		local v1, v2, v3 = string.match(tostring(p1), "^([^%d]*%d)(%d*)(.-)$")
		return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
	end,
	getSortableStringFromNumber = function(p1, p2)
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		assert(p2 >= 0)
		return ("%0." .. tostring(p2) .. "d"):format(p1)
	end,
	base85UUID = function(p1)
		local t = {}
		for i = 1, p1 do
			local v1 = math.random(1, 85)
			table.insert(t, (string.sub("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&<>()[]{}@%$#", v1, v1)))
		end
		return table.concat(t)
	end,
	getSuffixForNumber = function(p1)
		local v1 = p1 % 100
		if v1 == 11 or (v1 == 12 or v1 == 13) then
			return "th"
		else
			local v2 = p1 % 10
			if v2 == 1 then
				return "st"
			elseif v2 == 2 then
				return "nd"
			elseif v2 == 3 then
				return "rd"
			else
				return "th"
			end
		end
	end
}
local function formatCount(p1)
	if p1 % 1 <= 0.001 then
		return tostring((math.floor(p1)))
	else
		return ("%.1f"):format(p1)
	end
end
function t.getShortHand(p1)
	local t = { "", "K", "M", "B", "T", "Q" }
	local count = 1
	while p1 >= 1000 and count < #t do
		p1 = p1 / 1000
		count = count + 1
	end
	if count > 1 then
		return if p1 % 1 <= 0.001 then tostring((math.floor(p1))) else ("%.1f"):format(p1) .. t[count]
	else
		return tostring(p1)
	end
end
return t
