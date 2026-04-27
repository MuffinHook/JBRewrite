return {
	polynomialRollingHash = function(str)
		assert(typeof(str) == "string", "str must be string")
		local hash = 0
		for i = 1, #str do
			hash = (hash * 31 + string.byte(str, i)) % 1000000009
		end
		return hash
	end
}
