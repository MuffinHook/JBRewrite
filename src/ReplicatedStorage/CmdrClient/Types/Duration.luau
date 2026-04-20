local Util_upvr = require(script.Parent.Parent.Shared.Util)
local tbl_upvr = {
    Years = 31556926;
    Months = 2629744;
    Weeks = 604800;
    Days = 86400;
    Hours = 3600;
    Minutes = 60;
    Seconds = 1;
}
local tbl = {}
for i, _ in pairs(tbl_upvr) do
    table.insert(tbl, i)
end
local any_MakeFuzzyFinder_result1_upvr = Util_upvr.MakeFuzzyFinder(tbl)
local function stringToSecondDuration_upvr(arg1) -- Line 19, Named "stringToSecondDuration"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if arg1 == nil or arg1 == "" then
        return nil
    end
    local tonumber_result1 = tonumber(arg1)
    local var17
    if tonumber_result1 and tonumber_result1 == 0 then
        var17 = true
        return 0, 0, var17
    end
    var17 = "-?%d+%a+"
    local any_match_result1 = arg1:gsub(var17, ""):match("-?%d+")
    if any_match_result1 then
        var17 = nil
        return var17, tonumber(any_match_result1), true
    end
    var17 = nil
    for i_2 in arg1:gmatch("-?%d+%a+") do
        local any_match_result1_2, any_match_result2 = i_2:match("(-?%d+)(%a+)")
        local var24 = any_match_result2
        local var11_result1 = any_MakeFuzzyFinder_result1_upvr(var24, false, true)
        local var26
        if #var11_result1 == 0 then
            var26 = tonumber(any_match_result1_2)
            return nil, var26
        end
        if var17 == nil then
            var17 = 0
        end
        if var24:lower() == 'm' then
            var26 = 60
        else
            var26 = tbl_upvr[var11_result1[1]]
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var17 += var26 * tonumber(any_match_result1_2)
    end
    if var17 == nil then
        return nil
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return var17, tonumber(any_match_result1_2)
end
local function mapUnits_upvr(arg1, arg2, arg3, arg4) -- Line 60, Named "mapUnits"
    for i_3, v_2 in pairs(arg1) do
        if arg3 == 1 then
            ({})[i_3] = arg2..v_2:sub(arg4 or 1, #v_2 - 1)
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            ;({})[i_3] = arg2..v_2:sub(arg4 or 1)
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return {}
end
local tbl_2_upvr = {
    Transform = function(arg1) -- Line 74, Named "Transform"
        return arg1, stringToSecondDuration_upvr(arg1)
    end;
    Validate = function(arg1, arg2) -- Line 78, Named "Validate"
        if arg2 == nil then
        else
        end
        return true
    end;
    Autocomplete = function(arg1, arg2, arg3, arg4, arg5) -- Line 82, Named "Autocomplete"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var33
        if arg4 or arg5 then
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var33 = any_MakeFuzzyFinder_result1_upvr("", false, true)
                return var33
            end
            if arg4 ~= true or not decompInlinedCondition() then
                var33 = arg5
            end
            if arg4 == true then
                return mapUnits_upvr(var33, arg1, arg3)
            end
            return mapUnits_upvr(var33, arg1, arg1:match("^.*(%a+)$"):len() + 1)
        end
        if arg2 ~= nil then
            var33 = arg1:match("^.*-?%d+(%a+)%s?$")
            local mapUnits_upvr_result1 = mapUnits_upvr(any_MakeFuzzyFinder_result1_upvr(var33, false, true), arg1, arg3, #var33 + 1)
            table.sort(mapUnits_upvr_result1)
        end
        return mapUnits_upvr_result1
    end;
    Parse = function(arg1, arg2) -- Line 106, Named "Parse"
        return arg2
    end;
}
return function(arg1) -- Line 111
    arg1:RegisterType("duration", tbl_2_upvr)
    arg1:RegisterType("durations", Util_upvr.MakeListableType(tbl_2_upvr))
end