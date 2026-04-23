return {
	named = function(p1) --[[ Name: named | Line: 17 ]]
		assert(type(p1) == "string", "Symbols must be created using a string name!")
		local v2 = newproxy(true)
		local v3 = ("Symbol(%s)"):format(p1)
		getmetatable(v2).__tostring = function() --[[ Line: 24 | Upvalues: v3 (copy) ]]
			return v3
		end
		return v2
	end
}