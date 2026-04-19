-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSCVRyYW5zZm9ybTlObyB2YWxpZCBhaXJEcm9wRGlmZmljdWx0eSB3aXRoIHRoYXQgbmFtZSBjb3VsZCBiZSBmb3VuZC4IVmFsaWRhdGUMQXV0b2NvbXBsZXRlBVBhcnNlEWFpckRyb3BEaWZmaWN1bHR5DFJlZ2lzdGVyVHlwZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQpDbWRyQ2xpZW50BlNoYXJlZARVdGlsB0FpckRyb3ANQWlyRHJvcENvbnN0cxFUWVBFX0VOVU1fVE9fTkFNRQ9NYWtlRnV6enlGaW5kZXIABgMBAQAAAAT7AQAAUgIAAJ8BAgCCAQAAAAAJAQEYAAAAAAoAAAAABAEAAAAACBwCAACMAwAAtwMCAAIAAACpAQABqQEBAG8CAACCAQMAAQMCAA0DARgAAAAAAAAAAA4AAAAAAQEAAAAAAYIAAgAAABEEARgAEgAAAAACAQAAAAACEwEAAIIBAgAAABUFARgAABYAAAAABQEBAAAABm8DAAD7BAAAvAEA3QEAAACfAQQBggABAAIDBgMHABoAARgAAAAAAAEbAAAAAAcAAAECAC6jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAOBgAAAE0CAhIHAAAATQICnggAAACfAQICpAIFAAAAQEBNAwCDCQAAAE0DA0kKAAAAnwICAk0DAv0LAAAATQQBPQwAAABSBQMAnwQCAuIFEQDABhIAEgAEADAGBSENAAAAwAYTADAGBXYOAAAAwAYUADAGBasPAAAAwAYVADAGBZsQAAAAwAYWABIABQCCBgIAFwMIBAAAAEADCQMKAwsEAABAQAMMAw0DDgMPAxADEQMSAwEDAwMEAwUFBA0ODxAGAAYBBgIGAwYEBQABAgMEAQABGAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAgABAAAAAgEAAAAEAAAEAAAEAAAFAAABAAAAAAWcja7EUYe+/Ib6Bjz5JQP37JW5sK5JxMU=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:54
-- Luau version 6, Types version 3
-- Time taken: 0.001578 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(require(ReplicatedStorage.AirDrop.AirDropConsts).TYPE_ENUM_TO_NAME)
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
    return var4, "No valid airDropDifficulty with that name could be found."
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
    arg1:RegisterType("airDropDifficulty", tbl_upvr)
end