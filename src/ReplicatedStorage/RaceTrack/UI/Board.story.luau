-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLB3VubW91bnQHcmVxdWlyZQVCb2FyZAZzY3JpcHQGUGFyZW50BW1vdW50DWNyZWF0ZUVsZW1lbnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0AAMCAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMBAAcAARgAAAAAAAEIAAAAAAYBAQAAABmkAQEAAAAAQKQDBAAAADBATQMDJAUAAABNAgPzAgAAAJ8BAgL7AgAATQIC5AYAAAD7AwAATQMDygcAAABSBAEA/wUAAAAAAACfAwMCUgQAAJ8CAwLZAwAAEgIAABIAAgCCAwIACAMCBAAAAEADAwMEBAAAMEADBQMGAwcBAAQAARgAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAABQAAAAADAAABAgAPowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICwAIHABIAAQCCAgIACAMIBAAAAEADCQMKAwIEAABAQAMLBgEBAQEAARgAAAAAAAAAAQAAAAACAAABAAAAAAIA/+72pV+IvTlmKceMdakvcOf5gjI7hPc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:18
-- Luau version 6, Types version 3
-- Time taken: 0.001111 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Board), {}), arg1)
    return function() -- Line 7
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end