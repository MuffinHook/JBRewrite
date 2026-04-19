-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBmlwYWlycwlHZXRUYWdnZWQIQmFzZVBhcnQDSXNBBmFzc2VydAlDYXN0UG9pbnQBYwFzBkNGcmFtZQRTaXplDGlzUG9pbnRJblRhZwRnYW1lEUNvbGxlY3Rpb25TZXJ2aWNlCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQNTdGQGUmVnaW9uC1JlZ2lvblV0aWxzAAILAgIAAAAmpAIBAAAAAED7AwAAUgUBALwDAwUCAAAAnwMDAJ8CAARRAhkAbwoDALwIBv4EAAAAnwgDAEwBAAKkBwYAAABQQJ8HAAH7BwEATQcHoQcAAADiCAoATQkGhQsAAAAwCQiCCAAAAE0JBi8MAAAAMAkIkgkAAABSCQAAnwcDAg4HAgCpBwEAggcCAG4C5v8CAACAqQIAAIICAgANAwEEAAAAQAMCAwMDBAMFBAAAUEADBgMHAwgFAggJAwkDCgAGCwEYAAAAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAABAP0ABgAHAAAAAAUAAAECAB6jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUEBNAwGhBwAAAE0DA/MIAAAATQMD/gkAAACfAgIC/wMBAAAAAADABAoAEgAAABIAAgAwBAOyCwAAAIIDAgAMAwwEAAAAQAMNAw4DDwMQBAAAUEADEQMSAxMGAAMLAQABAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAAAAAIAAQAAAAAJAQAAAAABqA3t4+UsahSsJLl4SST7edgV+peayYfi

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:46:51
-- Luau version 6, Types version 3
-- Time taken: 0.001118 seconds

local module = {}
local CollectionService_upvr = game:GetService("CollectionService")
local RegionUtils_upvr = require(game:GetService("ReplicatedStorage").Std.Region.RegionUtils)
function module.isPointInTag(arg1, arg2) -- Line 6
    --[[ Upvalues[2]:
        [1]: CollectionService_upvr (readonly)
        [2]: RegionUtils_upvr (readonly)
    ]]
    for _, v in ipairs(CollectionService_upvr:GetTagged(arg2)) do
        assert(v:IsA("BasePart"))
        if RegionUtils_upvr.CastPoint({
            c = v.CFrame;
            s = v.Size;
        }, arg1) then
            return true
        end
    end
    return false
end
return module