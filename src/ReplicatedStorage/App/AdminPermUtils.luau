local module_upvr = {
    isBadimo = function(arg1) -- Line 7, Named "isBadimo"
        local UserId = arg1.UserId
        local var5 = true
        if UserId ~= 2025110 then
            var5 = true
            if UserId ~= 2837719 then
                if UserId ~= 606723718 then
                    var5 = false
                else
                    var5 = true
                end
            end
        end
        return var5
    end;
}
local RunUtils_upvr = require(script.Parent.RunUtils)
local RunConsts_upvr = require(script.Parent.RunConsts)
function module_upvr.hasPerms(arg1) -- Line 12
    if not arg1 then
        warn("Player missing from admin perm function.")
    end
    if RunUtils_upvr.isStudio() then
        return true
    end
    if arg1 and module_upvr.isBadimo(arg1) then
        return true
    end
    if RunUtils_upvr.getEnv() == RunConsts_upvr.QA_NAME then
        return true
    end
    return false
end
return module_upvr