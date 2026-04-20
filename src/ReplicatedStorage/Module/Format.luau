local module_upvr = {
    Comma = function(arg1) -- Line 6, Named "Comma"
        local string_match_result1, string_match_result2, string_match_result3 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
        return string_match_result1..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3
    end;
}
local Localization_upvr = require(game:GetService("ReplicatedStorage").Module.Localization)
function module_upvr.Currency(arg1) -- Line 10
    if arg1 == nil then
    else
    end
    assert(true)
    local rounded = math.floor(arg1 + 0.5)
    if 0 <= rounded then
    else
    end
    return '-'..Localization_upvr:FormatByKey("General.Cash", {module_upvr.Comma(math.abs(rounded))})
end
function module_upvr.MinSec(arg1) -- Line 20
    local floored = math.floor(arg1 / 60)
    local var12 = arg1 % 60
    local var13
    if 0 < floored then
        var13 = var13.."%d minute":format(floored)
        if floored ~= 1 then
            var13 = var13..'s'
        end
    end
    if 0 < floored and 0 < var12 then
        var13 = var13.." and "
    end
    if 0 < var12 then
        var13 = var13.."%d second":format(var12)
        if var12 ~= 1 then
            var13 = var13..'s'
        end
    end
    return var13
end
return module_upvr