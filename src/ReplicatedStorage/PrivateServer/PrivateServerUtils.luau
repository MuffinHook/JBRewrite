-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTEHdhaXRGb3JBdHRyaWJ1dGUVU0VSVkVSX1RZUEVfQVRUUl9OQU1FB3RpbWVvdXQbcHJvbWlzZUdldFByaXZhdGVTZXJ2ZXJUeXBlGUJBVFRMRV9TRVJWRVJfU0VSVkVSX1RZUEUHYW5kVGhlbhhwcm9taXNlR2V0SXNCYXR0bGVTZXJ2ZXIFYXdhaXQFZXJyb3IUZ2V0UHJpdmF0ZVNlcnZlclR5cGURZ2V0SXNCYXR0bGVTZXJ2ZXIEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUNUHJpdmF0ZVNlcnZlchNQcml2YXRlU2VydmVyQ29uc3RzA1N0ZA9SeEluc3RhbmNlVXRpbHMABgMAAwAAAA37AAAATQAA2QAAAAD7AQEA+wICAE0CAmYBAAAAnwADAowCCgC8AAByAgAAAJ8AAwCCAAAAAwMBAwIDAwAGBAEYAAAAAAAAAAAAAAAAAAcAAAAAAwEBAAAACPsCAABNAgKXAAAAAPEAAgACAAAAqQEAAakBAQCCAQIAAQMFAAoAARgAAAAAAAAAAAsAAAAAAwACAAAACvsAAABNAADMAAAAAJ8AAQLAAgEAEgIBALwAALUCAAAAnwADAIIAAAADAwQGAQMGAQEJBwEYAAAAAAAAAAAAAAoAAAAABAABAAAADfsAAABNAADMAAAAAJ8AAQK8AAANAQAAAJ8AAgMrAAQApAIDAAAAIEBSAwEAnwICAYIBAgAEAwQDCAMJBAAAIEAADgoBGAAAAAAAAAABAQAAAAIPAAAAAAQAAQAAAA37AAAATQAA4gAAAACfAAECvAAADQEAAACfAAIDKwAEAKQCAwAAACBAUgMBAJ8CAgGCAQIABAMHAwgDCQQAACBAABULARgAAAAAAAAAAQEAAAACFgAAAAAFAAABAgArowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIA1gYAAABNAgJCBwAAAJ8BAgKkAgUAAABAQE0DAKEIAAAATQMDUgkAAACfAgIC/wMDAAAAAADABAoAEgACABIAAAASAAEAMAQDzAsAAADABAwAEgADABIAAQAwBAPiDQAAAMAEDgASAAMAMAQDGA8AAADABBAAEgADADAEA4YRAAAAggMCABIDDAQAAABAAw0DDgMPBAAAQEADEAMRAxIDEwYAAwQGAgMHBgMDCgYEAwsEAAIDBAEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAACAAEAAAAAAAMAAAAABQAAAAcAAAAHAQAAAAAF1j7wjgD61qM9J7Mcf6Q3uKYm5/rk+pqP

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:16
-- Luau version 6, Types version 3
-- Time taken: 0.002598 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local PrivateServerConsts_upvr = require(ReplicatedStorage_upvr.PrivateServer.PrivateServerConsts)
local module_upvr = {}
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
function module_upvr.promiseGetPrivateServerType() -- Line 6
    --[[ Upvalues[3]:
        [1]: RxInstanceUtils_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: PrivateServerConsts_upvr (readonly)
    ]]
    return RxInstanceUtils_upvr.waitForAttribute(ReplicatedStorage_upvr, PrivateServerConsts_upvr.SERVER_TYPE_ATTR_NAME):timeout(10)
end
function module_upvr.promiseGetIsBattleServer() -- Line 9
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: PrivateServerConsts_upvr (readonly)
    ]]
    return module_upvr.promiseGetPrivateServerType():andThen(function(arg1) -- Line 10
        --[[ Upvalues[1]:
            [1]: PrivateServerConsts_upvr (copied, readonly)
        ]]
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
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local any_await_result1, any_await_result2 = module_upvr.promiseGetPrivateServerType():await()
    if not any_await_result1 then
        error(any_await_result2)
    end
    return any_await_result2
end
function module_upvr.getIsBattleServer() -- Line 21
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local any_await_result1_2, any_await_result2_2 = module_upvr.promiseGetIsBattleServer():await()
    if not any_await_result1_2 then
        error(any_await_result2_2)
    end
    return any_await_result2_2
end
return module_upvr