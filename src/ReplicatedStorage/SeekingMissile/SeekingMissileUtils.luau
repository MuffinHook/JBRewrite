-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
return {
	getAccel = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.ACCEL_ATTR_NAME)
	end,
	setAccel = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.ACCEL_ATTR_NAME, p2)
	end,
	getLifeSpan = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.LIFE_SPAN_ATTR_NAME)
	end,
	setLifeSpan = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.LIFE_SPAN_ATTR_NAME, p2)
	end,
	getSeekAfterDuration = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.SEEK_AFTER_DURATION_ATTR_NAME)
	end,
	setSeekAfterDuration = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.SEEK_AFTER_DURATION_ATTR_NAME, p2)
	end,
	getNoImprovementExplodeDuration = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME)
	end,
	setNoImprovementExplodeDuration = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME, p2)
	end,
	getConnectHitAfterDuration = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.CONNECT_HIT_AFTER_DURATION_ATTR_NAME)
	end,
	setConnectHitAfterDuration = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.CONNECT_HIT_AFTER_DURATION_ATTR_NAME, p2)
	end,
	getDropDuration = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.DROP_DURATION_ATTR_NAME)
	end,
	setDropDuration = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.DROP_DURATION_ATTR_NAME, p2)
	end,
	getApplyingThrust = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME)
	end,
	getApplyingThrustChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME)
	end,
	setApplyingThrust = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME, p2)
	end,
	getTargetPos = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.TARGET_POS_ATTR_NAME)
	end,
	getTargetPosChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal(SeekingMissileConsts.TARGET_POS_ATTR_NAME)
	end,
	setTargetPos = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.TARGET_POS_ATTR_NAME, p2)
	end,
	getForwardDrag = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.FORWARD_DRAG_ATTR_NAME)
	end,
	setForwardDrag = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.FORWARD_DRAG_ATTR_NAME, p2)
	end,
	getLateralDrag = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.LATERAL_DRAG_ATTR_NAME)
	end,
	setLateralDrag = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.LATERAL_DRAG_ATTR_NAME, p2)
	end,
	getAlignResponsiveness = function(p1)
		return p1:GetAttribute(SeekingMissileConsts.ALIGN_RESPONSIVENESS_ATTR_NAME)
	end,
	setAlignResponsiveness = function(p1, p2)
		p1:SetAttribute(SeekingMissileConsts.ALIGN_RESPONSIVENESS_ATTR_NAME, p2)
	end
}
