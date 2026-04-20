local PlaneConsts_upvr = require(game:GetService("ReplicatedStorage").Plane.PlaneConsts)
return {
    getOrigin = function(arg1) -- Line 5, Named "getOrigin"
        return arg1:GetAttribute(PlaneConsts_upvr.ORIGIN_ATTR_NAME)
    end;
    setOrigin = function(arg1, arg2) -- Line 8, Named "setOrigin"
        arg1:SetAttribute(PlaneConsts_upvr.ORIGIN_ATTR_NAME, arg2)
    end;
    getTarget = function(arg1) -- Line 11, Named "getTarget"
        return arg1:GetAttribute(PlaneConsts_upvr.TARGET_ATTR_NAME)
    end;
    setTarget = function(arg1, arg2) -- Line 14, Named "setTarget"
        arg1:SetAttribute(PlaneConsts_upvr.TARGET_ATTR_NAME, arg2)
    end;
    setTypeEnum = function(arg1, arg2) -- Line 17, Named "setTypeEnum"
        arg1:SetAttribute(PlaneConsts_upvr.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME, arg2)
        return true
    end;
    getTypeEnum = function(arg1) -- Line 21, Named "getTypeEnum"
        local attribute = arg1:GetAttribute(PlaneConsts_upvr.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME)
        assert(attribute, "Airdrop has no type")
        return attribute
    end;
    getBornAt = function(arg1) -- Line 26, Named "getBornAt"
        return arg1:GetAttribute(PlaneConsts_upvr.BORN_AT_ATTR_NAME)
    end;
    setBornAt = function(arg1, arg2) -- Line 29, Named "setBornAt"
        arg1:SetAttribute(PlaneConsts_upvr.BORN_AT_ATTR_NAME, arg2)
    end;
    getSpeed = function(arg1) -- Line 32, Named "getSpeed"
        return arg1:GetAttribute(PlaneConsts_upvr.SPEED_ATTR_NAME)
    end;
    setSpeed = function(arg1, arg2) -- Line 35, Named "setSpeed"
        arg1:SetAttribute(PlaneConsts_upvr.SPEED_ATTR_NAME, arg2)
    end;
    getDuration = function(arg1, arg2, arg3) -- Line 38, Named "getDuration"
        return (arg2 - arg1).Magnitude / arg3
    end;
    getPositionAt = function(arg1, arg2, arg3, arg4, arg5) -- Line 43, Named "getPositionAt"
        local var4 = arg3 - arg2
        return arg2 + (var4) * (arg1 / arg5) + var4.Unit:Cross(Vector3.new(0, 1, 0)) * arg4 * math.cos(arg1)
    end;
}