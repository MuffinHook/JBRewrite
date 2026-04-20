local CollectionService_upvr = game:GetService("CollectionService")
local BossNPCConsts_upvr = require(game:GetService("ReplicatedStorage").MansionRobbery.BossNPCConsts)
local module = {}
local function _(arg1) -- Line 7, Named "validateObj"
    local var4
    if typeof(arg1) ~= "Instance" then
        var4 = false
    else
        var4 = true
    end
    assert(var4, "Invalid obj passed")
    var4 = CollectionService_upvr:HasTag(arg1, BossNPCConsts_upvr.TAG_NAME)
    assert(var4, "Obj does not have tag")
end
function module.setMovementState(arg1, arg2) -- Line 11
    local var5
    if typeof(arg1) ~= "Instance" then
        var5 = false
    else
        var5 = true
    end
    assert(var5, "Invalid obj passed")
    var5 = CollectionService_upvr:HasTag(arg1, BossNPCConsts_upvr.TAG_NAME)
    assert(var5, "Obj does not have tag")
    arg1:SetAttribute(BossNPCConsts_upvr.MOVEMENT_STATE_ATTR_NAME, arg2)
    return true
end
function module.getMovementState(arg1) -- Line 16
    local var6
    if typeof(arg1) ~= "Instance" then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "Invalid obj passed")
    var6 = CollectionService_upvr:HasTag(arg1, BossNPCConsts_upvr.TAG_NAME)
    assert(var6, "Obj does not have tag")
    return arg1:GetAttribute(BossNPCConsts_upvr.MOVEMENT_STATE_ATTR_NAME)
end
function module.getMovementStateChangedSignal(arg1) -- Line 20
    local var7
    if typeof(arg1) ~= "Instance" then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "Invalid obj passed")
    var7 = CollectionService_upvr:HasTag(arg1, BossNPCConsts_upvr.TAG_NAME)
    assert(var7, "Obj does not have tag")
    return arg1:GetAttributeChangedSignal(BossNPCConsts_upvr.MOVEMENT_STATE_ATTR_NAME)
end
function module.setAttackState(arg1, arg2) -- Line 24
    local var8
    if typeof(arg1) ~= "Instance" then
        var8 = false
    else
        var8 = true
    end
    assert(var8, "Invalid obj passed")
    var8 = CollectionService_upvr:HasTag(arg1, BossNPCConsts_upvr.TAG_NAME)
    assert(var8, "Obj does not have tag")
    arg1:SetAttribute(BossNPCConsts_upvr.ATTACK_STATE_ATTR_NAME, arg2)
end
function module.getAttackState(arg1) -- Line 28
    local var9
    if typeof(arg1) ~= "Instance" then
        var9 = false
    else
        var9 = true
    end
    assert(var9, "Invalid obj passed")
    var9 = CollectionService_upvr:HasTag(arg1, BossNPCConsts_upvr.TAG_NAME)
    assert(var9, "Obj does not have tag")
    return arg1:GetAttribute(BossNPCConsts_upvr.ATTACK_STATE_ATTR_NAME)
end
function module.getAttackStateChangedSignal(arg1) -- Line 32
    local var10
    if typeof(arg1) ~= "Instance" then
        var10 = false
    else
        var10 = true
    end
    assert(var10, "Invalid obj passed")
    var10 = CollectionService_upvr:HasTag(arg1, BossNPCConsts_upvr.TAG_NAME)
    assert(var10, "Obj does not have tag")
    return arg1:GetAttributeChangedSignal(BossNPCConsts_upvr.ATTACK_STATE_ATTR_NAME)
end
return module