local ProximityCamShakeConsts_upvr = require(script.Parent.ProximityCamShakeConsts)
return {
    setEnabled = function(arg1, arg2) -- Line 4, Named "setEnabled"
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.ENABLED_ATTR_NAME, arg2)
    end;
    setRadius = function(arg1, arg2) -- Line 8, Named "setRadius"
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.RADIUS_ATTR_NAME, arg2)
    end;
    setMagnitude = function(arg1, arg2) -- Line 12, Named "setMagnitude"
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximityCamShakeConsts_upvr.MAGNITUDE_ATTR_NAME, arg2)
    end;
}