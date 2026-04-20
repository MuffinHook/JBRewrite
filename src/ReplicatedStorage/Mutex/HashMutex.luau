local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.new() -- Line 4
    local module = {}
    setmetatable(module, module_2_upvr)
    module._data = {}
    module._observe = {}
    return module
end
function module_2_upvr.AcquireFor(arg1, arg2, arg3) -- Line 13
    if arg1._data[arg2] then
        return false
    end
    arg1._data[arg2] = {
        thread = task.delay(arg3, function() -- Line 18
            arg1._data[arg2] = nil
            arg1:_fireKeyChangedCallbacks(arg2)
        end);
    }
    arg1:_fireKeyChangedCallbacks(arg2)
    return true
end
function module_2_upvr.ReleaseFor(arg1, arg2) -- Line 26
    local var5 = arg1._data[arg2]
    local var6
    if var5 then
        var6 = task.cancel
        var6(var5.thread)
        var6 = arg1._data
        var6[arg2] = nil
        var6 = arg1:_fireKeyChangedCallbacks
        var6(arg2)
    end
    if var5 == nil then
        var6 = false
    else
        var6 = true
    end
    return var6
end
function module_2_upvr._fireKeyChangedCallbacks(arg1, arg2) -- Line 36
    local var11
    if arg1._data[arg2] == nil then
        var11 = false
    else
        var11 = true
    end
    if arg1._observe[arg2] then
        for _, v in arg1._observe[arg2] do
            v(var11)
        end
    end
end
function module_2_upvr.AddKeyChangedCallback(arg1, arg2, arg3) -- Line 44
    if not arg1._observe[arg2] then
        arg1._observe[arg2] = {}
    end
    table.insert(arg1._observe[arg2], arg3)
    return function() -- Line 49
        if not arg1._observe[arg2] then
            return false
        end
        local table_find_result1 = table.find(arg1._observe[arg2], arg3)
        if not table_find_result1 then
            return false
        end
        table.remove(arg1._observe[arg2], table_find_result1)
        if #arg1._observe[arg2] == 0 then
            arg1._observe[arg2] = nil
        end
        return true
    end
end
function module_2_upvr.ObserveKey(arg1, arg2, arg3) -- Line 64
    local var14
    if arg1._data[arg2] == nil then
        var14 = false
    else
        var14 = true
    end
    arg3(var14)
    return arg1:AddKeyChangedCallback(arg2, arg3)
end
function module_2_upvr.Destroy(arg1) -- Line 69
    for i_2 in arg1._data do
        arg1:ReleaseFor(i_2)
    end
    setmetatable(arg1, nil)
end
return module_2_upvr