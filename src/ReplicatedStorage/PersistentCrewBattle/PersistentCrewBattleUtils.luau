local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage_upvr.PersistentCrewBattle.PersistentCrewBattleConsts)
local module_upvr = {
    getBattleServerInitTime = function() -- Line 6, Named "getBattleServerInitTime"
        return ReplicatedStorage_upvr:GetAttribute(PersistentCrewBattleConsts_upvr.BATTLE_SERVER_INIT_TIME_ATTR_NAME)
    end;
    setBattleServerInitTime = function(arg1) -- Line 9, Named "setBattleServerInitTime"
        return ReplicatedStorage_upvr:SetAttribute(PersistentCrewBattleConsts_upvr.BATTLE_SERVER_INIT_TIME_ATTR_NAME, arg1)
    end;
    getRoundStartsAt = function() -- Line 12, Named "getRoundStartsAt"
        return ReplicatedStorage_upvr:GetAttribute(PersistentCrewBattleConsts_upvr.ROUND_STARTS_AT_ATTR_NAME)
    end;
    setRoundStartsAt = function(arg1) -- Line 15, Named "setRoundStartsAt"
        ReplicatedStorage_upvr:SetAttribute(PersistentCrewBattleConsts_upvr.ROUND_STARTS_AT_ATTR_NAME, arg1)
    end;
    getRoundStartsAtAttributeChangedSignal = function() -- Line 18, Named "getRoundStartsAtAttributeChangedSignal"
        return ReplicatedStorage_upvr:GetAttributeChangedSignal(PersistentCrewBattleConsts_upvr.ROUND_STARTS_AT_ATTR_NAME)
    end;
    getCrewStartTime = function(arg1) -- Line 21, Named "getCrewStartTime"
        return arg1:GetAttribute(PersistentCrewBattleConsts_upvr.ROUND_START_ATTR_NAME)
    end;
    setCrewStartTime = function(arg1, arg2) -- Line 24, Named "setCrewStartTime"
        arg1:SetAttribute(PersistentCrewBattleConsts_upvr.ROUND_START_ATTR_NAME, arg2)
    end;
    getCrewPenaltyDuration = function(arg1) -- Line 27, Named "getCrewPenaltyDuration"
        return arg1:GetAttribute(PersistentCrewBattleConsts_upvr.ROUND_PENALTY_DURATION_ATTR_NAME)
    end;
    setCrewPenaltyDuration = function(arg1, arg2) -- Line 30, Named "setCrewPenaltyDuration"
        arg1:SetAttribute(PersistentCrewBattleConsts_upvr.ROUND_PENALTY_DURATION_ATTR_NAME, arg2)
    end;
}
function module_upvr.getCrewDurationElapsed(arg1) -- Line 33
    return workspace:GetServerTimeNow() - module_upvr.getCrewStartTime(arg1)
end
function module_upvr.getCrewEffectiveDurationElapsed(arg1) -- Line 37
    return module_upvr.getCrewDurationElapsed(arg1) + module_upvr.getCrewPenaltyDuration(arg1)
end
function module_upvr.getCrewTimeTook(arg1) -- Line 41
    return arg1:GetAttribute(PersistentCrewBattleConsts_upvr.ROUND_TIME_TOOK_ATTR_NAME)
end
function module_upvr.setCrewRoundTimeTook(arg1, arg2) -- Line 44
    arg1:SetAttribute(PersistentCrewBattleConsts_upvr.ROUND_TIME_TOOK_ATTR_NAME, arg2)
end
function module_upvr.getCrewRoundRobberiesDone(arg1) -- Line 47
    return arg1:GetAttribute(PersistentCrewBattleConsts_upvr.ROUND_ROBBERIES_DONE_ATTR_NAME)
end
function module_upvr.setCrewRoundRobberiesDone(arg1, arg2) -- Line 50
    arg1:SetAttribute(PersistentCrewBattleConsts_upvr.ROUND_ROBBERIES_DONE_ATTR_NAME, arg2)
end
function module_upvr.getAttackingCrewStartTime() -- Line 53
    return module_upvr.getCrewStartTime(module_upvr.getAttackingCrewObj())
end
function module_upvr.setAttackingCrewStartTime(arg1) -- Line 56
    module_upvr.setCrewStartTime(module_upvr.getAttackingCrewObj(), arg1)
end
function module_upvr.getAttackingCrewPenaltyDuration() -- Line 59
    return module_upvr.getCrewPenaltyDuration(module_upvr.getAttackingCrewObj())
end
function module_upvr.setAttackingCrewPenaltyDuration(arg1) -- Line 62
    module_upvr.setCrewPenaltyDuration(module_upvr.getAttackingCrewObj(), arg1)
end
function module_upvr.getAttackingCrewEffectiveDurationElapsed() -- Line 65
    return module_upvr.getCrewEffectiveDurationElapsed(module_upvr.getAttackingCrewObj())
end
function module_upvr.getAllCrewBattleDataObj() -- Line 68
    return ReplicatedStorage_upvr:FindFirstChild(PersistentCrewBattleConsts_upvr.ALL_CREW_BATTLE_DATA_OBJ_NAME)
end
function module_upvr.getAttackingClanId() -- Line 71
    return module_upvr.getAllCrewBattleDataObj():GetAttribute(PersistentCrewBattleConsts_upvr.ATTACKING_CLAN_ID)
end
function module_upvr.getAttackingClanIdChangedSignal() -- Line 75
    return module_upvr.getAllCrewBattleDataObj():GetAttributeChangedSignal(PersistentCrewBattleConsts_upvr.ATTACKING_CLAN_ID)
end
function module_upvr.setAttackingClanId(arg1) -- Line 79
    module_upvr.getAllCrewBattleDataObj():SetAttribute(PersistentCrewBattleConsts_upvr.ATTACKING_CLAN_ID, arg1)
end
function module_upvr.getCrewObjFromClanId(arg1) -- Line 83
    if arg1 == nil then
    else
    end
    assert(true, "clanId cannot be nil")
    return module_upvr.getAllCrewBattleDataObj():FindFirstChild(arg1)
end
function module_upvr.getAttackingCrewObj() -- Line 87
    return module_upvr.getCrewObjFromClanId(module_upvr.getAttackingClanId())
end
function module_upvr.getClanBattleInfoFromClanData(arg1, arg2) -- Line 90
    if not arg1 then
        return nil
    end
    if arg2 then
        return arg1.AllTimeClanBattleInfo
    end
    if arg1.SeasonClanBattleInfo then
    end
    return arg1.SeasonClanBattleInfo[tostring(PersistentCrewBattleConsts_upvr.CURR_CREW_BATTLE_SEASON)]
end
function module_upvr.validateClanRatingData(arg1) -- Line 107
    local pcall_result1, pcall_result2 = pcall(function() -- Line 108
        if not arg1 then
        else
            local var5
            if arg1 then
                var5 = false
                if typeof(arg1.Rating) == "number" then
                    if 0 >= arg1.Rating then
                        var5 = false
                    else
                        var5 = true
                    end
                end
                assert(var5, "Invalid Rating")
                if typeof(arg1.RatingDeviation) == "number" then
                    if 0 >= arg1.RatingDeviation then
                    else
                    end
                end
                assert(true, "Invalid RatingDeviation")
                if typeof(arg1.Sigma) == "number" then
                    if 0 >= arg1.Sigma then
                    else
                    end
                end
                assert(true, "Invalid Sigma")
                if typeof(arg1.LastBattle) == "number" then
                    if 0 >= arg1.LastBattle then
                    else
                    end
                end
                assert(true, "Invalid LastBattle")
            end
        end
    end)
    if not pcall_result1 then
        warn(pcall_result2)
    end
    return pcall_result1
end
function module_upvr.getDefaultRatingData() -- Line 128
    local module = {
        Rating = PersistentCrewBattleConsts_upvr.DEFAULT_RATING;
        RatingDeviation = PersistentCrewBattleConsts_upvr.DEFAULT_RATING_DEVIATION;
        Sigma = PersistentCrewBattleConsts_upvr.DEFAULT_SIGMA_GRINDSET;
        LastBattle = workspace:GetServerTimeNow();
    }
    module_upvr.validateClanRatingData(module)
    return module
end
function module_upvr.getDisplayRatingFromClanBattleInfo(arg1) -- Line 138
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if arg1 then
    end
    if not arg1.RatingData then
    end
    local tostring_result1 = tostring(math.floor(module_upvr.getDefaultRatingData().Rating))
    if not arg1 or not arg1.BattlesPlayed or arg1.BattlesPlayed < PersistentCrewBattleConsts_upvr.NUM_PROVISIONAL_RATING_BATTLES then
        tostring_result1 = tostring_result1..'?'
    end
    return tostring_result1
end
function module_upvr.calculateWLRatio(arg1, arg2) -- Line 155
    if not arg1 or not arg2 then
        return nil
    end
    if 0 < arg2 then
        if arg2 - arg1 == 0 then
            return "∞"
        end
        return string.format("%.2f", arg1 / (arg2 - arg1))
    end
    return nil
end
return module_upvr