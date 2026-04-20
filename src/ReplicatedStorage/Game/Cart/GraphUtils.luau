local module_upvr = {
    calculateDist = function(arg1, arg2) -- Line 5, Named "calculateDist"
        local const_number = 1
        local var3
        repeat
            local var4 = arg1[const_number]
            local speedStart_2 = var4.speedStart
            if not speedStart_2 then
                speedStart_2 = var4.speed
            end
            local speedEnd_2 = var4.speedEnd
            if not speedEnd_2 then
                speedEnd_2 = var4.speed
            end
            local const_number_3 = 0
            local timeUntil_2 = var4.timeUntil
            local var9 = math.min(timeUntil_2, arg2) - const_number_3
            var3 += (speedEnd_2 - speedStart_2) / (2 * (timeUntil_2 - const_number_3)) * var9 * var9 + speedStart_2 * var9
        until #arg1 < const_number + 1 and arg2 < var4.timeUntil
        return var3
    end;
    calculateSpeed = function(arg1, arg2) -- Line 23, Named "calculateSpeed"
        for i = 1, #arg1 do
            local var12 = arg1[i]
            local const_number_2 = 0
            local timeUntil = var12.timeUntil
            if arg2 <= timeUntil then
                local speedStart = var12.speedStart
                if not speedStart then
                    speedStart = var12.speed
                end
                local speedEnd = var12.speedEnd
                if not speedEnd then
                    speedEnd = var12.speed
                end
                return (speedEnd - speedStart) / (timeUntil - const_number_2) * (math.min(timeUntil, arg2) - const_number_2) + speedStart
            end
        end
    end;
}
function module_upvr.calculateTime(arg1, arg2) -- Line 38
    local f
    if 0 >= #arg1 then
        f = false
    else
        f = true
    end
    assert(f)
    f = arg1
    if module_upvr.calculateDist(f, arg1[#arg1].timeUntil) < arg2 then return end
    local var18_upvw = 0
    function f(arg1_2, arg2_2) -- Line 46
        local var19 = (arg1_2 + arg2_2) * 0.5
        local var20 = module_upvr.calculateDist(arg1, var19) - arg2
        if math.abs(var20) < 0.000001 then
            return var19
        end
        if math.abs(var20 - var18_upvw) < 0.000001 then return end
        var18_upvw = var20
        if 0 < var20 then
            return f(arg1_2, var19)
        end
        return f(var19, arg2_2)
    end
    return f(0, arg1[#arg1].timeUntil)
end
function module_upvr.constrainLastTimeToReachTarget(arg1, arg2) -- Line 67
    local var25
    if 1 < #arg1 then
        var25 = arg1[#arg1 - 1]
        var25 = var25.timeUntil
        if arg2 < module_upvr.calculateDist(arg1, var25) then
            return nil
        end
    end
    local var26_upvw = 0
    local function f_upvr(arg1_4, arg2_4) -- Line 76, Named "f"
        local var27 = (arg1_4 + arg2_4) * 0.5
        arg1[#arg1].timeUntil = var27
        local var28 = module_upvr.calculateDist(arg1, var27) - arg2
        if math.abs(var28) < 0.000001 then
            return var27
        end
        if math.abs(var28 - var26_upvw) < 0.000001 then return end
        var26_upvw = var28
        if 0 < var28 then
            return f_upvr(arg1_4, var27)
        end
        return f_upvr(var27, arg2_4)
    end
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var25 = var25.timeUntil
        var25 = arg1[#arg1 - 1]
        return var25
    end
    if 1 >= #arg1 or not decompInlinedCondition_2() then
        var25 = 0
    end
    return f_upvr(var25, 10000000000)
end
function module_upvr.cap(arg1) -- Line 98
    table.insert(arg1, {
        timeUntil = 10000000000;
        speedStart = 0;
        speedEnd = 0;
    })
end
return module_upvr