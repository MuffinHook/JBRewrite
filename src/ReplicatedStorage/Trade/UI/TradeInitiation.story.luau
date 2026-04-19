-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBGluaXQNY3JlYXRlRWxlbWVudARuYW1lBWJhZGNjBnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUPVHJhZGVJbml0aWF0aW9uBnNjcmlwdAZQYXJlbnQFbW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0AAYBAQAAAAABggABAAAABwEBGAAHAAAAAAUBAgAAAAr7AQAATQEBygAAAAD7AgEA4gMCAG8EAwAwBANaAQAAAJ8BAwCCAQAABAMCAwMFAQEDBAAIBQEYAAAAAAABAAD/AAkAAAAAAQEAAAAAAYIAAQAAAA0GARgADQAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMHABAAARgAAAAAAAERAAAAAAYBAQAAACn7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQME/QUAAACfAgICwAMJADADARMKAAAA2QMBABICAAASAAIAMAMBgAsAAADAAwwAMAMBNA0AAAD7AwAATQMD5A4AAAD7BAAATQQEyg8AAABSBQEAnwQCAlIFAACfAwMC2QQDABICAAASAAMAggQCABADCAMJAwoDCwQAADBAAwwDDQQAAGBAAw4GAAMBAwUGAgMGAw8DAgQAAQIDBAABGAAAAAAAAAABAAAAAAAAAAABAAABAAAAAAUAAAIAAAAAAAAAAAABAAAABQAAAAADAAABAgAPowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICwAIHABIAAQCCAgIACAMQBAAAAEADEQMSAwsEAABAQAMTBgQBBAEAARgAAAAAAAAAAQAAAAACAAABAAAAAAWC2GGrwKD8hLgnY1G3ewPj8sB237AcC6o=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:41
-- Luau version 6, Types version 3
-- Time taken: 0.001413 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local TradeInitiation_upvr = require(script.Parent.TradeInitiation)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: TradeInitiation_upvr (readonly)
        ]]
        return Roact_upvr.createElement(TradeInitiation_upvr, {
            name = "badcc";
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 13
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 16
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end