-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBXByaW50BDAwMDAIb25TdWJtaXQHdW5tb3VudAdyZXF1aXJlBktleXBhZAZzY3JpcHQGUGFyZW50BW1vdW50DWNyZWF0ZUVsZW1lbnQEc2l6ZQhwb3NpdGlvbgVVRGltMgNuZXcEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0AAQEAQAAAAAJpAEBAAAAAEBSAgAA8AACAAIAAACpAwABqQMBAJ8BAwGCAAEAAwMBBAAAAEADAgAKAwEYAAAAAAAAAAABCwAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMEABAAARgAAAAAAAERAAAAAAsBAQAAAC2kAQEAAAAAQKQDBAAAADBATQMDJAUAAABNAgNhAgAAAJ8BAgL7AgAATQIC5AYAAAD7AwAATQMDygcAAABSBAEA4gULAKQGDgAANMCAbwcPAIwIAABvCQ8AjAoAAJ8GBQIwBgUPCAAAAKQGDgAANMCAbwcQAIwIAABvCRAAjAoAAJ8GBQIwBgXbCQAAAMAGEQAwBgUGCgAAAJ8DAwJSBAAAnwIDAtkDAQASAgAAEgACAIIDAgASAwUEAAAAQAMGAwcEAAAwQAMIAwkDCgMLAwwDAwUDCAkKAw0DDgQANMCAAs3MzMzMzOw/AgAAAAAAAOA/BgACAAEEAAEYAAAAAAAAAAAAAQAAAQAAAAABAAAAAAAAAAABAAAAAAAAAAABAAD9B/gKAAAABQAAAAADAAABAgAPowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICwAIHABIAAQCCAgIACAMPBAAAAEADEAMRAwUEAABAQAMSBgIBAgEAARgAAAAAAAAAAQAAAAACAAABAAAAAAN4AdDZDSaQw01FHNdyr7yuCBnHrUrFutg=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:44
-- Luau version 6, Types version 3
-- Time taken: 0.001860 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Keypad), {
        size = UDim2.new(0.9, 0, 0.9, 0);
        position = UDim2.new(0.5, 0, 0.5, 0);
        onSubmit = function(arg1_2) -- Line 10, Named "onSubmit"
            local var4
            if arg1_2 ~= "0000" then
                var4 = false
            else
                var4 = true
            end
            print(arg1_2, var4)
        end;
    }), arg1)
    return function() -- Line 16
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end