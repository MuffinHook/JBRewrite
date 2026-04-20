local SeekingMissileConsts_upvr = require(game:GetService("ReplicatedStorage").SeekingMissile.SeekingMissileConsts)
return {
    getAccel = function(arg1) -- Line 5, Named "getAccel"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.ACCEL_ATTR_NAME)
    end;
    setAccel = function(arg1, arg2) -- Line 8, Named "setAccel"
        arg1:SetAttribute(SeekingMissileConsts_upvr.ACCEL_ATTR_NAME, arg2)
    end;
    getLifeSpan = function(arg1) -- Line 11, Named "getLifeSpan"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.LIFE_SPAN_ATTR_NAME)
    end;
    setLifeSpan = function(arg1, arg2) -- Line 14, Named "setLifeSpan"
        arg1:SetAttribute(SeekingMissileConsts_upvr.LIFE_SPAN_ATTR_NAME, arg2)
    end;
    getSeekAfterDuration = function(arg1) -- Line 17, Named "getSeekAfterDuration"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.SEEK_AFTER_DURATION_ATTR_NAME)
    end;
    setSeekAfterDuration = function(arg1, arg2) -- Line 20, Named "setSeekAfterDuration"
        arg1:SetAttribute(SeekingMissileConsts_upvr.SEEK_AFTER_DURATION_ATTR_NAME, arg2)
    end;
    getNoImprovementExplodeDuration = function(arg1) -- Line 23, Named "getNoImprovementExplodeDuration"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME)
    end;
    setNoImprovementExplodeDuration = function(arg1, arg2) -- Line 26, Named "setNoImprovementExplodeDuration"
        arg1:SetAttribute(SeekingMissileConsts_upvr.NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME, arg2)
    end;
    getConnectHitAfterDuration = function(arg1) -- Line 29, Named "getConnectHitAfterDuration"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.CONNECT_HIT_AFTER_DURATION_ATTR_NAME)
    end;
    setConnectHitAfterDuration = function(arg1, arg2) -- Line 32, Named "setConnectHitAfterDuration"
        arg1:SetAttribute(SeekingMissileConsts_upvr.CONNECT_HIT_AFTER_DURATION_ATTR_NAME, arg2)
    end;
    getDropDuration = function(arg1) -- Line 35, Named "getDropDuration"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.DROP_DURATION_ATTR_NAME)
    end;
    setDropDuration = function(arg1, arg2) -- Line 38, Named "setDropDuration"
        arg1:SetAttribute(SeekingMissileConsts_upvr.DROP_DURATION_ATTR_NAME, arg2)
    end;
    getApplyingThrust = function(arg1) -- Line 41, Named "getApplyingThrust"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.APPLYING_THRUST_ATTR_NAME)
    end;
    getApplyingThrustChangedSignal = function(arg1) -- Line 44, Named "getApplyingThrustChangedSignal"
        return arg1:GetAttributeChangedSignal(SeekingMissileConsts_upvr.APPLYING_THRUST_ATTR_NAME)
    end;
    setApplyingThrust = function(arg1, arg2) -- Line 47, Named "setApplyingThrust"
        arg1:SetAttribute(SeekingMissileConsts_upvr.APPLYING_THRUST_ATTR_NAME, arg2)
    end;
    getTargetPos = function(arg1) -- Line 50, Named "getTargetPos"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.TARGET_POS_ATTR_NAME)
    end;
    getTargetPosChangedSignal = function(arg1) -- Line 53, Named "getTargetPosChangedSignal"
        return arg1:GetAttributeChangedSignal(SeekingMissileConsts_upvr.TARGET_POS_ATTR_NAME)
    end;
    setTargetPos = function(arg1, arg2) -- Line 56, Named "setTargetPos"
        arg1:SetAttribute(SeekingMissileConsts_upvr.TARGET_POS_ATTR_NAME, arg2)
    end;
    getForwardDrag = function(arg1) -- Line 59, Named "getForwardDrag"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.FORWARD_DRAG_ATTR_NAME)
    end;
    setForwardDrag = function(arg1, arg2) -- Line 62, Named "setForwardDrag"
        arg1:SetAttribute(SeekingMissileConsts_upvr.FORWARD_DRAG_ATTR_NAME, arg2)
    end;
    getLateralDrag = function(arg1) -- Line 65, Named "getLateralDrag"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.LATERAL_DRAG_ATTR_NAME)
    end;
    setLateralDrag = function(arg1, arg2) -- Line 68, Named "setLateralDrag"
        arg1:SetAttribute(SeekingMissileConsts_upvr.LATERAL_DRAG_ATTR_NAME, arg2)
    end;
    getAlignResponsiveness = function(arg1) -- Line 71, Named "getAlignResponsiveness"
        return arg1:GetAttribute(SeekingMissileConsts_upvr.ALIGN_RESPONSIVENESS_ATTR_NAME)
    end;
    setAlignResponsiveness = function(arg1, arg2) -- Line 74, Named "setAlignResponsiveness"
        arg1:SetAttribute(SeekingMissileConsts_upvr.ALIGN_RESPONSIVENESS_ATTR_NAME, arg2)
    end;
}