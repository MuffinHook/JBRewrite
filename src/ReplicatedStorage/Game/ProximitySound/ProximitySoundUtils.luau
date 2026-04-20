local ProximitySoundConsts_upvr = require(script.Parent.ProximitySoundConsts)
return {
    setEnabled = function(arg1, arg2) -- Line 4, Named "setEnabled"
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximitySoundConsts_upvr.ENABLED_ATTR_NAME, arg2)
    end;
    setRadius = function(arg1, arg2) -- Line 9, Named "setRadius"
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximitySoundConsts_upvr.RADIUS_ATTR_NAME, arg2)
    end;
    setId = function(arg1, arg2) -- Line 14, Named "setId"
        if arg1 == nil then
        else
        end
        assert(true)
        if typeof(arg2) ~= "number" then
        else
        end
        assert(true)
        arg1:SetAttribute(ProximitySoundConsts_upvr.ID_ATTR_NAME, arg2)
    end;
}