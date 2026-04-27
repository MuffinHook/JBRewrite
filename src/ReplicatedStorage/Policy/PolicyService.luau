local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Signal)
local PolicyService = {
	_data = {},
	_observing = {}
}
function PolicyService.setCachedPlayerPolicyInfo(player, policyData)
	PolicyService._data[player.UserId] = policyData
	local observerCallbacks = PolicyService._observing[player.UserId]
	if observerCallbacks then
		PolicyService._observing[player.UserId] = nil
		for index, callback in observerCallbacks do
			callback(policyData)
		end
	end
end
function PolicyService.getCachedPlayerPolicyInfo(player)
	return PolicyService._data[player.UserId]
end
function PolicyService.promiseCachedPlayerPolicyInfo(player)
	local cachedInfo = PolicyService.getCachedPlayerPolicyInfo(player)
	if cachedInfo then
		return Promise.resolve(cachedInfo)
	else
		return Promise.new(function(promiseCallback, resolve, onCancel)
			local UserId = player.UserId
			if not PolicyService._observing[UserId] then
				PolicyService._observing[UserId] = {}
			end
			if not onCancel(function()
				if PolicyService._observing[UserId] then
					local foundIndex = table.find(PolicyService._observing[UserId], promiseCallback)
					if foundIndex then
						table.remove(PolicyService._observing[UserId], foundIndex)
					end
				end
			end) then
				table.insert(PolicyService._observing[UserId], promiseCallback)
			end
		end)
	end
end
function PolicyService.removeCachedPlayerPolicyInfo(player)
	PolicyService._data[player.UserId] = nil
end
return PolicyService
