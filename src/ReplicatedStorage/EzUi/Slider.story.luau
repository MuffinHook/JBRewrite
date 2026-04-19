-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYAiVkBmZvcm1hdAd1bm1vdW50DWNyZWF0ZUJpbmRpbmcHcmVxdWlyZQZTbGlkZXIGc2NyaXB0BlBhcmVudAVtb3VudA1jcmVhdGVFbGVtZW50BHNpemUIcG9zaXRpb24DbWluA21heARzdGVwBXZhbHVlC3VwZGF0ZVZhbHVlBHRleHQFVURpbTIDbmV3A21hcARFelVpEUZpbmRGaXJzdEFuY2VzdG9yBVJvYWN0AAQGAQAAAAcAAAEDAQUCCW8BAAD1BQIAWwQFAVsFAANDAwQFvAEBjQQAAACfAQMAggEAAAUDAQIAAAAAAAAAAAIAAAAAAADwPwIAAAAAAABJQAMCABQAARgAAAAAAAAAAAAVAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAwMAGgABGAAAAAAAARsAAAAADQEBAAAAQvsBAABNAQExAAAAAIwCAACfAQIDpAMCAAAAEECkBQUAAABAQE0FBSQGAAAATQQFfwMAAACfAwIC+wQAAE0EBOQHAAAA+wUAAE0FBcoIAAAAUgYDAOIHEQCkCBQAAEwggW8JFQCMCgAAjAsAAIwMHgCfCAUCMAgHDwkAAACkCBQAAEwggW8JFgCMCgAAbwsVAIwMAACfCAUCMAgH2woAAACMCAAAMAgHuAsAAACMCDIAMAgHlAwAAACMCAEAMAgHhg0AAAAwAQfMDgAAADACBy0PAAAAwAoXALwIAZAYAAAAnwgDAjAIB9UQAAAAnwUDAlIGAACfBAMC2QUBABICAAASAAQAggUCABkDBAMFBAAAEEADBgMHBAAAQEADCAMJAwoDCwMMAw0DDgMPAxADEQMSBQgJCgsMDQ4PEAMTAxQEAEwggQIAAAAAAADgPwIAAAAAAADQPwYAAxUCAAEFAAEYAAAAAAAEAAAAAAAAAAABAAABAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAEAAAEAAAEAAAEAAQABAAAAAAD4DPMPAAAABgAAAAADAAABAgARowAAAKQAAQAAAABAbwICALwAAHwDAAAAnwADAqQBBQAAAEBATQIAJAYAAABNAgIhBwAAAJ8BAgLAAggAEgABAIICAgAJAwcEAAAAQAMWAxcDBQQAAEBAAwgDGAYCAQIBAAEYAAEAAAAAAAEAAAAAAAACAAABAAAAAAOeysajTVI3wkCZY1BmV9kS7tLR16wOrKI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:49
-- Luau version 6, Types version 3
-- Time taken: 0.001448 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0)
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Slider), {
        size = UDim2.new(0.5, 0, 0, 30);
        position = UDim2.new(0.25, 0, 0.5, 0);
        min = 0;
        max = 50;
        step = 1;
        value = any_createBinding_result1;
        updateValue = any_createBinding_result2;
        text = any_createBinding_result1:map(function(arg1_2) -- Line 20
            return "%d":format((1 - arg1_2) * 0 + arg1_2 * 50)
        end);
    }), arg1)
    return function() -- Line 26
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end