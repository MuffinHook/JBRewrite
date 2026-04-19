-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMDGdyb3VwQWxsb3dlZAhFeGVjdXRvcgVHcm91cC1Zb3UgZG9uJ3QgaGF2ZSBwZXJtaXNzaW9uIHRvIHJ1biB0aGlzIGNvbW1hbmQJQmVmb3JlUnVuDFJlZ2lzdGVySG9vawRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQ5DbWRyUGVybWlzc2lvbgdDbWRyRXh0AAMEAQEAAAAM+wEAAE0BAR8AAAAATQIA/wEAAABNAwDEAgAAAJ8BAwIOAQEAggABAG8BAwCCAQIABAMBAwIDAwMEAAYAARgAAAAAAAAAAAABAgAHAAAAAAUBAQAAAAdvAwAAwAQBABICAAC8AQDvAgAAAJ8BBAGCAAEAAwMFBgADBgEABQABGAAAAAAAAAYGAAAAAAQAAAECABGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAwD+BwAAAE0CA1gGAAAAnwECAsACCAASAAEAggICAAkDBwQAAABAAwgDCQMKBAAAQEADCwMMBgEBAQEAARgAAAAAAAAAAQAAAAAAAAMAAAEAAAAAAmyK/xAlnlRbDnOJ0IkedfAckuhkXk6VEQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:54
-- Luau version 6, Types version 3
-- Time taken: 0.000832 seconds

local CmdrPermission_upvr = require(game:GetService("ReplicatedStorage").CmdrExt.CmdrPermission)
return function(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: CmdrPermission_upvr (readonly)
    ]]
    arg1:RegisterHook("BeforeRun", function(arg1_2) -- Line 6
        --[[ Upvalues[1]:
            [1]: CmdrPermission_upvr (copied, readonly)
        ]]
        if CmdrPermission_upvr.groupAllowed(arg1_2.Executor, arg1_2.Group) then return end
        return "You don't have permission to run this command"
    end)
end