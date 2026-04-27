local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlaneConsts = require(ReplicatedStorage.Plane.PlaneConsts)
return {
	getOrigin = function(instance)
		return instance:GetAttribute(PlaneConsts.ORIGIN_ATTR_NAME)
	end,
	setOrigin = function(instance, originValue)
		instance:SetAttribute(PlaneConsts.ORIGIN_ATTR_NAME, originValue)
	end,
	getTarget = function(instance)
		return instance:GetAttribute(PlaneConsts.TARGET_ATTR_NAME)
	end,
	setTarget = function(instance, targetValue)
		instance:SetAttribute(PlaneConsts.TARGET_ATTR_NAME, targetValue)
	end,
	setTypeEnum = function(instance, typeEnumValue)
		instance:SetAttribute(PlaneConsts.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME, typeEnumValue)
		return true
	end,
	getTypeEnum = function(instance)
		local typeEnum = instance:GetAttribute(PlaneConsts.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME)
		assert(typeEnum, "Airdrop has no type")
		return typeEnum
	end,
	getBornAt = function(instance)
		return instance:GetAttribute(PlaneConsts.BORN_AT_ATTR_NAME)
	end,
	setBornAt = function(instance, bornAtValue)
		instance:SetAttribute(PlaneConsts.BORN_AT_ATTR_NAME, bornAtValue)
	end,
	getSpeed = function(instance)
		return instance:GetAttribute(PlaneConsts.SPEED_ATTR_NAME)
	end,
	setSpeed = function(instance, speedValue)
		instance:SetAttribute(PlaneConsts.SPEED_ATTR_NAME, speedValue)
	end,
	getDuration = function(startPosition, endPosition, speed)
		return (endPosition - startPosition).Magnitude / speed
	end,
	getPositionAt = function(progress, startPosition, endPosition, amplitude, duration)
		local directionVector = endPosition - startPosition
		return startPosition + directionVector * (progress / duration) + directionVector.Unit:Cross(Vector3.new(0, 1, 0)) * amplitude * math.cos(progress)
	end
}
