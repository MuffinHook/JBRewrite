local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new(arg1) -- Line 11
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    return any_new_result1
end
local NetObjPoolItemBinder_upvr = require(ReplicatedStorage.NetObjPool.NetObjPoolItemBinder)
function module_upvr.Get(arg1) -- Line 17
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local any_GetAll_result1, any_GetAll_result2, any_GetAll_result3 = NetObjPoolItemBinder_upvr:GetAll()
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [20.7]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return require(ReplicatedStorage.Std.Binder).new("NetObjPool", module_upvr)