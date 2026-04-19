-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTCVRyYW5zZm9ybS9ObyB2YWxpZCByb2JiZXJ5IHdpdGggdGhhdCBuYW1lIGNvdWxkIGJlIGZvdW5kLghWYWxpZGF0ZQxBdXRvY29tcGxldGUFUGFyc2UMZ2FtZUxvY2F0aW9uDFJlZ2lzdGVyVHlwZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNBcHANR2FtZUxvY2F0aW9ucwpDbWRyQ2xpZW50BlNoYXJlZARVdGlsBXRhYmxlBmluc2VydA9NYWtlRnV6enlGaW5kZXIABgMBAQAAAAT7AQAAUgIAAJ8BAgCCAQAAAAAQAQEYAAAAABEAAAAABAEAAAAACBwCAACMAwAAtwMCAAIAAACpAQABqQEBAG8CAACCAQMAAQMCABQDARgAAAAAAAAAABUAAAAAAQEAAAAAAYIAAgAAABgEARgAGQAAAAACAQAAAAACEwEAAIIBAgAAABwFARgAAB0AAAAABQEBAAAABm8DAAD7BAAAvAEA3QEAAACfAQQBggABAAIDBgMHACEAARgAAAAAAAEiAAAAAAwAAAEAADujAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgDBBgAAAE0CAg4HAAAAnwECAqQCBQAAAEBATQMADggAAABNAwMSCQAAAE0DA54KAAAAnwICAv8DAAAAAAAAUgQBAMYFAADGBgAAZAQHAJ40AwUHAAAAUgoDAFILBwCkCQ0AADCwgJ8JAwFuBPj/AQAAAE0EAj0OAAAAUgUDAJ8EAgLiBRMAwAYUABIABAAwBgUhDwAAAMAGFQAwBgV2EAAAAMAGFgAwBgWrEQAAAMAGFwAwBgWbEgAAAMAGGAASAAUAggYCABkDCAQAAABAAwkDCgMLBAAAQEADDAMNAw4DDwMQAxEDEgQAMLCAAxMDAQMDAwQDBQUEDxAREgYABgEGAgYDBgQFAAECAwQBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAAACAAIAAAABAAAAAAAA/wAEAAAAAgMAAAAEAAAEAAAEAAAFAAABAAAAAAUCHDExN4FTU3WDdr3ER0macgQmRTDYWzA=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:57
-- Luau version 6, Types version 3
-- Time taken: 0.001935 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {}
for i in require(ReplicatedStorage.App.GameLocations), nil do
    table.insert(tbl, i)
end
local tbl_2_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util).MakeFuzzyFinder(tbl)
function tbl_2_upvr.Transform(arg1) -- Line 16
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_2_upvr.Validate(arg1) -- Line 20
    local var7
    if 0 >= #arg1 then
        var7 = false
    else
        var7 = true
    end
    return var7, "No valid robbery with that name could be found."
end
function tbl_2_upvr.Autocomplete(arg1) -- Line 24
    return arg1
end
function tbl_2_upvr.Parse(arg1) -- Line 28
    return arg1[1]
end
return function(arg1) -- Line 33
    --[[ Upvalues[1]:
        [1]: tbl_2_upvr (readonly)
    ]]
    arg1:RegisterType("gameLocation", tbl_2_upvr)
end