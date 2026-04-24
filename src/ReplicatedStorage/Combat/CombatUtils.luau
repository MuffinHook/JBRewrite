-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CombatConsts = require(ReplicatedStorage.Combat.CombatConsts)
return {
	getRootPartHitRadius = function(p1)
		if p1.Name ~= "HumanoidRootPart" then
			warn("HumanoidRootPart expected")
		end
		return p1:GetAttribute(CombatConsts.ROOT_PART_HIT_RADIUS_ATTR_NAME) or CombatConsts.DEFAULT_ROOT_PART_HIT_RADIUS
	end,
	setRootPartHitRadius = function(p1, p2)
		if p1.Name ~= "HumanoidRootPart" then
			warn("HumanoidRootPart expected")
		end
		p1:SetAttribute(CombatConsts.ROOT_PART_HIT_RADIUS_ATTR_NAME, p2)
	end
}
