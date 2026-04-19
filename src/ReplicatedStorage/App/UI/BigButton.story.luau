-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBGluaXQNY3JlYXRlRWxlbWVudAVjb3VudAdpbWFnZUlkBnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUJQmlnQnV0dG9uBnNjcmlwdAZQYXJlbnQFbW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0AAYBAQAAAAABggABAAAABwEBGAAHAAAAAAUBAgAAAA37AQAATQEBygAAAAD7AgEA4gMDAIwEAwAwBAMaAQAAAG8EBAAwBAO2AgAAAJ8BAwCCAQAABQMCAwMDBAUCAQICAAAAM6tM8kEACAUBGAAAAAAAAQAAAQAA/gAJAAAAAAEBAAAAAAGCAAEAAAAOBgEYAA4AAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDBwARAAEYAAAAAAABEgAAAAAGAQEAAAAp+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBApAQHAAAAYEBNBAQkCAAAAE0DBG0FAAAAnwICAsADCQAwAwETCgAAANkDAQASAgAAEgACADADAYALAAAAwAMMADADATQNAAAA+wMAAE0DA+QOAAAA+wQAAE0EBMoPAAAAUgUBAJ8EAgJSBQAAnwMDAtkEAwASAgAAEgADAIIEAgAQAwgDCQMKAwsEAAAwQAMMAw0EAABgQAMOBgADAQMFBgIDBgMPAwIEAAECAwQAARgAAAAAAAAAAQAAAAAAAAAAAQAAAQAAAAAGAAACAAAAAAAAAAAAAQAAAAUAAAAAAwAAAQIAD6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAsACBwASAAEAggICAAgDEAQAAABAAxEDEgMLBAAAQEADEwYEAQQBAAEYAAAAAAAAAAEAAAAAAgAAAQAAAAAFraEipcYxM1swrRKK/1We2925NdGfZUik

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:38
-- Luau version 6, Types version 3
-- Time taken: 0.001538 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local BigButton_upvr = require(script.Parent.BigButton)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: BigButton_upvr (readonly)
        ]]
        return Roact_upvr.createElement(BigButton_upvr, {
            count = 3;
            imageId = 4912231216;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 14
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 17
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end