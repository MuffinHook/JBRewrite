-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLB3VubW91bnQFbW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudBBTcGVjdGF0ZVNlbGVjdG9yBVJvYWN0DWNyZWF0ZUVsZW1lbnQAAwIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAwEACAABGAAAAAAAAQkAAAAABQEDAAAADvsBAABNAQHkAAAAAPsCAQD7AwIA/wQAAAAAAACfAgMCUgMAAJ8BAwLZAgAAEgIAABIAAQCCAgIAAQMCAQAGAAEYAAAAAAAAAAAAAAEAAAAHAAAAAAUAAAECAByjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQICEgkAAACfAQICpAIFAAAAQEBNAwAhCgAAAJ8CAgJNAwLKCwAAAMAEDAASAAIAEgADABIAAQCCBAIADQMDBAAAAEADBAMFAwYEAABAQAMHBAAAYEADCAMJAwoDCwYBAQEBAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAQACAAAAAAEAAAAAAnfvXG/4n4+EJ6fm9UxqhmwH90sbRSs2bg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:46:05
-- Luau version 6, Types version 3
-- Time taken: 0.000853 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
local SpectateSelector_upvr = require(script.Parent.SpectateSelector)
return function(arg1) -- Line 6
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
        [3]: SpectateSelector_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr(SpectateSelector_upvr, {}), arg1)
    return function() -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end