-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYDHNldG1ldGF0YWJsZQNuZXcFX21haWQEX29iahFnZXRQbGFjZW1lbnRQcmlzbQZDRnJhbWUEU2l6ZRFHZXRQbGFjZW1lbnRQcmlzbRBnZXRTdGFuZGluZ1ByaXNtEEdldFN0YW5kaW5nUHJpc20GYXNzZXJ0B0Rlc3Ryb3kEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkBE1haWQMU3VyZmFjZVV0aWxzBnNjcmlwdAZQYXJlbnQHX19pbmRleAdTdXJmYWNlC19fQ2xhc3NOYW1lAAUFAQIAAAAS/wECAAAAAAD7BAAAnj0BBAQAAABSAwEApAIBAAAAAECfAgMB+wIBAE0CAu8CAAAAnwIBAjACAcEDAAAAMAABbgQAAACCAQIABQMBBAAAAEADAgMDAwQACQIBGAAAAQAAAAAAAAIAAAAAAAEAAgoAAAAABAEBAAAADfsBAABNAQHDAAAAAE0CAG4BAAAATQIChQIAAABNAwBuAQAAAE0DAy8DAAAAnwEDAIIBAAAEAwUDBAMGAwcAEggBGAAAAAAAAAAAAAAAAAATAAAAAAQBAQAAAA37AQAATQEBLQAAAABNAgBuAQAAAE0CAoUCAAAATQMAbgEAAABNAwMvAwAAAJ8BAwCCAQAABAMJAwQDBgMHABUKARgAAAAAAAAAAAAAAAAAFgAAAAAEAQAAAAARTQEAwQAAAABHAQIAAAAAgKkDAAGpAwEAuwEDAqQCAgAAABBAnwICAcYCAAAwAgDBAAAAALwCAVADAAAAnwICAYIAAQAEAwMDCwQAABBAAwwAGAwBGAAAAQAAAAAAAAABAAABAAABGQAAAAAFAAABAgAvowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJ2BwAAAJ8BAgKkAgUAAABAQKQECgAAAJBATQQEJAsAAABNAwQDCAAAAJ8CAgL/AwQAAAAAADADA24MAAAAbwQNADAEA+UOAAAAwAQPABIAAwASAAEAMAQD7xAAAADABBEAEgACADAEAyMSAAAAwAQTABIAAgAwBAMNFAAAAMAEFQAwBANQFgAAAIIDAgAXAw0EAAAAQAMOAw8DEAQAAEBAAxEDEgMTAxQEAACQQAMVAxYDFwMYBgADAgYBAwgGAgMKBgMDDAQAAQIDAQABGAAAAAAAAAABAAAAAAAAAgAAAAAAAAAAAgABAAEAAAEAAAAACQAAAAMAAAADAAAHAQAAAAAE3LVdNXdexnjQ0gqEOZRA2aytSkHucTc0

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:19
-- Luau version 6, Types version 3
-- Time taken: 0.002190 seconds

local SurfaceUtils_upvr = require(script.Parent.SurfaceUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.__ClassName = "Surface"
local Maid_upvr = require(game:GetService("ReplicatedStorage").Std.Maid)
function module_upvr.new(arg1) -- Line 9
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: Maid_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    module._obj = arg1
    return module
end
function module_upvr.GetPlacementPrism(arg1) -- Line 18
    --[[ Upvalues[1]:
        [1]: SurfaceUtils_upvr (readonly)
    ]]
    return SurfaceUtils_upvr.getPlacementPrism(arg1._obj.CFrame, arg1._obj.Size)
end
function module_upvr.GetStandingPrism(arg1) -- Line 21
    --[[ Upvalues[1]:
        [1]: SurfaceUtils_upvr (readonly)
    ]]
    return SurfaceUtils_upvr.getStandingPrism(arg1._obj.CFrame, arg1._obj.Size)
end
function module_upvr.Destroy(arg1) -- Line 24
    local _maid = arg1._maid
    local var6
    if _maid == nil then
        var6 = false
    else
        var6 = true
    end
    assert(var6)
    arg1._maid = nil
    _maid:Destroy()
end
return module_upvr