-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CombatConsts = require(ReplicatedStorage.Combat.CombatConsts)
return {
	getRootPartHitRadius = function(rootPart)
		if rootPart.Name ~= "HumanoidRootPart" then
			warn("HumanoidRootPart expected")
		end
		return rootPart:GetAttribute(CombatConsts.ROOT_PART_HIT_RADIUS_ATTR_NAME) or CombatConsts.DEFAULT_ROOT_PART_HIT_RADIUS
	end,
	setRootPartHitRadius = function(rootPart, radius)
		if rootPart.Name ~= "HumanoidRootPart" then
			warn("HumanoidRootPart expected")
		end
		rootPart:SetAttribute(CombatConsts.ROOT_PART_HIT_RADIUS_ATTR_NAME, radius)
	end
}
