local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
return function(p1) --[[ Line: 4 | Upvalues: Promise (copy), PolicyService (copy) ]]
	return Promise.new(function(p12, p2, p3) --[[ Line: 5 | Upvalues: PolicyService (ref), p1 (copy) ]]
		local v1 = PolicyService:GetPolicyInfoForPlayerAsync(p1)
		if not p3() then
			p12(v1)
		end
	end)
end