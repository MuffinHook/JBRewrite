local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
return function(player)
	return Promise.new(function(resolve, reject, onCancel)
		local policyInfo = PolicyService:GetPolicyInfoForPlayerAsync(player)
		if not onCancel() then
			resolve(policyInfo)
		end
	end)
end
