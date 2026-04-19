-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLDHNldG1ldGF0YWJsZQNvYmoDbmV3FmRvZXNJbnZlbnRvcnlWYWx1ZUhhdmUHSGFzSXRlbQdEZXN0cm95B3JlcXVpcmUOSW52ZW50b3J5VXRpbHMGc2NyaXB0BlBhcmVudAdfX2luZGV4AAQFAQEAAAAM/wEBAAAAAAD7BAAAnj0BBAQAAABSAwEApAIBAAAAAECfAgMBMAABEwIAAACCAQIAAwMBBAAAAEADAgAGAwEYAAABAAAAAAAAAgACBwAAAAAFAgEAAAAI+wIAAE0CAskAAAAATQMAEwEAAABSBAEAnwIDAIICAAACAwQDAgAOBQEYAAAAAAAAAAAPAAAAAAEBAAAAAAGCAAEAAAARBgEYABEAAAAAAwAAAQIAGqMAAACkAAEAAAAAQKQCBAAAADBATQICJAUAAABNAQK7AgAAAJ8AAgL/AQMAAAAAADABAW4GAAAAwAIHABIAAQAwAgHvCAAAAMACCQASAAAAMAIBTQoAAADAAgsAMAIBUAwAAACCAQIADQMHBAAAAEADCAMJBAAAMEADCgMLBgADAwYBAwUGAgMGAwABAgEAARgAAAAAAAAAAAAAAgABAAIAAAAIAAAAAwAAAgEAAAAAA6j3uWP8MIxtMSPAdNTrwjnY764XmjPTYg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:38
-- Luau version 6, Types version 3
-- Time taken: 0.001130 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 6
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_upvr)
    module.obj = arg1
    return module
end
local InventoryUtils_upvr = require(script.Parent.InventoryUtils)
function module_upvr.HasItem(arg1, arg2) -- Line 14
    --[[ Upvalues[1]:
        [1]: InventoryUtils_upvr (readonly)
    ]]
    return InventoryUtils_upvr.doesInventoryValueHave(arg1.obj, arg2)
end
function module_upvr.Destroy(arg1) -- Line 17
end
return module_upvr