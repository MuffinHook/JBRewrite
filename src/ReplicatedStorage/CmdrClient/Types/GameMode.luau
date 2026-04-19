-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSCVRyYW5zZm9ybTBObyB2YWxpZCBnYW1lbW9kZSB3aXRoIHRoYXQgbmFtZSBjb3VsZCBiZSBmb3VuZC4IVmFsaWRhdGUMQXV0b2NvbXBsZXRlBVBhcnNlCGdhbWVtb2RlDFJlZ2lzdGVyVHlwZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQpDbWRyQ2xpZW50BlNoYXJlZARVdGlsCEdhbWVNb2RlDUdhbWVNb2RlVXRpbHMQZ2V0R2FtZU1vZGVOYW1lcw9NYWtlRnV6enlGaW5kZXIABgMBAQAAAAT7AQAAUgIAAJ8BAgCCAQAAAAAJAQEYAAAAAAoAAAAABAEAAAAACBwCAACMAwAAtwMCAAIAAACpAQABqQEBAG8CAACCAQMAAQMCAA0DARgAAAAAAAAAAA4AAAAAAQEAAAAAAYIAAgAAABEEARgAEgAAAAACAQAAAAACEwEAAIIBAgAAABUFARgAABYAAAAABQEBAAAABm8DAAD7BAAAvAEA3QEAAACfAQQBggABAAIDBgMHABoAARgAAAAAAAEbAAAAAAcAAAECAC+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAOBgAAAE0CAhIHAAAATQICnggAAACfAQICpAIFAAAAQEBNAwCbCQAAAE0DA8YKAAAAnwICAk0DAgELAAAAnwMBAk0EAT0MAAAAUgUDAJ8EAgLiBREAwAYSABIABAAwBgUhDQAAAMAGEwAwBgV2DgAAAMAGFAAwBgWrDwAAAMAGFQAwBgWbEAAAAMAGFgASAAUAggYCABcDCAQAAABAAwkDCgMLBAAAQEADDAMNAw4DDwMQAxEDEgMBAwMDBAMFBQQNDg8QBgAGAQYCBgMGBAUAAQIDBAEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAIAAAEAAAACAQAAAAQAAAQAAAQAAAUAAAEAAAAABb0OZgNt2Y+Vr7E7Ih1F2gbNFnF3j8oMAg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:57
-- Luau version 6, Types version 3
-- Time taken: 0.001946 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(require(ReplicatedStorage.GameMode.GameModeUtils).getGameModeNames())
function tbl_upvr.Transform(arg1) -- Line 9
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 13
    local var4
    if 0 >= #arg1 then
        var4 = false
    else
        var4 = true
    end
    return var4, "No valid gamemode with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 17
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 21
    return arg1[1]
end
return function(arg1) -- Line 26
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    arg1:RegisterType("gamemode", tbl_upvr)
end