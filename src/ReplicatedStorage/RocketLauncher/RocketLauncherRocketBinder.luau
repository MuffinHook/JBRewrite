-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcCWV4cGxvZGVBdApvbkV4cGxvZGVkB0Nvbm5lY3QDbmV3DHNldG1ldGF0YWJsZQNvYmoIVEFHX05BTUUGSGFzVGFnF011c3QgYmUgc2Vla2luZyBtaXNzaWxlBmFzc2VydAdQcm9taXNlB2FuZFRoZW4EZ2FtZRFDb2xsZWN0aW9uU2VydmljZQpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUOUm9ja2V0TGF1bmNoZXIUUm9ja2V0TGF1bmNoZXJDb25zdHMTUm9ja2V0TGF1bmNoZXJVdGlscw5TZWVraW5nTWlzc2lsZRRTZWVraW5nTWlzc2lsZUJpbmRlchRTZWVraW5nTWlzc2lsZUNvbnN0cwNTdGQKQmFzZU9iamVjdAZCaW5kZXIHX19pbmRleA9ST0NLRVRfVEFHX05BTUUABAMBAQAAAAb7AQAATQEBGAAAAABSAgAAnwECAYIAAQABAwEAFAABGAAAAAAAARUAAAAABAEBAAAACE0BALUAAAAAwAMBABICAAC8AQHHAgAAAJ8BAwGCAAEAAwMCBgADAwEAEwABGAAAAAAAAAADFAAAAAAHAQYAAAAn+wEAAE0BAe8AAAAAUgIAAJ8BAgL7BAEAnj0BBAQAAABSAwEApAICAAAAEECfAgMB+wMCAE0FARMDAAAA+wYDAE0GBrQEAAAAvAMD3gUAAACfAwQCgQEDBAYAAABvBAYApAIIAAAAcECfAgMB+wIEAE0EARMDAAAAvAICcgkAAACfAgMCwAQKABICBQC8AgK1CwAAAJ8CAwGCAQIADAMEAwUEAAAQQAMGAwcDCAMJAwoEAABwQAMLBgEDDAEBDgQBGAAAAAAAAQAAAAAAAAEAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAABg8AAAAADAAAAQIAUqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAdMHAAAATQMDDggAAACfAgICpAMGAAAAUEBNBAHTBwAAAE0EBMUJAAAAnwMCAqQEBgAAAFBATQUBpgoAAABNBQVWCwAAAJ8EAgKkBQYAAABQQE0GAaYKAAAATQYG3gwAAACfBQICpAYGAAAAUEBNBwGhDQAAAE0HB0sOAAAAnwYCAqQHBgAAAFBATQgBoQ0AAABNCAh/DwAAAJ8HAgL/CAIAAAAAADAICG4QAAAAnj0IBQYAAABSCggAUgsGAKQJEgAAABBBnwkDAcAJEwASAAYAEgAIABIAAAASAAUAEgAEABIAAwAwCQjvFAAAAE0JB+8UAAAATQoCpBUAAABSCwgAnwkDAIIJAAAWAw0EAAAAQAMOAw8DEAMRBAAAUEADEgMTAxQDFQMWAxcDGAMZAxoDGwMFBAAAEEEGAgMEAxwBAgEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAgABAAEAAAAAAAACAAAAAAAAAAAOAAAAAAAAAQAAAAADO2V4tnl5OlVhwys54NOA7Ut9b8IJoRK3

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:34
-- Luau version 6, Types version 3
-- Time taken: 0.002088 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local CollectionService_upvr = game:GetService("CollectionService")
local SeekingMissileConsts_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileConsts)
local SeekingMissileBinder_upvr = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local RocketLauncherUtils_upvr = require(ReplicatedStorage.RocketLauncher.RocketLauncherUtils)
function module_upvr.new(arg1) -- Line 14
    --[[ Upvalues[6]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: CollectionService_upvr (readonly)
        [4]: SeekingMissileConsts_upvr (readonly)
        [5]: SeekingMissileBinder_upvr (readonly)
        [6]: RocketLauncherUtils_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    assert(CollectionService_upvr:HasTag(any_new_result1.obj, SeekingMissileConsts_upvr.TAG_NAME), "Must be seeking missile")
    SeekingMissileBinder_upvr:Promise(any_new_result1.obj):andThen(function(arg1_2) -- Line 19
        --[[ Upvalues[1]:
            [1]: RocketLauncherUtils_upvr (copied, readonly)
        ]]
        arg1_2.onExploded:Connect(function(arg1_3) -- Line 20
            --[[ Upvalues[1]:
                [1]: RocketLauncherUtils_upvr (copied, readonly)
            ]]
            RocketLauncherUtils_upvr.explodeAt(arg1_3)
        end)
    end)
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new(require(ReplicatedStorage.RocketLauncher.RocketLauncherConsts).ROCKET_TAG_NAME, module_upvr)