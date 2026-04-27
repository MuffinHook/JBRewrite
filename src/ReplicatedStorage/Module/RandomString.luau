return {
	varSafe = function(length)
		local characters = {}
		for i = 1, length do
			local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
			if i ~= 1 then
				charset = charset .. "012345689"
			end
			local randomIndex = math.random(1, #charset)
			table.insert(characters, charset:sub(randomIndex, randomIndex))
		end
		return table.concat(characters)
	end
}
