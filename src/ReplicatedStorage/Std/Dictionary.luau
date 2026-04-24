-- Reviewed by Claude
local v1 = newproxy(true)
getmetatable(v1).__tostring = function()
	return "None"
end
return {
	None = v1,
	merge = function(...)
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
