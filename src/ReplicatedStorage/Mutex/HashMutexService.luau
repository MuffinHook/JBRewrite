-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HashMutex = require(ReplicatedStorage.Mutex.HashMutex)
local t = {}
return {
	getForNamespace = function(p1)
		if t[p1] then
			return t[p1]
		else
			local instance = HashMutex.new()
			t[p1] = instance
			return instance
		end
	end
}
