local VaultConsts_upvr = require(script.Parent.VaultConsts)
local function _(arg1) -- Line 3, Named "validateObj"
    if arg1 == nil then
    else
    end
    assert(true)
    assert(arg1:IsA("Instance"))
end
return {
    getArmingTeamId = function(arg1) -- Line 9, Named "getArmingTeamId"
        if arg1 == nil then
        else
        end
        assert(true)
        assert(arg1:IsA("Instance"))
        return arg1:GetAttribute(VaultConsts_upvr.ARMING_TEAM_ID_ATTR_NAME)
    end;
    setArmingTeamId = function(arg1, arg2) -- Line 13, Named "setArmingTeamId"
        if arg1 == nil then
        else
        end
        assert(true)
        assert(arg1:IsA("Instance"))
        arg1:SetAttribute(VaultConsts_upvr.ARMING_TEAM_ID_ATTR_NAME, arg2)
    end;
}