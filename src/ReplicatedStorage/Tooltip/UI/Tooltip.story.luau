-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVB3Zpc2libGUIc2V0U3RhdGUEaW5pdAR0ZXh0BW5vaWNlBnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUHVG9vbHRpcAZzY3JpcHQGUGFyZW50BW1vdW50DWNyZWF0ZUVsZW1lbnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0AAYFAQAAAAAI4gMBAKkEAQAwBAOgAAAAALwBACoCAAAAnwEDAYIAAQADAwEFAQADAgAIAwEYAAEAAP8AAAMJAAAAAAUBAgAAAAj7AQAA+wIBAOIDAQBvBAIAMAQD1QAAAACfAQMAggEAAAMDBAUBAAMFAA0GARgAAAABAAD/AA4AAAAAAQEAAAAAAYIAAQAAABIHARgAEgAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMIABUAARgAAAAAAAEWAAAAAAYBAgAAACn7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQMEdQUAAACfAgICwAMJADADARMKAAAA2QMBABICAQASAAIAMAMBgAsAAADAAwwAMAMBNA0AAAD7AwAATQMD5A4AAAD7BAAATQQEyg8AAABSBQEAnwQCAlIFAACfAwMC2QQDABICAAASAAMAggQCABADCQMKAwsDDAQAADBAAw0DDgQAAGBAAw8GAAMDAwYGAgMHAxADEQQAAQIDBQABGAAAAAAAAAABAAAAAAAAAAABAAAFAAAAAAUAAAIAAAAAAAAAAAABAAAABgAAAAAEAAABAgASowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICTQIBygcAAADAAwgAEgABABIAAgCCAwIACQMSBAAAAEADEwMUAwwEAABAQAMVAxEGBAEEAQABGAAAAAAAAAABAAAAAAEAAgAAAAEAAAAABdfXoF5+d3fVbH0dzENOgrSnz7cq5RPKXw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:05
-- Luau version 6, Types version 3
-- Time taken: 0.001612 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
        arg1_2:setState({
            visible = true;
        })
    end
    local Tooltip_upvr = require(script.Parent.Tooltip)
    function any_extend_result1.render(arg1_3) -- Line 13
        --[[ Upvalues[2]:
            [1]: createElement_upvr (copied, readonly)
            [2]: Tooltip_upvr (readonly)
        ]]
        return createElement_upvr(Tooltip_upvr, {
            text = "noice";
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 18
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 21
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end