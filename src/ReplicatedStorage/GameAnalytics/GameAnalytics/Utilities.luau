-- Reviewed by Claude
return {
	isStringNullOrEmpty = function(p1, p2)
		return not p2 or #p2 == 0
	end,
	stringArrayContainsString = function(p1, p2, p3)
		if #p2 ~= 0 then
			for i, v in ipairs(p2) do
				if v == p3 then
					return true
				end
			end
		end
		return false
	end,
	copyTable = function(p1, p2)
		local t = {}
		for k, v in pairs(p2) do
			if typeof(v) == "table" then
				t[k] = p1:copyTable(v)
			else
				t[k] = v
			end
		end
		return t
	end
}
