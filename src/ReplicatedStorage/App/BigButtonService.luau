-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBXRhYmxlBGZpbmQGYWN0aXZlBnJlbW92ZQ10cmlnZ2VyVXBkYXRlBEZpcmUGaW5zZXJ0A2FkZARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQGU2lnbmFsA25ldwADBAACAAAAFaQAAgAABACA+wEAAE0BAeMDAAAA+wIBAJ8AAwKkAQUAABAAgPsCAABNAgLjAwAAAFIDAACfAQMB+wEAAE0BAQ8GAAAAvAEB3QcAAACfAQIBggABAAgDAQMCBAAEAIADAwMEBAAQAIADBQMGAAoAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAELAAAAAAQBAQAAABP7AgAATQIC4wAAAACeNAIEAAAAAFIDAACkAQMAAAgQgJ8BAwH7AQAATQEBDwQAAAC8AQHdBQAAAJ8BAgHZAQAAEgIAABIAAACCAQIABgMDAwEDBwQACBCAAwUDBgEABwgBGAAAAAAAAAAAAAEAAAAAAAEAAAAIAAAAAAQAAAECAB6jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAh8HAAAAnwECAv8CAwAAAAAATQMB7wgAAACfAwECMAMCDwkAAAD/AwAAAAAAADADAuMKAAAAwAMLABIAAgAwAwK/DAAAAIICAgANAwkEAAAAQAMKAwsDDAQAAEBAAw0DDgMPAwUDAwYBAwgBAQEAARgAAAAAAAAAAQAAAAAAAAIAAQAAAAABAAAAAQAAAAkBAAAAAAIR+4oLLfjW3F2h9lMQBzrvYeOdfyM/4Ao=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:12
-- Luau version 6, Types version 3
-- Time taken: 0.001000 seconds

local module_upvr = {
    triggerUpdate = require(game:GetService("ReplicatedStorage").Std.Signal).new();
    active = {};
}
function module_upvr.add(arg1) -- Line 7
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    table.insert(module_upvr.active, arg1)
    module_upvr.triggerUpdate:Fire()
    return function() -- Line 10
        --[[ Upvalues[2]:
            [1]: module_upvr (copied, readonly)
            [2]: arg1 (readonly)
        ]]
        table.remove(module_upvr.active, table.find(module_upvr.active, arg1))
        module_upvr.triggerUpdate:Fire()
    end
end
return module_upvr