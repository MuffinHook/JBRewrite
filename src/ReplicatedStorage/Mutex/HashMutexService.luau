-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMIA25ldw9nZXRGb3JOYW1lc3BhY2UEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFTXV0ZXgJSGFzaE11dGV4AAIDAQIAAAAN+wIAAIcBAgAOAQMA+wIAAIcBAgCCAQIA+wEBAE0BAe8AAAAAnwEBAvsCAABqAQIAggECAAEDAQAGAgEYAAAAAQAAAgAAAAEAAQcAAAAABQAAAQIAGKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAJwGAAAATQIClAcAAACfAQIC/wIAAAAAAAD/AwEAAAAAAMAECAASAAIAEgABADAEA7gJAAAAggMCAAoDAwQAAABAAwQDBQMGBAAAQEADBwMIBgADAgEAAQABGAAAAAAAAAABAAAAAAAAAgABAAEAAAAACAEAAAAAAdn31VQ9EYoNSr7JKpTXmmWp78Ig6zO/VQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:12
-- Luau version 6, Types version 3
-- Time taken: 0.001060 seconds

local module = {}
local tbl_upvr = {}
local HashMutex_upvr = require(game:GetService("ReplicatedStorage").Mutex.HashMutex)
function module.getForNamespace(arg1) -- Line 6
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: HashMutex_upvr (readonly)
    ]]
    if tbl_upvr[arg1] then
        return tbl_upvr[arg1]
    end
    local any_new_result1 = HashMutex_upvr.new()
    tbl_upvr[arg1] = any_new_result1
    return any_new_result1
end
return module