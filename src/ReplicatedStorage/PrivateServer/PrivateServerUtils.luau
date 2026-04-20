local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local PrivateServerConsts_upvr = require(ReplicatedStorage_upvr.PrivateServer.PrivateServerConsts)
local module_upvr = {}
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
function module_upvr.promiseGetPrivateServerType() -- Line 6
    return RxInstanceUtils_upvr.waitForAttribute(ReplicatedStorage_upvr, PrivateServerConsts_upvr.SERVER_TYPE_ATTR_NAME):timeout(10)
end
function module_upvr.promiseGetIsBattleServer() -- Line 9
    return module_upvr.promiseGetPrivateServerType():andThen(function(arg1) -- Line 10
        local var6
        if arg1 ~= PrivateServerConsts_upvr.BATTLE_SERVER_SERVER_TYPE then
            var6 = false
        else
            var6 = true
        end
        return var6
    end)
end
function module_upvr.getPrivateServerType() -- Line 14
    local any_await_result1, any_await_result2 = module_upvr.promiseGetPrivateServerType():await()
    if not any_await_result1 then
        error(any_await_result2)
    end
    return any_await_result2
end
function module_upvr.getIsBattleServer() -- Line 21
    local any_await_result1_2, any_await_result2_2 = module_upvr.promiseGetIsBattleServer():await()
    if not any_await_result1_2 then
        error(any_await_result2_2)
    end
    return any_await_result2_2
end
return module_upvr