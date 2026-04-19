-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUBV9kYXRhBlVzZXJJZApfb2JzZXJ2aW5nGXNldENhY2hlZFBsYXllclBvbGljeUluZm8ZZ2V0Q2FjaGVkUGxheWVyUG9saWN5SW5mbwV0YWJsZQRmaW5kBnJlbW92ZQZpbnNlcnQHcmVzb2x2ZQNuZXcdcHJvbWlzZUNhY2hlZFBsYXllclBvbGljeUluZm8ccmVtb3ZlQ2FjaGVkUGxheWVyUG9saWN5SW5mbwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQHUHJvbWlzZQZTaWduYWwABwoCAQAAAB77AgAATQICjAAAAABNAwDmAQAAAGoBAgP7AwAATQMDOwIAAABNBADmAQAAAIcCAwQOAhAA+wMAAE0DAzsCAAAATQQA5gEAAADGBQAAagUDBFIDAgDGBAAAxgUAAGQDAwBSCAcAUgkBAJ8IAgFuA/z/AgAAAIIAAQADAwEDAgMDAAkEARgAAAAAAAABAAAAAAABAQAAAAAAAAEAAAABAAD/AAQKAAAAAAQBAQAAAAf7AgAATQICjAAAAABNAwDmAQAAAIcBAgOCAQIAAgMBAwIAEwUBGAAAAAAAAAAUAAAAAAUAAwAAABr7AQAATQEBOwAAAAD7AgEAhwABAg4AEwCkAAMAAAgQgPsCAABNAgI7AAAAAPsDAQCHAQID+wICAJ8AAwIOAAkApAEFAAAQEID7AwAATQMDOwAAAAD7BAEAhwIDBFIDAACfAQMBggABAAYDAwMGAwcEAAgQgAMIBAAQEIAAIgABGAAAAAAAAAEAAAAAAAAAAAEBAAAAAAAAAAADIwAAAAAHAwIAAAAh+wMAAE0DA+YAAAAA+wUBAE0FBTsBAAAAhwQFAysEBgD7BAEATQQEOwEAAAD/BQAAAAAAAGoFBANSBAIA2QUAABICAQASAAMAEgAAAJ8EAgIOBAEAggABAPsGAQBNBgY7AQAAAIcFBgOeNAUEAAAAAFIGAACkBAQAAAwggJ8EAwGCAAEABQMCAwMDBgMJBAAMIIABAhsAARgAAAABAAAAAAEAAAAAAAQAAAAAAAAJAgAAAAAAAAAAAAEcAAAAAAQBAgAAABT7AQAATQEBpwAAAABSAgAAnwECAg4BBgD7AgEATQICHQEAAABSAwEAnwICAIICAAD7AgEATQIC7wIAAADZAwAAEgAAABICAACfAgIAggIAAAMDBQMKAwsBAxYMARgAAAAAAAEBAAAAAAACAAAAAAAAABcAAAAABAEBAAAACPsBAABNAQGMAAAAAE0CAOYBAAAAxgMAAGoDAQKCAAEAAgMBAwIAMA0BGAAAAAAAAAABMQAAAAAFAAABAgAxowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJyBwAAAJ8BAgKkAgUAAABAQE0DAKEGAAAATQMDHwgAAACfAgIC/wMEAAAAAAD/BAAAAAAAADAEA4wJAAAA/wQAAAAAAAAwBAM7CgAAAMAECwASAAMAMAQDswwAAADABA0AEgADADAEA6cOAAAAwAQPABIAAwASAAEAMAQDhRAAAADABBEAEgADADAEAzUSAAAAggMCABMDDgQAAABAAw8DEAMRBAAAQEADEgMTAxQDAQMDBgADBAYBAwUGBAMMBgUDDQQAAQQFAQABGAABAAAAAAABAAAAAAAAAQAAAAAAAAIAAQAAAAEAAAABAAAACgAAAAMAAAAAGgAAAAMBAAAAAAYJjToGVJpIrRuc0nQ+ZKxXeZUtcjtJUAc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:14
-- Luau version 6, Types version 3
-- Time taken: 0.003762 seconds

local module_upvr = {
    _data = {};
    _observing = {};
}
function module_upvr.setCachedPlayerPolicyInfo(arg1, arg2) -- Line 9
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
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
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr._data[arg1.UserId]
end
local Promise_upvr = require(game:GetService("ReplicatedStorage").Std.Promise)
function module_upvr.promiseCachedPlayerPolicyInfo(arg1) -- Line 22
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: Promise_upvr (readonly)
    ]]
    local any_getCachedPlayerPolicyInfo_result1 = module_upvr.getCachedPlayerPolicyInfo(arg1)
    if any_getCachedPlayerPolicyInfo_result1 then
        return Promise_upvr.resolve(any_getCachedPlayerPolicyInfo_result1)
    end
    return Promise_upvr.new(function(arg1_2, arg2, arg3) -- Line 27
        --[[ Upvalues[2]:
            [1]: arg1 (readonly)
            [2]: module_upvr (copied, readonly)
        ]]
        local UserId_upvr = arg1.UserId
        if not module_upvr._observing[UserId_upvr] then
            module_upvr._observing[UserId_upvr] = {}
        end
        if arg3(function() -- Line 34
            --[[ Upvalues[3]:
                [1]: module_upvr (copied, readonly)
                [2]: UserId_upvr (readonly)
                [3]: arg1_2 (readonly)
            ]]
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
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    module_upvr._data[arg1.UserId] = nil
end
return module_upvr