-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBE5hbWUJVHJhbnNmb3JtNU5vIHZhbGlkIHZlaGljbGUgbWFrZXMgd2l0aCB0aGF0IG5hbWUgY291bGQgYmUgZm91bmQuCFZhbGlkYXRlDEF1dG9jb21wbGV0ZQVQYXJzZQR0b29sDFJlZ2lzdGVyVHlwZQV0b29scxBNYWtlTGlzdGFibGVUeXBlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZApUYWJsZVV0aWxzCkNtZHJDbGllbnQGU2hhcmVkBFV0aWwDbWFwCFJlc291cmNlCkl0ZW1TeXN0ZW0GTW9kZWxzC0dldENoaWxkcmVuD01ha2VGdXp6eUZpbmRlcgAHAgEAAAAAA00BALoAAAAAggECAAEDAQAFAAEYAAAABgAAAAADAQEAAAAE+wEAAFICAACfAQIAggEAAAAACwIBGAAAAAAMAAAAAAQBAAAAAAgcAgAAjAMAALcDAgACAAAAqQEAAakBAQBvAgAAggEDAAEDAwAPBAEYAAAAAAAAAAAQAAAAAAEBAAAAAAGCAAIAAAATBQEYABQAAAAAAgEAAAAAAhMBAACCAQIAAAAXBgEYAAAYAAAAAAYBAgAAAA9vAwAA+wQAALwBAN0BAAAAnwEEAW8DAgD7BAEATQQEJAMAAAD7BQAAnwQCALwBAN0BAAAAnwEAAYIAAQAEAwcDCAMJAwoAHAABGAAAAAAAAQAAAAAAAAAAAR0AAAAABwAAAQIAOqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICGAcAAACfAQICpAIFAAAAQEBNAwAOCAAAAE0DAxIJAAAATQMDngoAAACfAgICTQMBkAsAAABNBABiDAAAAE0EBPANAAAATQQE+A4AAAC8BARoDwAAAJ8EAgLABRAAnwMDAk0EAj0RAAAAUgUDAJ8EAgLiBRYAwAYXABIABAAwBgUhEgAAAMAGGAAwBgV2EwAAAMAGGQAwBgWrFAAAAMAGGgAwBgWbFQAAAMAGGwASAAUAEgACAIIGAgAcAwsEAAAAQAMMAw0DDgQAAEBAAw8DEAMRAxIDEwMUAxUDFgMXAxgGAAMZAwIDBAMFAwYFBBITFBUGAQYCBgMGBAYFBgABAgMEBQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAIAAAAAAAAAAAAAAAADAAAAAgEAAAAEAAAEAAAEAAAFAAAAAQAAAAAG5WlzPRoNC9D6PHLYlfd6V5VxZEnXrRk8

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:00
-- Luau version 6, Types version 3
-- Time taken: 0.001793 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util)
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = Util_upvr.MakeFuzzyFinder(require(ReplicatedStorage.Std.TableUtils).map(ReplicatedStorage.Resource.ItemSystem.Models:GetChildren(), function(arg1) -- Line 5
    return arg1.Name
end))
function tbl_upvr.Transform(arg1) -- Line 11
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 15
    local var6
    if 0 >= #arg1 then
        var6 = false
    else
        var6 = true
    end
    return var6, "No valid vehicle makes with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 19
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 23
    return arg1[1]
end
return function(arg1) -- Line 28
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Util_upvr (readonly)
    ]]
    arg1:RegisterType("tool", tbl_upvr)
    arg1:RegisterType("tools", Util_upvr.MakeListableType(tbl_upvr))
end