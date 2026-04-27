local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HashMutex = require(ReplicatedStorage.Mutex.HashMutex)
local cachedMutexes = {}
return {
	getForNamespace = function(namespace)
		if cachedMutexes[namespace] then
			return cachedMutexes[namespace]
		else
			local instance = HashMutex.new()
			cachedMutexes[namespace] = instance
			return instance
		end
	end
}
