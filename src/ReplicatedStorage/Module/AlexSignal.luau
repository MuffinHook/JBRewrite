local module_2 = {}
local tbl_upvr = {}
local random_upvr = math.random
local function _() -- Line 8, Named "GUID"
    return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx":gsub("[xy]", function(arg1) -- Line 10
        if arg1 ~= 'x' or not random_upvr(0, 15) then
        end
        return "%x":format(random_upvr(8, 11))
    end)
end
local function _() -- Line 15, Named "MakeListener"
    return {
        g = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx":gsub("[xy]", function(arg1) -- Line 10
            if arg1 ~= 'x' or not random_upvr(0, 15) then
            end
            return "%x":format(random_upvr(8, 11))
        end);
        Callback = nil;
        SignalName = nil;
    }
end
function module_2.Broadcast(arg1, ...) -- Line 22
    local args_list_upvr = {...}
    for _, v_upvr in next, tbl_upvr do
        if v_upvr.SignalName == arg1 then
            local pcall_result1, pcall_result2 = pcall(function() -- Line 26
                v_upvr:Callback(unpack(args_list_upvr))
            end)
            if not pcall_result1 then
                warn("SIGNAL ERROR: ", pcall_result2)
            end
        end
    end
end
function module_2.Listen(arg1, arg2) -- Line 35
    local module = {
        g = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx":gsub("[xy]", function(arg1_2) -- Line 10
            if arg1_2 ~= 'x' or not random_upvr(0, 15) then
            end
            return "%x":format(random_upvr(8, 11))
        end);
        Callback = nil;
        SignalName = nil;
    }
    module.SignalName = arg1
    module.Callback = arg2
    table.insert(tbl_upvr, module)
    return module
end
function module_2.Close(arg1) -- Line 42
    for i_2, v_2 in next, tbl_upvr do
        if v_2.g == arg1.g then
            return table.remove(tbl_upvr, i_2)
        end
    end
    return false
end
function module_2.Closeg(arg1) -- Line 51
    for i_3, v_3 in next, tbl_upvr do
        if v_3.g == arg1 then
            return table.remove(tbl_upvr, i_3)
        end
    end
    return false
end
function module_2.Closef(arg1) -- Line 59
    for i_4, v_4 in next, tbl_upvr do
        if v_4.Callback == arg1 then
            return table.remove(tbl_upvr, i_4)
        end
    end
    return false
end
return module_2