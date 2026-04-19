-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUCVRyYW5zZm9ybS9ObyB2YWxpZCByb2JiZXJ5IHdpdGggdGhhdCBuYW1lIGNvdWxkIGJlIGZvdW5kLghWYWxpZGF0ZQxBdXRvY29tcGxldGUFUGFyc2UIZ2FtZXBhc3MMUmVnaXN0ZXJUeXBlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCkNtZHJDbGllbnQGU2hhcmVkBFV0aWwMR2FtZXBhc3NEYXRhCEdhbWVwYXNzBVRpdGxlBXRhYmxlBmluc2VydA9NYWtlRnV6enlGaW5kZXIABgMBAQAAAAT7AQAAUgIAAJ8BAgCCAQAAAAAQAQEYAAAAABEAAAAABAEAAAAACBwCAACMAwAAtwMCAAIAAACpAQABqQEBAG8CAACCAQMAAQMCABQDARgAAAAAAAAAABUAAAAAAQEAAAAAAYIAAgAAABgEARgAGQAAAAACAQAAAAACEwEAAIIBAgAAABwFARgAAB0AAAAABQEBAAAABm8DAAD7BAAAvAEA3QEAAACfAQQBggABAAIDBgMHACEAARgAAAAAAAEiAAAAAAwAAAEAADyjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAOBgAAAE0CAhIHAAAATQICnggAAACfAQICpAIFAAAAQEBNBAC9CgAAAE0DBIUJAAAAnwICAv8DAAAAAAAAUgQCAMYFAADGBgAAZAQIAE0LCLoLAAAAnjQDBAsAAABSCgMApAkOAAA0wICfCQMBbgT3/wIAAABNBAE9DwAAAFIFAwCfBAIC4gUUAMAGFQASAAQAMAYFIRAAAADABhYAMAYFdhEAAADABhcAMAYFqxIAAADABhgAMAYFmxMAAADABhkAEgAFAIIGAgAaAwgEAAAAQAMJAwoDCwQAAEBAAwwDDQMOAw8DEAMRAxIDEwQANMCAAxQDAQMDAwQDBQUEEBESEwYABgEGAgYDBgQFAAECAwQBAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAACAAIAAAABAAAAAAAAAP8ABAAAAAIDAAAABAAABAAABAAABQAAAQAAAAAFuWiT4gLwswvGUnz35A9gSslwhJaLrPnj

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:59
-- Luau version 6, Types version 3
-- Time taken: 0.001954 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {}
for _, v in require(ReplicatedStorage.Gamepass.GamepassData), nil do
    table.insert(tbl, v.Title)
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
    local var9
    if 0 >= #arg1 then
        var9 = false
    else
        var9 = true
    end
    return var9, "No valid robbery with that name could be found."
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
    arg1:RegisterType("gamepass", tbl_2_upvr)
end