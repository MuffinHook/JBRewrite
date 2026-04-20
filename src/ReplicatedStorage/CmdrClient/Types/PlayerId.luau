local Util_upvr = require(script.Parent.Parent.Shared.Util)
local Players_upvr = game:GetService("Players")
local tbl_upvr = {}
local function _(arg1) -- Line 5, Named "getUserId"
    if tbl_upvr[arg1] then
        return tbl_upvr[arg1]
    end
    if Players_upvr:FindFirstChild(arg1) then
        tbl_upvr[arg1] = Players_upvr[arg1].UserId
        return Players_upvr[arg1].UserId
    end
    local pcall_result1, pcall_result2 = pcall(Players_upvr.GetUserIdFromNameAsync, Players_upvr, arg1)
    if not pcall_result1 then
        return nil
    end
    tbl_upvr[arg1] = pcall_result2
    return pcall_result2
end
local tbl_upvr_2 = {
    DisplayName = "Full Player Name";
    Prefixes = "# positiveInteger";
    Transform = function(arg1) -- Line 27, Named "Transform"
        return arg1, Util_upvr.MakeFuzzyFinder(Players_upvr:GetPlayers())(arg1)
    end;
    ValidateOnce = function(arg1) -- Line 33, Named "ValidateOnce"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if tbl_upvr[arg1] then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if Players_upvr:FindFirstChild(arg1) then
            tbl_upvr[arg1] = Players_upvr[arg1].UserId
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    Autocomplete = function(arg1, arg2) -- Line 37, Named "Autocomplete"
        return Util_upvr.GetNames(arg2)
    end;
    Parse = function(arg1) -- Line 41, Named "Parse"
        if tbl_upvr[arg1] then
            return tbl_upvr[arg1]
        end
        if Players_upvr:FindFirstChild(arg1) then
            tbl_upvr[arg1] = Players_upvr[arg1].UserId
            return Players_upvr[arg1].UserId
        end
        local pcall_result1_2, pcall_result2_2 = pcall(Players_upvr.GetUserIdFromNameAsync, Players_upvr, arg1)
        if not pcall_result1_2 then
            return nil
        end
        tbl_upvr[arg1] = pcall_result2_2
        return pcall_result2_2
    end;
    Default = function(arg1) -- Line 45, Named "Default"
        return arg1.Name
    end;
    ArgumentOperatorAliases = {
        me = '.';
        all = '*';
        others = "**";
        random = '?';
    };
}
return function(arg1) -- Line 57
    arg1:RegisterType("playerId", tbl_upvr_2)
    arg1:RegisterType("playerIds", Util_upvr.MakeListableType(tbl_upvr_2, {
        Prefixes = "# positiveIntegers";
    }))
end