local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new() -- Line 9
    local module = {}
    setmetatable(module, module_upvr)
    module.Maid = Maid_upvr.new()
    module.OnMessage = Signal_upvr.new()
    module.ListEventUnconnected = {}
    module.MapEventSignal = {}
    module.Speed = 1
    return module
end
local Timeline_upvr = require(ReplicatedStorage.Module.Timeline)
local RunService_upvr = game:GetService("RunService")
function module_upvr.Run(arg1) -- Line 23
    if not arg1.BornAt then
        arg1.BornAt = workspace:GetServerTimeNow()
    end
    local var9_upvw = 0
    local any_new_result1_upvw = Timeline_upvr.new(arg1.Seqs)
    arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 30
        local workspace_GetServerTimeNow_result1 = workspace:GetServerTimeNow()
        if 0.5 < workspace_GetServerTimeNow_result1 - var9_upvw then
            var9_upvw = workspace_GetServerTimeNow_result1
            if any_new_result1_upvw:Update(arg1.Speed * (workspace_GetServerTimeNow_result1 - arg1.BornAt)) then
                any_new_result1_upvw = nil
                arg1:Destroy()
            end
        end
    end))
end
function module_upvr.SetBornAt(arg1, arg2) -- Line 43
    arg1.BornAt = arg2
end
function module_upvr.SetSpeed(arg1, arg2) -- Line 46
    arg1.Speed = arg2
end
function module_upvr.LoadData(arg1, arg2) -- Line 49
    local var21
    if arg1.Data ~= nil then
        var21 = false
    else
        var21 = true
    end
    assert(var21)
    arg1.Data = arg2
    local tbl = {}
    var21 = ipairs(arg2)
    for _, v_upvr in ipairs(arg2) do
        local var26
        if v_upvr.Duration == nil then
            var26 = false
        else
            var26 = true
        end
        assert(var26)
        var26 = {}
        var26[1] = function(arg1_2) -- Line 55, Named "Callback"
            if arg1_2 == 0 then
                arg1.OnMessage:Fire(v_upvr)
                if v_upvr.Events ~= nil then
                    for _, v_2 in ipairs(v_upvr.Events) do
                        if arg1.MapEventSignal[v_2] == nil then
                            error(string.format("Missing signal for event: %s", v_2))
                        end
                        arg1.MapEventSignal[v_2]:Fire(v_upvr)
                    end
                end
            end
        end
        var26[2] = v_upvr.Duration
        table.insert(tbl, var26)
        if v_upvr.Events ~= nil then
            for _, v_3 in ipairs(v_upvr.Events) do
                if arg1.MapEventSignal[v_3] ~= nil then
                    error(string.format("There already exists an event named: %s", v_3))
                end
                local any_new_result1 = Signal_upvr.new()
                arg1.MapEventSignal[v_3] = any_new_result1
                arg1.Maid:GiveTask(any_new_result1)
                table.insert(arg1.ListEventUnconnected, v_3)
            end
        end
    end
    arg1.Seqs = tbl
end
function module_upvr.Connect(arg1, arg2, arg3) -- Line 87
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _ = #arg1.ListEventUnconnected
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [18.1157629005]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.VerifyAllConnected(arg1) -- Line 99
    if 0 < #arg1.ListEventUnconnected then
        error(string.format("Not all events are unconnected... remaining: %s", table.concat(arg1.ListEventUnconnected, ", ")))
    end
end
function module_upvr.Destroy(arg1) -- Line 104
    arg1.MapEventSignal = nil
    arg1.Maid:Destroy()
    arg1.Maid = nil
    setmetatable(arg1, nil)
end
return module_upvr