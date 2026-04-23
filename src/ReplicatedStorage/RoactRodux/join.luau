return function(...) --[[ Name: join | Line: 1 ]]
	local t = {}
	for i = 1, select("#", ...) do
		local v1 = select(i, ...)
		if v1 ~= nil then
			for k, v in pairs(v1) do
				t[k] = v
			end
		end
	end
	return t
end