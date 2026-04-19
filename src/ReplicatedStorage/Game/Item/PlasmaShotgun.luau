-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBEluaXQDbmV3DHNldG1ldGF0YWJsZQVTZXR1cApTZXR1cE1vZGVsC09iamVjdExvY2FsA1RpcAZWb2x1bWUMVGltZVBvc2l0aW9uClNob290U291bmQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudANHdW4ER2FtZQRJdGVtCVBsYXNtYUd1bgNTdGQFQXVkaW8NUGxhc21hU2hvdGd1bgtfX0NsYXNzTmFtZQdfX2luZGV4AAUBAQAAAAABggABAAAACgEBGAAKAAAAAAcDAgAAABP7AwAATQMD7wAAAABSBAAAUgUBAFIGAgCfAwQC+wYBAJ49AwQGAAAAUgUDAKQEAgAAABBAnwQDAVIGAgC8BAOZAwAAAJ8EAwGCAwIABAMCAwMEAAAQQAMEAAsCARgAAAAAAAAAAQAAAAAAAAEAAAABDAAAAAADAQEAAAAG+wEAAE0BATwAAAAAUgIAAJ8BAgGCAAEAAQMFABEFARgAAAAAAAESAAAAAAcCAQAAABArAQ4A+wIAAE0CAtEAAAAATQMAsQEAAABvBAIA4gUFAG8GBgAwBgVLAwAAAG8GBwAwBgXGBAAAAJ8CBAGCAAEACAMGAwcCAAAwwtoAEEIDCAMJBQIDBAJmZmZmZmbWPwKamZmZmZmpPwAUCgEYAAEAAAAAAAABAAABAAD+BRUAAAAACAAAAQIAP6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQKQCBwAAAGBATQICJAgAAABNAgINCQAAAJ8BAgKkAgUAAABAQE0DAL0KAAAATQMDygsAAABNAwOgDAAAAJ8CAgKkAwUAAABAQE0EAKENAAAATQQE0g4AAACfAwIC/wQEAAAAAABvBQ8AMAUE5RAAAAAwBARuEQAAAJ49BAUCAAAAUgYEAFIHAgCkBRMAAAAgQZ8FAwHABRQAMAUEcxUAAADABRYAEgACABIABAAwBQTvFwAAAMAFGAASAAEAMAUEPBkAAADABRoAEgADADAFBLkbAAAAggQCABwDCwQAAABAAwwDDQMOBAAAQEADDwQAAGBAAxADEQMSAxMDFAMVAxYDFwMYAxkDAwQAACBBBgADAQYBAwIGAgMFBgMDCgQAAQIDAQABGAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAgABAAABAAEAAAAAAAABAAABAAAAAAYAAAADAAAACAEAAAAABKE1vg6d/fcz5dSI5aLoKmnRLal6k/HUDw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:27
-- Luau version 6, Types version 3
-- Time taken: 0.002111 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlasmaGun_upvr = require(ReplicatedStorage.Game.Item.PlasmaGun)
local module_upvr = {
    __ClassName = "PlasmaShotgun";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, PlasmaGun_upvr)
function module_upvr.Init(arg1) -- Line 10
end
function module_upvr.new(arg1, arg2, arg3) -- Line 11
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
function module_upvr.SetupModel(arg1) -- Line 17
    --[[ Upvalues[1]:
        [1]: Gun_upvr (readonly)
    ]]
    Gun_upvr.SetupModel(arg1)
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr.ShootSound(arg1, arg2) -- Line 20
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, 17183453324, {
            Volume = 0.35;
            TimePosition = 0.05;
        })
    end
end
return module_upvr