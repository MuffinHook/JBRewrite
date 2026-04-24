-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HashMutex = require(ReplicatedStorage.Mutex.HashMutex)
local t = {}
return {
	getForNamespace = function(p1)
		if t[p1] then
			return t[p1]
		else
			local v1 = HashMutex.new()
			t[p1] = v1
			return v1
		end
	end
}
