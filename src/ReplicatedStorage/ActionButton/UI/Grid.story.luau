-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMbCmNvdW50SW5uZXIKY291bnRPdXRlcghzZXRTdGF0ZQRpbml0DWNyZWF0ZUVsZW1lbnQIcG9zaXRpb24LYW5jaG9yUG9pbnQEc2l6ZQVVRGltMgNuZXcHVmVjdG9yMgVzdGF0ZQZyZW5kZXILd2lsbFVubW91bnQHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlBEdyaWQGc2NyaXB0BlBhcmVudAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QABgUBAAAAAAviAwIAjAQDADAEAzkAAAAAjAQEADAEAx8BAAAAvAEAKgMAAACfAQMBggABAAQDAQMCBQIAAQMDAAcEARgAAQAAAQAA/gAABAgAAAAACQECAAAALPsBAABNAQHKAAAAAPsCAQDiAwYApAQJAAAgcICMBQEAjAYAAIwHAQCMCAAAnwQFAjAEA9sBAAAApAQLAAAgoICMBQEAjAYBAJ8EAwIwBAMIAgAAAKQECQAAIHCAbwUMAIwGAABvBw0AjAgAAJ8EBQIwBAMPAwAAAE0EABgOAAAATQQEOQQAAAAwBAM5BAAAAE0EABgOAAAATQQEHwUAAAAwBAMfBQAAAJ8BAwCCAQAADwMFAwYDBwMIAwEDAgUFAQIDBAUDCQMKBAAgcIADCwQAIKCAApqZmZmZmck/AgAAAAAAAOA/AwwADQ0BGAAAAAAAAQAAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAEAAAAAAAEAAAAAAPsADgAAAAABAQAAAAABggABAAAAFg4BGAAWAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAw8AGQABGAAAAAAAARoAAAAABgEBAAAAKfsBAABNAQGIAAAAAG8DAQC8AQGcAgAAAJ8BAwKkAgQAAAAwQKQEBwAAAGBATQQEJAgAAABNAwQHBQAAAJ8CAgLAAwkAMAMBEwoAAADZAwEAEgIAABIAAgAwAwGACwAAAMADDAAwAwE0DQAAAPsDAABNAwPkDgAAAPsEAABNBATKDwAAAFIFAQCfBAICUgUAAJ8DAwLZBAMAEgIAABIAAwCCBAIAEAMQAxEDEgMTBAAAMEADFAMVBAAAYEADFgYAAwQDDQYCAw4DFwMFBAABAgMEAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAYAAAAACQAAAgAAAAAAAAAAAAEAAAAFAAAAAAMAAAECAA+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAhBgAAAJ8BAgLAAgcAEgABAIICAgAIAxgEAAAAQAMZAxoDEwQAAEBAAxsGBAEEAQABGAAAAAAAAAABAAAAAAIAAAEAAAAABdyHjZ3lET39aTvMGqKYrdCsn5rp7kPnnA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:58
-- Luau version 6, Types version 3
-- Time taken: 0.001722 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
        arg1_2:setState({
            countInner = 3;
            countOuter = 4;
        })
    end
    local Grid_upvr = require(script.Parent.Grid)
    function any_extend_result1.render(arg1_3) -- Line 13
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: Grid_upvr (readonly)
        ]]
        return Roact_upvr.createElement(Grid_upvr, {
            position = UDim2.new(1, 0, 1, 0);
            anchorPoint = Vector2.new(1, 1);
            size = UDim2.new(0.2, 0, 0.5, 0);
            countInner = arg1_3.state.countInner;
            countOuter = arg1_3.state.countOuter;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 22
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 25
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end