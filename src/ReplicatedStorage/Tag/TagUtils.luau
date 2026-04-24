-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
return {
	isPointInTag = function(p1, p2)
		for i, v in ipairs(CollectionService:GetTagged(p2)) do
			assert(v:IsA("BasePart"))
			if RegionUtils.CastPoint({
				c = v.CFrame,
				s = v.Size
			}, p1) then
				return true
			end
		end
		return false
	end
}
