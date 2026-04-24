-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlaneConsts = require(ReplicatedStorage.Plane.PlaneConsts)
return {
	getOrigin = function(p1)
		return p1:GetAttribute(PlaneConsts.ORIGIN_ATTR_NAME)
	end,
	setOrigin = function(p1, p2)
		p1:SetAttribute(PlaneConsts.ORIGIN_ATTR_NAME, p2)
	end,
	getTarget = function(p1)
		return p1:GetAttribute(PlaneConsts.TARGET_ATTR_NAME)
	end,
	setTarget = function(p1, p2)
		p1:SetAttribute(PlaneConsts.TARGET_ATTR_NAME, p2)
	end,
	setTypeEnum = function(p1, p2)
		p1:SetAttribute(PlaneConsts.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME, p2)
		return true
	end,
	getTypeEnum = function(p1)
		local v1 = p1:GetAttribute(PlaneConsts.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME)
		assert(v1, "Airdrop has no type")
		return v1
	end,
	getBornAt = function(p1)
		return p1:GetAttribute(PlaneConsts.BORN_AT_ATTR_NAME)
	end,
	setBornAt = function(p1, p2)
		p1:SetAttribute(PlaneConsts.BORN_AT_ATTR_NAME, p2)
	end,
	getSpeed = function(p1)
		return p1:GetAttribute(PlaneConsts.SPEED_ATTR_NAME)
	end,
	setSpeed = function(p1, p2)
		p1:SetAttribute(PlaneConsts.SPEED_ATTR_NAME, p2)
	end,
	getDuration = function(p1, p2, p3)
		return (p2 - p1).Magnitude / p3
	end,
	getPositionAt = function(p1, p2, p3, p4, p5)
		local v1 = p3 - p2
		return p2 + v1 * (p1 / p5) + v1.Unit:Cross(Vector3.new(0, 1, 0)) * p4 * math.cos(p1)
	end
}
