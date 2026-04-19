-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJG0dldFBvbGljeUluZm9Gb3JQbGF5ZXJBc3luYwNuZXcEZ2FtZQ1Qb2xpY3lTZXJ2aWNlCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQNTdGQHUHJvbWlzZQADBgMCAAAADfsDAAD7BQEAvAMDgAAAAACfAwMCUgQCAJ8EAQIOBAEAggABAFIEAABSBQMAnwQCAYIAAQABAwEABQABGAAAAAAAAQAAAQIAAAEGAAAAAAMBAgAAAAj7AQAATQEB7wAAAADZAgAAEgIBABIAAACfAQIAggEAAAEDAgEABAABGAAAAAAAAAAABQAAAAAEAAABAgAYowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCBgAAAFBATQMBoQcAAABNAwNyCAAAAJ8CAgLAAwkAEgACABIAAACCAwIACgMDBAAAAEADBAMFAwYDBwQAAFBAAwgDCQYBAQEBAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAABAAAAAQAAAAACuDU5v4IAqYiaPey5wVomQMgtLsuK8VO+

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:15
-- Luau version 6, Types version 3
-- Time taken: 0.000870 seconds

local Promise_upvr = require(game:GetService("ReplicatedStorage").Std.Promise)
local PolicyService_upvr = game:GetService("PolicyService")
return function(arg1) -- Line 4
    --[[ Upvalues[2]:
        [1]: Promise_upvr (readonly)
        [2]: PolicyService_upvr (readonly)
    ]]
    return Promise_upvr.new(function(arg1_2, arg2, arg3) -- Line 5
        --[[ Upvalues[2]:
            [1]: PolicyService_upvr (copied, readonly)
            [2]: arg1 (readonly)
        ]]
        if arg3() then
        else
            arg1_2(PolicyService_upvr:GetPolicyInfoForPlayerAsync(arg1))
        end
    end)
end