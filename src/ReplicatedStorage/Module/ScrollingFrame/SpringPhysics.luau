local module_upvr = {
    Spring = {};
    NumberSpring = {};
    VectorSpring = {};
}
local tick_upvr = tick
local cos_upvr = math.cos
local sin_upvr = math.sin
local function New(arg1) -- Line 12
    local tick_upvr_result1_upvw = tick_upvr()
    local var6_upvw = arg1 or 0
    local var7_upvw = arg1 or 0
    local var8_upvw
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var8_upvw = 0 * arg1
        return var8_upvw
    end
    if not arg1 or not decompInlinedCondition() then
        var8_upvw = 0
    end
    local var9_upvw = 1
    local var10_upvw = 1
    local function PositionVelocity_upvr(arg1_2) -- Line 22, Named "PositionVelocity"
        local var11 = arg1_2 - tick_upvr_result1_upvw
        local var12 = var7_upvw - var6_upvw
        if var10_upvw == 0 then
            return var7_upvw, 0
        end
        if var9_upvw < 1 then
            local var13 = (1 - var9_upvw * var9_upvw) ^ 0.5
            local var14 = (var8_upvw / var10_upvw + var9_upvw * var12) / var13
            local cos_upvr_result1 = cos_upvr(var13 * var10_upvw * var11)
            local sin_upvr_result1 = sin_upvr(var13 * var10_upvw * var11)
            local var17 = 2.718281828459045 ^ (var9_upvw * var10_upvw * var11)
            return var6_upvw + (var12 * cos_upvr_result1 + var14 * sin_upvr_result1) / var17, var10_upvw * ((var13 * var14 - var9_upvw * var12) * cos_upvr_result1 - (var13 * var12 + var9_upvw * var14) * sin_upvr_result1) / var17
        end
        local var18 = var8_upvw / var10_upvw + var12
        local var19 = 2.718281828459045 ^ (var10_upvw * var11)
        return var6_upvw + (var12 + var18 * var10_upvw * var11) / var19, var10_upvw * (var18 - var12 - var18 * var10_upvw * var11) / var19
    end
    local tbl = {}
    local var21_upvw
    function tbl.Impulse(arg1_3, arg2) -- Line 42
        var21_upvw.Velocity += arg2
    end
    function tbl.TimeSkip(arg1_4, arg2) -- Line 45
        local var2_result1 = tick_upvr()
        local PositionVelocity_result1_2, PositionVelocity_result2_4 = PositionVelocity_upvr(var2_result1 + arg2)
        var7_upvw = PositionVelocity_result1_2
        var8_upvw = PositionVelocity_result2_4
        tick_upvr_result1_upvw = var2_result1
    end
    var21_upvw = setmetatable(tbl, {
        __index = function(arg1_5, arg2) -- Line 53, Named "__index"
            if arg2 == "Value" or arg2 == "Position" or arg2 == 'p' then
                local PositionVelocity_upvr_result1, _ = PositionVelocity_upvr(tick_upvr())
                return PositionVelocity_upvr_result1
            end
            if arg2 == "Velocity" or arg2 == 'v' then
                local _, PositionVelocity_result2 = PositionVelocity_upvr(tick_upvr())
                return PositionVelocity_result2
            end
            if arg2 == "Target" or arg2 == 't' then
                return var6_upvw
            end
            if arg2 == "Damper" or arg2 == 'd' then
                return var9_upvw
            end
            if arg2 == "Speed" or arg2 == 's' then
                return var10_upvw
            end
            error(arg2.." is not a valid member of Spring")
        end;
        __newindex = function(arg1_6, arg2, arg3) -- Line 70, Named "__newindex"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            if arg2 == "Value" or arg2 == "Position" or arg2 == 'p' then
                local PositionVelocity_upvr_result1_2, PositionVelocity_result2_3 = PositionVelocity_upvr(tick_upvr())
                var7_upvw = arg3
                var8_upvw = PositionVelocity_result2_3
            elseif arg2 == "Velocity" or arg2 == 'v' then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                local PositionVelocity_upvr_result1_3, _ = PositionVelocity_upvr(tick_upvr())
                var7_upvw = PositionVelocity_upvr_result1_3
                var8_upvw = arg3
            elseif arg2 == "Target" or arg2 == 't' then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                local PositionVelocity_result1, PositionVelocity_result2_2 = PositionVelocity_upvr(tick_upvr())
                var7_upvw = PositionVelocity_result1
                var8_upvw = PositionVelocity_result2_2
                var6_upvw = arg3
                local var36
            elseif arg2 == "Damper" or arg2 == 'd' then
                var36 = PositionVelocity_upvr
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                var36 = var36(tick_upvr())
                local var36_result1, var36_result2 = var36(tick_upvr())
                var7_upvw = var36_result1
                var8_upvw = var36_result2
                if arg3 < 0 then
                    var36_result1 = 0
                    local var39 = var36_result1
                else
                    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var39 = arg3
                        return var39
                    end
                    if arg3 >= 1 or not decompInlinedCondition_2() then
                        var39 = 1
                    end
                end
                var9_upvw = var39
                local var40
            elseif arg2 == "Speed" or arg2 == 's' then
                var40 = PositionVelocity_upvr
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                var40 = var40(tick_upvr())
                local var40_result1, var40_result2 = var40(tick_upvr())
                var7_upvw = var40_result1
                var8_upvw = var40_result2
                if arg3 < 0 then
                    var40_result1 = 0
                else
                    var40_result1 = arg3
                end
                var10_upvw = var40_result1
            else
                var40_result1 = error
                var40_result1(arg2.." is not a valid member of Spring")
            end
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            tick_upvr_result1_upvw = tick_upvr()
        end;
    })
    return var21_upvw
end
module_upvr.Spring.New = New
local function New(arg1) -- Line 98
    return module_upvr.Spring.New(arg1)
end
module_upvr.NumberSpring.New = New
local new_upvr = Vector3.new
module_upvr.VectorSpring.New = function(arg1) -- Line 102, Named "New"
    local var44 = arg1
    if not var44 then
        var44 = new_upvr()
    end
    return module_upvr.Spring.New(var44)
end
return module_upvr