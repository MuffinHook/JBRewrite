local new_upvr = Ray.new
local FindPartOnRayWithIgnoreList_upvr = workspace.FindPartOnRayWithIgnoreList
local FindPartOnRay_upvr = workspace.FindPartOnRay
local function RayIgnoreNonCollideSpecial_upvr(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 5, Named "RayIgnoreNonCollideSpecial"
    if arg6 then
        assert(not arg8)
    end
    if arg5 then
        if type(arg5) == "table" then
        else
            local _ = {table.clone(arg5)}
        end
    else
    end
    while true do
        local var6
        if 0.01 >= arg3 then break end
        if 5 <= 0 then
            return nil, var6, -arg2, nil
        end
        if true then
            local FindPartOnRayWithIgnoreList_upvr_result1, FindPartOnRayWithIgnoreList_upvr_result2, FindPartOnRayWithIgnoreList_upvr_result3, _ = FindPartOnRayWithIgnoreList_upvr(workspace, new_upvr(arg1, arg2 * arg3), {}, false, not arg7)
            local _ = FindPartOnRayWithIgnoreList_upvr_result1
            var6 = FindPartOnRayWithIgnoreList_upvr_result2
            local var12 = var6
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            local var3_result1, FindPartOnRay_upvr_result2, var3_result3, var3_result4 = FindPartOnRay_upvr(workspace, new_upvr(arg1, arg2 * arg3), {}, false, not arg7)
            var12 = FindPartOnRay_upvr_result2
        end
        if var3_result1 then
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                return var3_result1.CanCollide
            end
            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                return arg8(var3_result1)
            end
            if arg6 or not arg8 and decompInlinedCondition() or arg8 and decompInlinedCondition_2() then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                return var3_result1, var12, var3_result3, var3_result4
            end
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            table.insert({}, var3_result1)
        else
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return var3_result1, var12, var3_result3, var3_result4
end
return {
    RayIgnoreNonCollide = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 82, Named "RayIgnoreNonCollide"
        return RayIgnoreNonCollideSpecial_upvr(arg1, arg2, arg3, false, arg4, arg5, arg6, arg7)
    end;
    RayIgnoreNonCollideWithIgnoreList = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 62, Named "RayIgnoreNonCollideWithIgnoreList"
        return RayIgnoreNonCollideSpecial_upvr(arg1, arg2, arg3, true, arg4, arg5, arg6, arg7)
    end;
}