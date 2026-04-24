-- Reviewed by Claude
-- variables reassigned
return {
	getAOrAn = function(p1)
		if ({
			a = true,
			e = true,
			i = true,
			o = true,
			u = true
		})[p1:sub(1, 1):lower()] then
			return "an"
		else
			return "a"
		end
	end
}
