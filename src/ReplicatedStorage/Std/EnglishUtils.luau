return {
	getAOrAn = function(p1) --[[ Name: getAOrAn | Line: 5 ]]
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