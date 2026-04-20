local ContractConsts_upvr = require(script.Parent.ContractConsts)
local CollectionService_upvr = game:GetService("CollectionService")
local module_2_upvr = {}
local function _(arg1) -- Line 5, Named "validateObj"
    local var4
    if typeof(arg1) ~= "Instance" then
        var4 = false
    else
        var4 = true
    end
    assert(var4, "Invalid obj passed")
    var4 = CollectionService_upvr:HasTag(arg1, "Contract")
    assert(var4)
end
function module_2_upvr.canReroll(arg1, arg2) -- Line 9
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var5
    if typeof(arg1) ~= "Instance" then
        var5 = false
    else
        var5 = true
    end
    assert(var5, "Invalid obj passed")
    var5 = CollectionService_upvr:HasTag(arg1, "Contract")
    assert(var5)
    if typeof(arg2) ~= "boolean" then
        var5 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var5 = true
    assert(var5, "Incorrect hasVIP passed")
    if arg2 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_2_upvr.getNumTimesRerolled(arg1) -- Line 15
    local var6
    if typeof(arg1) ~= "Instance" then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "Invalid obj passed")
    var6 = CollectionService_upvr:HasTag(arg1, "Contract")
    assert(var6)
    local SOME = arg1:FindFirstChild(ContractConsts_upvr.REROLLED_VALUE_NAME)
    if not SOME then
        var6 = nil
        return var6
    end
    var6 = SOME.Value
    return var6
end
function module_2_upvr.getNumTimesRerolledObject(arg1) -- Line 23
    local var8
    if typeof(arg1) ~= "Instance" then
        var8 = false
    else
        var8 = true
    end
    assert(var8, "Invalid obj passed")
    var8 = CollectionService_upvr:HasTag(arg1, "Contract")
    assert(var8)
    local SOME_2 = arg1:FindFirstChild(ContractConsts_upvr.REROLLED_VALUE_NAME)
    if not SOME_2 then
        var8 = nil
        return var8
    end
    return SOME_2
end
function module_2_upvr.setNumTimesRerolled(arg1, arg2) -- Line 31
    local var10
    if typeof(arg1) ~= "Instance" then
        var10 = false
    else
        var10 = true
    end
    assert(var10, "Invalid obj passed")
    var10 = CollectionService_upvr:HasTag(arg1, "Contract")
    assert(var10)
    if not arg1:FindFirstChild(ContractConsts_upvr.REROLLED_VALUE_NAME) then
        var10 = Instance.new("NumberValue")
        local var11 = var10
        var10 = ContractConsts_upvr
        var10 = var10.REROLLED_VALUE_NAME
        var11.Name = var10
        var11.Parent = arg1
    end
    var11.Value = arg2
    var10 = true
    return var10
end
function module_2_upvr.getQuantizedBlock(arg1, arg2) -- Line 43
    local var12
    if typeof(arg1) ~= "number" then
        var12 = false
    else
        var12 = true
    end
    assert(var12, "Duration must be a number")
    local var13 = arg2 or 0
    if not var13 then return end
    var12 = math.ceil((workspace:GetServerTimeNow() - var13) / arg1) * arg1 + var13
    return var12
end
function module_2_upvr.getNextDeadline() -- Line 53
    local module = {
        year = 2023;
        month = 7;
        day = 31;
        hour = 13;
    }
    return module_2_upvr.getQuantizedBlock(ContractConsts_upvr.REFRESH_DURATION, DateTime.fromUniversalTime(module.year, module.month, module.day, module.hour - -4).UnixTimestamp)
end
return module_2_upvr