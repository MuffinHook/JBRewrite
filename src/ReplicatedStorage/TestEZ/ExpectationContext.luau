local Expectation_upvr = require(script.Parent.Expectation)
local function _(arg1) -- Line 4, Named "copy"
    local module = {}
    for i, v in pairs(arg1) do
        module[i] = v
    end
    return module
end
local module_3_upvr = {}
module_3_upvr.__index = module_3_upvr
function module_3_upvr.new(arg1) -- Line 17
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local module_2 = {}
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    for i_2, v_2 in pairs(arg1._extensions) do
        ({})[i_2] = v_2
        local var20
    end
    local var21 = var20
    if not var21 then
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var21 = {}
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    module_2._extensions = var21
    do
        return setmetatable(module_2, module_3_upvr)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_3_upvr.startExpectationChain(arg1, ...) -- Line 25
    return Expectation_upvr.new(...):extend(arg1._extensions)
end
local checkMatcherNameCollisions_upvr = Expectation_upvr.checkMatcherNameCollisions
function module_3_upvr.extend(arg1, arg2) -- Line 29
    for i_3, v_3 in pairs(arg2) do
        local var30
        if arg1._extensions[i_3] ~= nil then
            var30 = false
        else
            var30 = true
        end
        assert(var30, string.format("Cannot reassign %q in expect.extend", i_3))
        var30 = checkMatcherNameCollisions_upvr(i_3)
        assert(var30, string.format("Cannot overwrite matcher %q; it already exists", i_3))
        arg1._extensions[i_3] = v_3
    end
end
return module_3_upvr