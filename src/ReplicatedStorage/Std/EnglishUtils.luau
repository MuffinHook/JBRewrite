return {
	getAOrAn = function(word)
		if ({
			a = true,
			e = true,
			i = true,
			o = true,
			u = true
		})[word:sub(1, 1):lower()] then
			return "an"
		else
			return "a"
		end
	end
}
