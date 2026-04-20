local module_upvr = {
    _data = {};
    _observing = {};
}
function module_upvr.setCachedPlayerPolicyInfo(arg1, arg2) -- Line 9
    module_upvr._data[arg1.UserId] = arg2
    local var5 = module_upvr._observing[arg1.UserId]
    if var5 then
        module_upvr._observing[arg1.UserId] = nil
        for _, v in var5 do
            v(arg2)
        end
    end
end
function module_upvr.getCachedPlayerPolicyInfo(arg1) -- Line 19
    return module_upvr._data[arg1.UserId]
end
local Promise_upvr = require(game:GetService("ReplicatedStorage").Std.Promise)
function module_upvr.promiseCachedPlayerPolicyInfo(arg1) -- Line 22
    local any_getCachedPlayerPolicyInfo_result1 = module_upvr.getCachedPlayerPolicyInfo(arg1)
    if any_getCachedPlayerPolicyInfo_result1 then
        return Promise_upvr.resolve(any_getCachedPlayerPolicyInfo_result1)
    end
    return Promise_upvr.new(function(arg1_2, arg2, arg3) -- Line 27
        local UserId_upvr = arg1.UserId
        if not module_upvr._observing[UserId_upvr] then
            module_upvr._observing[UserId_upvr] = {}
        end
        if arg3(function() -- Line 34
            if module_upvr._observing[UserId_upvr] then
                local table_find_result1_2 = table.find(module_upvr._observing[UserId_upvr], arg1_2)
                if table_find_result1_2 then
                    table.remove(module_upvr._observing[UserId_upvr], table_find_result1_2)
                end
            end
        end) then
        else
            table.insert(module_upvr._observing[UserId_upvr], arg1_2)
        end
    end)
end
function module_upvr.removeCachedPlayerPolicyInfo(arg1) -- Line 48
    module_upvr._data[arg1.UserId] = nil
end
return module_upvr