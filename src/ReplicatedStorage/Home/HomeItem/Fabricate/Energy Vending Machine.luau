-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKA25ldwxFbmVyZ3kgRHJpbmsFX21haWQIR2l2ZVRhc2sPX3ZlbmRpbmdNYWNoaW5lBXNldHVwB3JlcXVpcmUPX1ZlbmRpbmdNYWNoaW5lBnNjcmlwdAZQYXJlbnQAAgUBAQAAAA/7AQAATQEB7wAAAABSAgAAbwMBAJ8BAwJNAgDBAgAAAFIEAQC8AgL9AwAAAJ8CAwEwAQCDBAAAAIIAAQAFAwEDAgMDAwQDBQAEBgEYAAAAAAAAAQAAAAAAAQABBQAAAAADAAABAgARowAAAKQAAQAAAABApAIEAAAAMEBNAgIkBQAAAE0BAvsCAAAAnwACAv8BAQAAAAAAwAIGABIAAAAwAgH5BwAAAIIBAgAIAwcEAAAAQAMIAwkEAAAwQAMKBgADBgEAAQABGAAAAAAAAAAAAAACAAEAAAAFAQAAAAABJXz55DFbmrhQ/ZTOP1X8b1Vk7pAXuJPl

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:00
-- Luau version 6, Types version 3
-- Time taken: 0.000939 seconds

local module = {}
local _VendingMachine_upvr = require(script.Parent._VendingMachine)
function module.setup(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: _VendingMachine_upvr (readonly)
    ]]
    local any_new_result1 = _VendingMachine_upvr.new(arg1, "Energy Drink")
    arg1._maid:GiveTask(any_new_result1)
    arg1._vendingMachine = any_new_result1
end
return module