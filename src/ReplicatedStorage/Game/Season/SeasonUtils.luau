local HttpService_upvr = game:GetService("HttpService")
local SeasonConsts_upvr = require(script.Parent.SeasonConsts)
local module_upvr = {
    getRemainingTime = function() -- Line 8, Named "getRemainingTime"
        return SeasonConsts_upvr.SEASON_END_UNIX - DateTime.now().UnixTimestamp
    end;
    getRemainingBuyTime = function() -- Line 13, Named "getRemainingBuyTime"
        return SeasonConsts_upvr.BUY_END_UNIX - DateTime.now().UnixTimestamp
    end;
    getSeasonExpMult = function() -- Line 18, Named "getSeasonExpMult"
        if SeasonConsts_upvr.AUTOMATE_SEASON_XP_MULT then
            if SeasonConsts_upvr.SEASON_XP_MULT_START_UNIX < DateTime.now().UnixTimestamp then
                return SeasonConsts_upvr.SEASON_XP_MULT
            end
            return 1
        end
        return SeasonConsts_upvr.SEASON_XP_MULT
    end;
}
function module_upvr.isBuyEnabled() -- Line 32
    local var4 = false
    if module_upvr.getRemainingTime() < 0 then
        if 0 > module_upvr.getRemainingBuyTime() then
            var4 = false
        else
            var4 = true
        end
    end
    return var4
end
local tbl_upvr = {}
local Promise_upvr = require(game:GetService("ReplicatedStorage").Std.Promise)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function module_upvr.getProductPrice(arg1) -- Line 36
    if tbl_upvr[arg1] then
        return Promise_upvr.resolve(tbl_upvr[arg1])
    end
    return Promise_upvr.defer(function(arg1_2) -- Line 40
        local PriceInRobux = MarketplaceService_upvr:GetProductInfo(arg1, Enum.InfoType.Product).PriceInRobux
        tbl_upvr[arg1] = PriceInRobux
        arg1_2(PriceInRobux)
    end)
end
function module_upvr.serializeLevelsAwarded(arg1) -- Line 47
    local var10
    if type(arg1) ~= "table" then
        var10 = false
    else
        var10 = true
    end
    assert(var10)
    return HttpService_upvr:JSONEncode(arg1)
end
function module_upvr.deserializeLevelsAwarded(arg1) -- Line 51
    local var11
    if type(arg1) ~= "string" then
        var11 = false
    else
        var11 = true
    end
    assert(var11)
    return HttpService_upvr:JSONDecode(arg1)
end
function module_upvr.formatRemaining(arg1) -- Line 55
    local maximum = math.max(0, arg1)
    local floored = math.floor(maximum / 86400)
    local floored_4 = math.floor(maximum % 86400 / 3600)
    local floored_3 = math.floor(maximum % 3600 / 60)
    local floored_2 = math.floor(maximum % 60)
    if 0 < floored then
        return "%dd %dh":format(floored, floored_4)
    end
    if 0 < floored_4 then
        return "%dh %dm":format(floored_4, floored_3)
    end
    if 0 < floored_3 then
        return "%dm %ds":format(floored_3, floored_2)
    end
    return "%ds":format(floored_2)
end
return module_upvr