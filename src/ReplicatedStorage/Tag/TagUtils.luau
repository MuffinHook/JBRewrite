local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
return {
	isPointInTag = function(pointToCheck, tagName)
		for i, part in ipairs(CollectionService:GetTagged(tagName)) do
			assert(part:IsA("BasePart"))
			if RegionUtils.CastPoint({
				c = part.CFrame,
				s = part.Size
			}, pointToCheck) then
				return true
			end
		end
		return false
	end
}
