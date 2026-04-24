-- Reviewed by Claude
local NoneProxy = newproxy(true)
getmetatable(NoneProxy).__tostring = function()
	return "None"
end
return {
	None = NoneProxy,
	merge = function(...)
		local merged = {}
		for i = 1, select("#", ...) do
			local dict = select(i, ...)
			if dict ~= nil then
				for k, v in pairs(dict) do
					if v == NoneProxy then
						merged[k] = nil
					else
						merged[k] = v
					end
				end
			end
		end
		return merged
	end
}
