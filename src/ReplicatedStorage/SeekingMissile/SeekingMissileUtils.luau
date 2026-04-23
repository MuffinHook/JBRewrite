local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeekingMissileConsts = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
return {
	getAccel = function(p1) --[[ Name: getAccel | Line: 5 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.ACCEL_ATTR_NAME)
	end,
	setAccel = function(p1, p2) --[[ Name: setAccel | Line: 8 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.ACCEL_ATTR_NAME, p2)
	end,
	getLifeSpan = function(p1) --[[ Name: getLifeSpan | Line: 11 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.LIFE_SPAN_ATTR_NAME)
	end,
	setLifeSpan = function(p1, p2) --[[ Name: setLifeSpan | Line: 14 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.LIFE_SPAN_ATTR_NAME, p2)
	end,
	getSeekAfterDuration = function(p1) --[[ Name: getSeekAfterDuration | Line: 17 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.SEEK_AFTER_DURATION_ATTR_NAME)
	end,
	setSeekAfterDuration = function(p1, p2) --[[ Name: setSeekAfterDuration | Line: 20 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.SEEK_AFTER_DURATION_ATTR_NAME, p2)
	end,
	getNoImprovementExplodeDuration = function(p1) --[[ Name: getNoImprovementExplodeDuration | Line: 23 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME)
	end,
	setNoImprovementExplodeDuration = function(p1, p2) --[[ Name: setNoImprovementExplodeDuration | Line: 26 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME, p2)
	end,
	getConnectHitAfterDuration = function(p1) --[[ Name: getConnectHitAfterDuration | Line: 29 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.CONNECT_HIT_AFTER_DURATION_ATTR_NAME)
	end,
	setConnectHitAfterDuration = function(p1, p2) --[[ Name: setConnectHitAfterDuration | Line: 32 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.CONNECT_HIT_AFTER_DURATION_ATTR_NAME, p2)
	end,
	getDropDuration = function(p1) --[[ Name: getDropDuration | Line: 35 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.DROP_DURATION_ATTR_NAME)
	end,
	setDropDuration = function(p1, p2) --[[ Name: setDropDuration | Line: 38 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.DROP_DURATION_ATTR_NAME, p2)
	end,
	getApplyingThrust = function(p1) --[[ Name: getApplyingThrust | Line: 41 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME)
	end,
	getApplyingThrustChangedSignal = function(p1) --[[ Name: getApplyingThrustChangedSignal | Line: 44 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttributeChangedSignal(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME)
	end,
	setApplyingThrust = function(p1, p2) --[[ Name: setApplyingThrust | Line: 47 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.APPLYING_THRUST_ATTR_NAME, p2)
	end,
	getTargetPos = function(p1) --[[ Name: getTargetPos | Line: 50 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.TARGET_POS_ATTR_NAME)
	end,
	getTargetPosChangedSignal = function(p1) --[[ Name: getTargetPosChangedSignal | Line: 53 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttributeChangedSignal(SeekingMissileConsts.TARGET_POS_ATTR_NAME)
	end,
	setTargetPos = function(p1, p2) --[[ Name: setTargetPos | Line: 56 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.TARGET_POS_ATTR_NAME, p2)
	end,
	getForwardDrag = function(p1) --[[ Name: getForwardDrag | Line: 59 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.FORWARD_DRAG_ATTR_NAME)
	end,
	setForwardDrag = function(p1, p2) --[[ Name: setForwardDrag | Line: 62 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.FORWARD_DRAG_ATTR_NAME, p2)
	end,
	getLateralDrag = function(p1) --[[ Name: getLateralDrag | Line: 65 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.LATERAL_DRAG_ATTR_NAME)
	end,
	setLateralDrag = function(p1, p2) --[[ Name: setLateralDrag | Line: 68 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.LATERAL_DRAG_ATTR_NAME, p2)
	end,
	getAlignResponsiveness = function(p1) --[[ Name: getAlignResponsiveness | Line: 71 | Upvalues: SeekingMissileConsts (copy) ]]
		return p1:GetAttribute(SeekingMissileConsts.ALIGN_RESPONSIVENESS_ATTR_NAME)
	end,
	setAlignResponsiveness = function(p1, p2) --[[ Name: setAlignResponsiveness | Line: 74 | Upvalues: SeekingMissileConsts (copy) ]]
		p1:SetAttribute(SeekingMissileConsts.ALIGN_RESPONSIVENESS_ATTR_NAME, p2)
	end
}