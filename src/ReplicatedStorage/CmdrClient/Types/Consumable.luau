-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTCVRyYW5zZm9ybTJObyB2YWxpZCBjb25zdW1hYmxlIHdpdGggdGhhdCBuYW1lIGNvdWxkIGJlIGZvdW5kLghWYWxpZGF0ZQxBdXRvY29tcGxldGUFUGFyc2UKY29uc3VtYWJsZQxSZWdpc3RlclR5cGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUKQ21kckNsaWVudAZTaGFyZWQEVXRpbAtDb25zdW1hYmxlcw9Db25zdW1hYmxlc0RhdGEFdGFibGUGaW5zZXJ0D01ha2VGdXp6eUZpbmRlcgAGAwEBAAAABPsBAABSAgAAnwECAIIBAAAAAAwBARgAAAAADQAAAAAEAQAAAAAIHAIAAIwDAAC3AwIAAgAAAKkBAAGpAQEAbwIAAIIBAwABAwIAEAMBGAAAAAAAAAAAEQAAAAABAQAAAAABggACAAAAFAQBGAAVAAAAAAIBAAAAAAITAQAAggECAAAAGAUBGAAAGQAAAAAFAQEAAAAGbwMAAPsEAAC8AQDdAQAAAJ8BBAGCAAEAAgMGAwcAHQABGAAAAAAAAR4AAAAADAAAAQAAO6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAA4GAAAATQICEgcAAABNAgKeCAAAAJ8BAgKkAgUAAABAQE0DAMgJAAAATQMDCAoAAACfAgIC/wMAAAAAAABSBAIAxgUAAMYGAABkBAcAnjQDBQcAAABSCgMAUgsHAKQJDQAAMLCAnwkDAW4E+P8CAAAATQQBPQ4AAABSBQMAnwQCAuIFEwDABhQAEgAEADAGBSEPAAAAwAYVADAGBXYQAAAAwAYWADAGBasRAAAAwAYXADAGBZsSAAAAwAYYABIABQCCBgIAGQMIBAAAAEADCQMKAwsEAABAQAMMAw0DDgMPAxADEQMSBAAwsIADEwMBAwMDBAMFBQQPEBESBgAGAQYCBgMGBAUAAQIDBAEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAIAAQAAAAEAAAAAAAD/AAMAAAACAQAAAAQAAAQAAAQAAAUAAAEAAAAABY5MfJKWTaHFSppQoEWRuHH+VGvmvIgWkw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:55
-- Luau version 6, Types version 3
-- Time taken: 0.002363 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {}
for i, _ in require(ReplicatedStorage.Consumables.ConsumablesData), nil do
    table.insert(tbl, i)
end
local tbl_2_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(tbl)
function tbl_2_upvr.Transform(arg1) -- Line 12
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_2_upvr.Validate(arg1) -- Line 16
    local var9
    if 0 >= #arg1 then
        var9 = false
    else
        var9 = true
    end
    return var9, "No valid consumable with that name could be found."
end
function tbl_2_upvr.Autocomplete(arg1) -- Line 20
    return arg1
end
function tbl_2_upvr.Parse(arg1) -- Line 24
    return arg1[1]
end
return function(arg1) -- Line 29
    --[[ Upvalues[1]:
        [1]: tbl_2_upvr (readonly)
    ]]
    arg1:RegisterType("consumable", tbl_2_upvr)
end