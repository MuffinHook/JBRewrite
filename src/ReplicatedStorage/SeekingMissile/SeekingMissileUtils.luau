local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
return {
	getAccel = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.ACCEL_ATTR_NAME)
	end,
	setAccel = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.ACCEL_ATTR_NAME, value)
	end,
	getLifeSpan = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.LIFE_SPAN_ATTR_NAME)
	end,
	setLifeSpan = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.LIFE_SPAN_ATTR_NAME, value)
	end,
	getSeekAfterDuration = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.SEEK_AFTER_DURATION_ATTR_NAME)
	end,
	setSeekAfterDuration = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.SEEK_AFTER_DURATION_ATTR_NAME, value)
	end,
	getNoImprovementExplodeDuration = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME)
	end,
	setNoImprovementExplodeDuration = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME, value)
	end,
	getConnectHitAfterDuration = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.CONNECT_HIT_AFTER_DURATION_ATTR_NAME)
	end,
	setConnectHitAfterDuration = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.CONNECT_HIT_AFTER_DURATION_ATTR_NAME, value)
	end,
	getDropDuration = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.DROP_DURATION_ATTR_NAME)
	end,
	setDropDuration = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.DROP_DURATION_ATTR_NAME, value)
	end,
	getApplyingThrust = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME)
	end,
	getApplyingThrustChangedSignal = function(missile)
		return missile:GetAttributeChangedSignal(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME)
	end,
	setApplyingThrust = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME, value)
	end,
	getTargetPos = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.TARGET_POS_ATTR_NAME)
	end,
	getTargetPosChangedSignal = function(missile)
		return missile:GetAttributeChangedSignal(SeekingMissileConsts.TARGET_POS_ATTR_NAME)
	end,
	setTargetPos = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.TARGET_POS_ATTR_NAME, value)
	end,
	getForwardDrag = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.FORWARD_DRAG_ATTR_NAME)
	end,
	setForwardDrag = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.FORWARD_DRAG_ATTR_NAME, value)
	end,
	getLateralDrag = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.LATERAL_DRAG_ATTR_NAME)
	end,
	setLateralDrag = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.LATERAL_DRAG_ATTR_NAME, value)
	end,
	getAlignResponsiveness = function(missile)
		return missile:GetAttribute(SeekingMissileConsts.ALIGN_RESPONSIVENESS_ATTR_NAME)
	end,
	setAlignResponsiveness = function(missile, value)
		missile:SetAttribute(SeekingMissileConsts.ALIGN_RESPONSIVENESS_ATTR_NAME, value)
	end
}
