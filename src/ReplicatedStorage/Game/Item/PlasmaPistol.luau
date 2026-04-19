-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBEluaXQDbmV3DHNldG1ldGF0YWJsZQVTZXR1cApTZXR1cE1vZGVsBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQDR3VuBEdhbWUESXRlbQlQbGFzbWFHdW4MUGxhc21hUGlzdG9sC19fQ2xhc3NOYW1lB19faW5kZXgABAEBAAAAAAGCAAEAAAAJAQEYAAkAAAAABwMCAAAAE/sDAABNAwPvAAAAAFIEAABSBQEAUgYCAJ8DBAL7BgEAnj0DBAYAAABSBQMApAQCAAAAEECfBAMBUgYCALwEA5kDAAAAnwQDAYIDAgAEAwIDAwQAABBAAwQACgIBGAAAAAAAAAABAAAAAAAAAQAAAAELAAAAAAMBAQAAAAb7AQAATQEBPAAAAABSAgAAnwECAYIAAQABAwUAEAUBGAAAAAAAAREAAAAABwAAAQIANKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQKQCBwAAAGBATQICJAgAAABNAgINCQAAAJ8BAgKkAgUAAABAQE0DAL0KAAAATQMDygsAAABNAwOgDAAAAJ8CAgL/AwQAAAAAAG8EDQAwBAPlDgAAADADA24PAAAAnj0DBQIAAABSBQMAUgYCAKQEEQAAAABBnwQDAcAEEgAwBANzEwAAAMAEFAASAAIAEgADADAEA+8VAAAAwAQWABIAAQAwBAM8FwAAAIIDAgAYAwYEAAAAQAMHAwgDCQQAAEBAAwoEAABgQAMLAwwDDQMOAw8DEAMRAxIDAwQAAABBBgADAQYBAwIGAgMFAwABAgEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAgABAAABAAEAAAAAAAABAAABAAAAAAYAAAADAQAAAAADwJ1Ev4SZGrdReCd9E37pFLCFU8vyWS6+

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:27
-- Luau version 6, Types version 3
-- Time taken: 0.001410 seconds

local PlasmaGun_upvr = require(game:GetService("ReplicatedStorage").Game.Item.PlasmaGun)
local module_upvr = {
    __ClassName = "PlasmaPistol";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, PlasmaGun_upvr)
function module_upvr.Init(arg1) -- Line 9
end
function module_upvr.new(arg1, arg2, arg3) -- Line 10
    --[[ Upvalues[2]:
        [1]: PlasmaGun_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    local any_new_result1 = PlasmaGun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
local Gun_upvr = require(script.Parent.Gun)
function module_upvr.SetupModel(arg1) -- Line 16
    --[[ Upvalues[1]:
        [1]: Gun_upvr (readonly)
    ]]
    Gun_upvr.SetupModel(arg1)
end
return module_upvr