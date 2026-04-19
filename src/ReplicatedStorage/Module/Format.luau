-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdBnN0cmluZwVtYXRjaBVeKFteJWRdKiVkKSglZCopKC4tKSQHcmV2ZXJzZQgoJWQlZCVkKQMlMSwEZ3N1YgVDb21tYQZhc3NlcnQEbWF0aAVmbG9vcgABLQxHZW5lcmFsLkNhc2gDYWJzC0Zvcm1hdEJ5S2V5CEN1cnJlbmN5CSVkIG1pbnV0ZQZmb3JtYXQBcwUgYW5kIAklZCBzZWNvbmQGTWluU2VjBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlDExvY2FsaXphdGlvbgZNb2R1bGUABAwBAAAAABWkAQIAAAQAgFICAABvAwMAnwEDBFIFAQC8CAKbBAAAAJ8IAgJvCgUAbwsGALwICMwHAAAAnwgEArwICJsEAAAAnwgCAlIGCABSBwMAcwQFB4IEAgAIAwEDAgQABACAAwMDBAMFAwYDBwAGCAEYAAAAAAABAAAAAAAAAAAAAAAAAAAABwAAAAALAQIAAAApRwACAAAAAICpAgABqQIBALsBAgKkAQEAAAAAQJ8BAgGVAgACuwwCAqQBBQAAEDCAnwECAlIAAQCMAgAAfQIDAAAAAABvAQYAZQABAG8BBwBSAwEA+wQAAG8GCAD/BwAAAQAAAPsIAQBNCAjECQAAALsCAANSCgAApAkLAAAoMICfCQICnwgCAMUHCAABAAAAvAQEmwwAAACfBAQCcwIDBIICAgANAwkEAAAAQAIAAAAAAADgPwMKAwsEABAwgAMMAw0DDgMIAw8EACgwgAMQAAoRARgAAAAAAAAAAAMAAAAAAAEAAAAAAAEAAAAAAQAAAAAAAAAAAAD/AAAAAAsAAAAACAEAAAALAAACAwUNAgMFJQIvbwEAAD4DAAG7DAMCpAIEAAAMIICfAgICIQMAAYwEAABgBA0AAgAAAFIEAQBvBQUAUgcCALwFBY0GAAAAnwUDAnMBBAUNAgQABwAAAFIEAQBvBQgAcwEEBYwEAABgBAcAAgAAAIwEAABgBAQAAwAAAFIEAQBvBQkAcwEEBYwEAABgBA0AAwAAAFIEAQBvBQoAUgcDALwFBY0GAAAAnwUDAnMBBAUNAwQABwAAAFIEAQBvBQgAcwEEBYIBAgALAwwCAAAAAAAATkADCgMLBAAMIIADEgMTAgAAAAAAAPA/AxQDFQMWABQXARgAAQAAAAABAQAAAQAAAAAAAAEAAQAAAwAAAAAAAQAAAgAAAQAAAAAAAAEAAQAAAxUAAAAABAAAAQIAHKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAEAHAAAATQIDfAYAAACfAQIC/wIDAAAAAADAAwgAMAMCxAkAAADAAwoAEgABABIAAgAwAwIJCwAAAMADDAAwAwIrDQAAAIICAgAOAxgEAAAAQAMZAxoDGwQAAEBAAxwDHQYAAwgGAQMRBgIDFwMAAQIBAAEYAAAAAAAAAAEAAAAAAAACAAIAAAQAAAAACgAAFgEAAAAAA4g6V2tgYiGo5PCAWi4PQ874IkAfuv49ag==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:29
-- Luau version 6, Types version 3
-- Time taken: 0.003403 seconds

local module_upvr = {
    Comma = function(arg1) -- Line 6, Named "Comma"
        local string_match_result1, string_match_result2, string_match_result3 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
        return string_match_result1..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3
    end;
}
local Localization_upvr = require(game:GetService("ReplicatedStorage").Module.Localization)
function module_upvr.Currency(arg1) -- Line 10
    --[[ Upvalues[2]:
        [1]: Localization_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    if arg1 == nil then
    else
    end
    assert(true)
    local rounded = math.floor(arg1 + 0.5)
    if 0 <= rounded then
    else
    end
    return '-'..Localization_upvr:FormatByKey("General.Cash", {module_upvr.Comma(math.abs(rounded))})
end
function module_upvr.MinSec(arg1) -- Line 20
    local floored = math.floor(arg1 / 60)
    local var12 = arg1 % 60
    local var13
    if 0 < floored then
        var13 = var13.."%d minute":format(floored)
        if floored ~= 1 then
            var13 = var13..'s'
        end
    end
    if 0 < floored and 0 < var12 then
        var13 = var13.." and "
    end
    if 0 < var12 then
        var13 = var13.."%d second":format(var12)
        if var12 ~= 1 then
            var13 = var13..'s'
        end
    end
    return var13
end
return module_upvr