local Signal = require(game:GetService("ReplicatedStorage").Std.Signal)
local var2_upvw
local function _(arg1) -- Line 6, Named "GetById"
    for i = #var2_upvw, 1, -1 do
        if var2_upvw[i].Id == arg1 then
            return i
        end
    end
    return false
end
local tbl_upvr = {
    InstAddedSignal = Signal.new();
    InstRemovedSignal = Signal.new();
    AddedSignal = Signal.new();
    RemovedSignal = Signal.new();
    UpdatedSignal = Signal.new();
}
local CollectionService_upvr = game:GetService("CollectionService")
local function NetSyncReplicateSingle_upvr(arg1) -- Line 22, Named "NetSyncReplicateSingle"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _ = #var2_upvw
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [16.681]
    if var2_upvw == arg1.Id then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function NetSyncReplicateDestroy_upvr(arg1) -- Line 61, Named "NetSyncReplicateDestroy"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(var2_upvw)
    local _ = #var2_upvw
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [18.681]
    if var2_upvw == arg1 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function NetSyncReplicateAll_upvr(arg1) -- Line 68, Named "NetSyncReplicateAll"
    for i_2 = 1, #arg1 do
        NetSyncReplicateSingle_upvr(arg1[i_2])
    end
end
local var9_upvw
local var10_upvw
return {
    Init = function(arg1) -- Line 73, Named "Init"
        var2_upvw = {}
        var9_upvw = arg1.Event
        var10_upvw = arg1.em
        var10_upvw.ws5iquzm = NetSyncReplicateSingle_upvr
        var10_upvw.dm6gsgne = NetSyncReplicateDestroy_upvr
        var10_upvw.k8h1arct = NetSyncReplicateAll_upvr
    end;
    Signals = tbl_upvr;
}