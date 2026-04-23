return {
	polynomialRollingHash = function(p1) --[[ Name: polynomialRollingHash | Line: 5 ]]
		assert(typeof(p1) == "string", "str must be string")
		local v2 = 0
		for i = 1, #p1 do
			v2 = (v2 * 31 + string.byte(p1, i)) % 1000000009
		end
		return v2
	end
}