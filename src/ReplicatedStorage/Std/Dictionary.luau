local v1 = newproxy(true)
getmetatable(v1).__tostring = function() --[[ Line: 7 ]]
	return "None"
end
return {
	None = v1,
	merge = function(...) --[[ Name: merge | Line: 11 | Upvalues: v1 (copy) ]]
		local t = {}
		for i = 1, select("#", ...) do
			local v12 = select(i, ...)
			if v12 ~= nil then
				for k, v in pairs(v12) do
					if v == v1 then
						t[k] = nil
					else
						t[k] = v
					end
				end
			end
		end
		return t
	end
}