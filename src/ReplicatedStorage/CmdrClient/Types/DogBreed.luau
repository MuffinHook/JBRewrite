-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTCVRyYW5zZm9ybS5ObyB2YWxpZCBicmVlZHMgd2l0aCB0aGF0IG5hbWUgY291bGQgYmUgZm91bmQuCFZhbGlkYXRlDEF1dG9jb21wbGV0ZQVQYXJzZQhkb2dicmVlZAxSZWdpc3RlclR5cGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUKQ21kckNsaWVudAZTaGFyZWQEVXRpbARHYW1lA0RvZwlEb2dDb25zdHMKTElTVF9CUkVFRA9NYWtlRnV6enlGaW5kZXIABgMBAQAAAAT7AQAAUgIAAJ8BAgCCAQAAAAAKAQEYAAAAAAsAAAAABAEAAAAACBwCAACMAwAAtwMCAAIAAACpAQABqQEBAG8CAACCAQMAAQMCAA4DARgAAAAAAAAAAA8AAAAAAQEAAAAAAYIAAgAAABIEARgAEwAAAAACAQAAAAACEwEAAIIBAgAAABYFARgAABcAAAAABQEBAAAABm8DAAD7BAAAvAEA3QEAAACfAQQBggABAAIDBgMHABsAARgAAAAAAAEcAAAAAAcAAAECADCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAOBgAAAE0CAhIHAAAATQICnggAAACfAQICpAIFAAAAQEBNAwC9CQAAAE0DA9kKAAAATQMD5QsAAACfAgICTQMCbgwAAABNBAE9DQAAAFIFAwCfBAIC4gUSAMAGEwASAAQAMAYFIQ4AAADABhQAMAYFdg8AAADABhUAMAYFqxAAAADABhYAMAYFmxEAAADABhcAEgAFAIIGAgAYAwgEAAAAQAMJAwoDCwQAAEBAAwwDDQMOAw8DEAMRAxIDEwMBAwMDBAMFBQQODxARBgAGAQYCBgMGBAUAAQIDBAEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAgABAAAAAgIAAAAEAAAEAAAEAAAFAAABAAAAAAVmkADULfPiFIAkmm2yPKunFogXoFRUatU=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:56
-- Luau version 6, Types version 3
-- Time taken: 0.002314 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(require(ReplicatedStorage.Game.Dog.DogConsts).LIST_BREED)
function tbl_upvr.Transform(arg1) -- Line 10
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 14
    local var4
    if 0 >= #arg1 then
        var4 = false
    else
        var4 = true
    end
    return var4, "No valid breeds with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 18
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 22
    return arg1[1]
end
return function(arg1) -- Line 27
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    arg1:RegisterType("dogbreed", tbl_upvr)
end