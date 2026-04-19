-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVCVRyYW5zZm9ybS1ObyB2YWxpZCB3b3JsZCB3aXRoIHRoYXQgbmFtZSBjb3VsZCBiZSBmb3VuZC4IVmFsaWRhdGUMQXV0b2NvbXBsZXRlBVBhcnNlBXdvcmxkDFJlZ2lzdGVyVHlwZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNBcHAJUnVuQ29uc3RzCkNtZHJDbGllbnQGU2hhcmVkBFV0aWwVUExBQ0VfSURfVE9fV09STERfTUFQBXRhYmxlBGZpbmQGaW5zZXJ0D01ha2VGdXp6eUZpbmRlcgAGAwEBAAAABPsBAABSAgAAnwECAIIBAAAAABEBARgAAAAAEgAAAAAEAQAAAAAIHAIAAIwDAAC3AwIAAgAAAKkBAAGpAQEAbwIAAIIBAwABAwIAFQMBGAAAAAAAAAAAFgAAAAABAQAAAAABggACAAAAGQQBGAAaAAAAAAIBAAAAAAITAQAAggECAAAAHQUBGAAAHgAAAAAFAQEAAAAGbwMAAPsEAAC8AQDdAQAAAJ8BBAGCAAEAAgMGAwcAIgABGAAAAAAAASMAAAAADAAAAQAAQ6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAMEGAAAATQICbwcAAACfAQICpAIFAAAAQEBNAwAOCAAAAE0DAxIJAAAATQMDngoAAACfAgIC/wMAAAAAAABNBAGWCwAAAMYFAADGBgAAZAQOAKQJDgAANMCAUgoDAFILCACfCQMCRwkIAAAAAICeNAMFCAAAAFIKAwBSCwgApAkQAAA8wICfCQMBbgTx/wIAAABNBAI9EQAAAFIFAwCfBAIC4gUWAMAGFwASAAQAMAYFIRIAAADABhgAMAYFdhMAAADABhkAMAYFqxQAAADABhoAMAYFmxUAAADABhsAEgAFAIIGAgAcAwgEAAAAQAMJAwoDCwQAAEBAAwwDDQMOAw8DEAMRAxIDEwQANMCAAxQEADzAgAMVAwEDAwMEAwUFBBITFBUGAAYBBgIGAwYEBQABAgMEAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAAAAgACAAAAAAEAAAAAAAABAAAAAAAA/gAFAAAAAgMAAAAEAAAEAAAEAAAFAAABAAAAAAXnDrYLFNTnv3fkIiNwpDh+lxahf9XK3Ao=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:58
-- Luau version 6, Types version 3
-- Time taken: 0.002286 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {}
for _, v in require(ReplicatedStorage.App.RunConsts).PLACE_ID_TO_WORLD_MAP do
    if table.find(tbl, v) == nil then
        table.insert(tbl, v)
    end
end
local tbl_2_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(tbl)
function tbl_2_upvr.Transform(arg1) -- Line 17
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_2_upvr.Validate(arg1) -- Line 21
    local var7
    if 0 >= #arg1 then
        var7 = false
    else
        var7 = true
    end
    return var7, "No valid world with that name could be found."
end
function tbl_2_upvr.Autocomplete(arg1) -- Line 25
    return arg1
end
function tbl_2_upvr.Parse(arg1) -- Line 29
    return arg1[1]
end
return function(arg1) -- Line 34
    --[[ Upvalues[1]:
        [1]: tbl_2_upvr (readonly)
    ]]
    arg1:RegisterType("world", tbl_2_upvr)
end