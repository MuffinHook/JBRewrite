-- Reviewed by Claude
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
return function(p1)
	return Promise.new(function(p12, p2, p3)
		local v1 = PolicyService:GetPolicyInfoForPlayerAsync(p1)
		if not p3() then
			p12(v1)
		end
	end)
end
