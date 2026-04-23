return {
	varSafe = function(p1) --[[ Name: varSafe | Line: 2 ]]
		local t = {}
		for i = 1, p1 do
			local v1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
			if i ~= 1 then
				v1 = v1 .. "012345689"
			end
			local v2 = math.random(1, #v1)
			table.insert(t, v1:sub(v2, v2))
		end
		return table.concat(t)
	end
}