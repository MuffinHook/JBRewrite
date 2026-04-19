-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNFHBhdGhTdHJpbmdGb3JTb3J0aW5nA25ldwV0YWJsZQRzb3J0BmlwYWlycwRwYXRoBm1ldGhvZAdhZGRSb290CmNyZWF0ZVBsYW4HcmVxdWlyZQZzY3JpcHQGUGFyZW50CFRlc3RQbGFuAAMFAgAAAAAJTQMAdwAAAABNBAF3AAAAALcDAgAEAAAAqQIAAakCAQCCAgIAAQMBAB0AARgAAAAAAAAAAAAeAAAAAA0DAQAAABr7AwAATQMD7wAAAABSBAEAUgUCAJ8DAwKkBAMAAAgQgFIFAADABgQAnwQDAaQEBgAAAFBAUgUAAJ8EAgRRBAcATQsIYQcAAABNDAjyCAAAALwJA2wJAAAAnwkEAW4E+P8CAACAggMCAAoDAgMDAwQEAAgQgAYAAwUEAABQQAMGAwcDCAEAGgkBGAAAAAAAAAIAAAAABAAAAAABAAAAAAAA/wAEGwAAAAADAAABAgARowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAfsFAAAAnwACAv8BAQAAAAAAwAIGABIAAAAwAgEQBwAAAIIBAgAIAwoEAAAAQAMLBAAAIEADDAMNBgEDCQEBAQABGAAFAAAAAAAAAAACABIAAAAOAQAAAAACdPHisWY/bKxjSkvM0+JtewTp9cVGNYiw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:32:04
-- Luau version 6, Types version 3
-- Time taken: 0.001337 seconds

local module = {}
local TestPlan_upvr = require(script.Parent.TestPlan)
function module.createPlan(arg1, arg2, arg3) -- Line 26
    --[[ Upvalues[1]:
        [1]: TestPlan_upvr (readonly)
    ]]
    local any_new_result1 = TestPlan_upvr.new(arg2, arg3)
    table.sort(arg1, function(arg1_2, arg2_2) -- Line 29
        local var9
        if arg1_2.pathStringForSorting >= arg2_2.pathStringForSorting then
            var9 = false
        else
            var9 = true
        end
        return var9
    end)
    for _, v in ipairs(arg1) do
        any_new_result1:addRoot(v.path, v.method)
    end
    return any_new_result1
end
return module