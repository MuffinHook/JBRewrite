local module_upvr = {}
local tbl_upvr_2 = {
    to = true;
    be = true;
    been = true;
    have = true;
    was = true;
    at = true;
}
local tbl_upvr = {
    never = true;
}
local function _(arg1, arg2, arg3) -- Line 42, Named "assertLevel"
    if not arg1 then
        error(arg2 or "Assertion failed!", (arg3 or 1) + 1)
    end
end
local function _(arg1, arg2) -- Line 54, Named "bindSelf"
    return function(arg1_2, ...) -- Line 55
        if arg1_2 == arg1 then
            return arg2(arg1, ...)
        end
        return arg2(arg1, arg1_2, ...)
    end
end
local function _(arg1, arg2, arg3) -- Line 64, Named "formatMessage"
    if arg1 then
        return arg2
    end
    return arg3
end
function module_upvr.new(arg1) -- Line 75
    local module_upvr_2 = {}
    module_upvr_2.value = arg1
    module_upvr_2.successCondition = true
    module_upvr_2.condition = false
    module_upvr_2.matchers = {}
    module_upvr_2._boundMatchers = {}
    setmetatable(module_upvr_2, module_upvr)
    local a_2_upvr = module_upvr_2.a
    function module_upvr_2.a(arg1_3, ...) -- Line 55
        if arg1_3 == module_upvr_2 then
            return a_2_upvr(module_upvr_2, ...)
        end
        return a_2_upvr(module_upvr_2, arg1_3, ...)
    end
    module_upvr_2.an = module_upvr_2.a
    a_2_upvr = module_upvr_2.ok
    function module_upvr_2.ok(arg1_4, ...) -- Line 55
        if arg1_4 == module_upvr_2 then
            return a_2_upvr(module_upvr_2, ...)
        end
        return a_2_upvr(module_upvr_2, arg1_4, ...)
    end
    a_2_upvr = module_upvr_2.equal
    function module_upvr_2.equal(arg1_5, ...) -- Line 55
        if arg1_5 == module_upvr_2 then
            return a_2_upvr(module_upvr_2, ...)
        end
        return a_2_upvr(module_upvr_2, arg1_5, ...)
    end
    a_2_upvr = module_upvr_2.throw
    function module_upvr_2.throw(arg1_6, ...) -- Line 55
        if arg1_6 == module_upvr_2 then
            return a_2_upvr(module_upvr_2, ...)
        end
        return a_2_upvr(module_upvr_2, arg1_6, ...)
    end
    a_2_upvr = module_upvr_2.near
    function module_upvr_2.near(arg1_7, ...) -- Line 55
        if arg1_7 == module_upvr_2 then
            return a_2_upvr(module_upvr_2, ...)
        end
        return a_2_upvr(module_upvr_2, arg1_7, ...)
    end
    return module_upvr_2
end
function module_upvr.checkMatcherNameCollisions(arg1) -- Line 96
    if tbl_upvr_2[arg1] or tbl_upvr[arg1] or module_upvr[arg1] then
        return false
    end
    return true
end
function module_upvr.extend(arg1, arg2) -- Line 104
    local var16 = arg2
    if not var16 then
        var16 = {}
    end
    arg1.matchers = var16
    local pairs_result1, pairs_result2, pairs_result3 = pairs(arg1.matchers)
    for i, v_upvr in pairs_result1, pairs_result2, pairs_result3 do
        local function var20_upvr(arg1_8, ...) -- Line 108
            local value = arg1.value
            local v_upvr_result1 = v_upvr(value, ...)
            if v_upvr_result1.pass ~= arg1.successCondition then
                value = false
            else
                value = true
            end
            if not value then
                error(v_upvr_result1.message or "Assertion failed!", (3 or 1) + 1)
            end
            arg1:_resetModifiers()
            return arg1
        end
        arg1._boundMatchers[i] = function(arg1_9, ...) -- Line 55
            if arg1_9 == arg1 then
                return var20_upvr(arg1, ...)
            end
            return var20_upvr(arg1, arg1_9, ...)
        end
    end
    return arg1
end
function module_upvr.__index(arg1, arg2) -- Line 121
    if tbl_upvr_2[arg2] then
        return arg1
    end
    if tbl_upvr[arg2] then
        local any_extend_result1 = module_upvr.new(arg1.value):extend(arg1.matchers)
        any_extend_result1.successCondition = not arg1.successCondition
        return any_extend_result1
    end
    if arg1._boundMatchers[arg2] then
        return arg1._boundMatchers[arg2]
    end
    return module_upvr[arg2]
end
function module_upvr._resetModifiers(arg1) -- Line 154
    arg1.successCondition = true
end
function module_upvr.a(arg1, arg2) -- Line 163
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var25
    if type(arg1.value) ~= arg2 then
        var25 = false
    else
        var25 = true
    end
    if var25 ~= arg1.successCondition then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.successCondition then
        var25 = "Expected value of type %q, got value %q of type %s":format(arg2, tostring(arg1.value), type(arg1.value))
    else
        var25 = "Expected value not of type %q, got value %q of type %s":format(arg2, tostring(arg1.value), type(arg1.value))
    end
    if not true then
        error(var25 or "Assertion failed!", (3 or 1) + 1)
    end
    arg1:_resetModifiers()
    do
        return arg1
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
module_upvr.an = module_upvr.a
function module_upvr.ok(arg1) -- Line 191
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var26
    if arg1.value == nil then
        var26 = false
    else
        var26 = true
    end
    if var26 ~= arg1.successCondition then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.successCondition then
        var26 = "Expected value %q to be non-nil":format(tostring(arg1.value))
    else
        var26 = "Expected value %q to be nil":format(tostring(arg1.value))
    end
    if not true then
        error(var26 or "Assertion failed!", (3 or 1) + 1)
    end
    arg1:_resetModifiers()
    do
        return arg1
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.equal(arg1, arg2) -- Line 212
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var27
    if arg1.value ~= arg2 then
        var27 = false
    else
        var27 = true
    end
    if var27 ~= arg1.successCondition then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.successCondition then
        var27 = "Expected value %q (%s), got %q (%s) instead":format(tostring(arg2), type(arg2), tostring(arg1.value), type(arg1.value))
    else
        var27 = "Expected anything but value %q (%s)":format(tostring(arg2), type(arg2))
    end
    if not true then
        error(var27 or "Assertion failed!", (3 or 1) + 1)
    end
    arg1:_resetModifiers()
    do
        return arg1
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.near(arg1, arg2, arg3) -- Line 238
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var28
    if type(arg1.value) ~= "number" then
        var28 = false
    else
        var28 = true
    end
    assert(var28, "Expectation value must be a number to use 'near'")
    if type(arg2) ~= "number" then
        var28 = false
    else
        var28 = true
    end
    assert(var28, "otherValue must be a number")
    var28 = true
    if type(arg3) ~= "number" then
        if arg3 ~= nil then
            var28 = false
        else
            var28 = true
        end
    end
    assert(var28, "limit must be a number or nil")
    if math.abs(arg1.value - arg2) > (arg3 or 1e-07) then
        var28 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var28 = true
    if var28 ~= arg1.successCondition then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.throw(arg1, arg2) -- Line 271
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local pcall_result1, pcall_result2 = pcall(arg1.value)
    local var31
    if pcall_result1 == arg1.successCondition then
        var31 = false
    else
        var31 = true
    end
    if arg2 and not pcall_result1 then
        if arg1.successCondition then
            if pcall_result2:find(arg2, 1, true) == nil then
                var31 = false
            else
                var31 = true
            end
        elseif pcall_result2:find(arg2, 1, true) ~= nil then
            var31 = false
        else
            var31 = true
        end
    end
    local var32
    if arg2 then
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var32 = "threw: %s":format(pcall_result2)
            return var32
        end
        if not pcall_result2 or not decompInlinedCondition() then
            var32 = "did not throw."
        end
        var32 = arg2
        if arg1.successCondition then
        else
        end
    else
        var32 = pcall_result2
        if arg1.successCondition then
        else
        end
    end
    if not var31 then
        var32 = "Expected function to succeed, but it threw an error: %s":format(tostring(var32)) or "Assertion failed!"
        error(var32, (3 or 1) + 1)
    end
    arg1:_resetModifiers()
    return arg1
end
return module_upvr