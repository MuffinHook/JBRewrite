local RobberyConsts_upvr = require(game:GetService("ReplicatedStorage").Robbery.RobberyConsts)
return {
    getStatus = function(arg1) -- Line 5, Named "getStatus"
        return arg1:GetAttribute(RobberyConsts_upvr.STATUS_ATTR_NAME)
    end;
    setStatus = function(arg1, arg2) -- Line 8, Named "setStatus"
        if arg1 == nil then
        else
        end
        assert(true, "obj must not be nil")
        if typeof(arg2) ~= "number" then
        else
        end
        assert(true, "value must be a number")
        arg1:SetAttribute(RobberyConsts_upvr.STATUS_ATTR_NAME, arg2)
    end;
    getStatusChangedSignal = function(arg1) -- Line 13, Named "getStatusChangedSignal"
        return arg1:GetAttributeChangedSignal(RobberyConsts_upvr.STATUS_ATTR_NAME)
    end;
    getDisableAutoOpen = function(arg1) -- Line 16, Named "getDisableAutoOpen"
        local var3
        if arg1:GetAttribute(RobberyConsts_upvr.DISABLE_AUTO_OPEN_ATTR_NAME) ~= true then
            var3 = false
        else
            var3 = true
        end
        return var3
    end;
    setDisableAutoOpen = function(arg1, arg2) -- Line 19, Named "setDisableAutoOpen"
        arg1:SetAttribute(RobberyConsts_upvr.DISABLE_AUTO_OPEN_ATTR_NAME, arg2)
        return true
    end;
}