-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWBGluaXQNY3JlYXRlRWxlbWVudAljcmVhdGVkQXQRYWx3YXlzU2hvd01pbnV0ZXMJY291bnREb3duCXdvcmtzcGFjZRBHZXRTZXJ2ZXJUaW1lTm93BnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUHRWxhcHNlZAZzY3JpcHQGUGFyZW50BW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAAGAQEAAAAAAYIAAQAAAAcBARgABwAAAAAHAQIAAAAV+wEAAE0BAcoAAAAA+wIBAOIDBACkBQcAAABgQLwFBbcIAAAAnwUCApUEBQUwBAOJAQAAAKkEAAAwBANaAgAAAKkEAQAwBAOvAwAAAJ8BAwCCAQAACQMCAwMDBAMFBQMBAgMCAAAAAAAANEADBgQAAGBAAwcACAgBGAAAAAAAAgAAAAAAAAABAAABAAD8AAkAAAAAAQEAAAAAAYIAAQAAABAJARgAEAAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMKABMAARgAAAAAAAEUAAAAAAYBAQAAACn7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQMEpAUAAACfAgICwAMJADADARMKAAAA2QMBABICAAASAAIAMAMBgAsAAADAAwwAMAMBNA0AAAD7AwAATQMD5A4AAAD7BAAATQQEyg8AAABSBQEAnwQCAlIFAACfAwMC2QQDABICAAASAAMAggQCABADCwMMAw0DDgQAADBAAw8DEAQAAGBAAxEGAAMBAwgGAgMJAxIDAgQAAQIDBAABGAAAAAAAAAABAAAAAAAAAAABAAABAAAAAAgAAAIAAAAAAAAAAAABAAAABQAAAAADAAABAgAPowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICwAIHABIAAQCCAgIACAMTBAAAAEADFAMVAw4EAABAQAMWBgQBBAEAARgAAAAAAAAAAQAAAAACAAABAAAAAAU4Mma1AP7dZ0jvdsc0TKGHSCpxwQr2DLQ=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:05
-- Luau version 6, Types version 3
-- Time taken: 0.001850 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local Elapsed_upvr = require(script.Parent.Elapsed)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: Elapsed_upvr (readonly)
        ]]
        return Roact_upvr.createElement(Elapsed_upvr, {
            createdAt = workspace:GetServerTimeNow() + 20;
            alwaysShowMinutes = false;
            countDown = true;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 16
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 19
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end