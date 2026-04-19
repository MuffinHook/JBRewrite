-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUCGNsaWNrICVkBmZvcm1hdAdvbkNsaWNrB3VubW91bnQNY3JlYXRlQmluZGluZw1oZWxsbywgd29ybGQhB3JlcXVpcmUKVGV4dEJ1dHRvbgZzY3JpcHQGUGFyZW50BW1vdW50DWNyZWF0ZUVsZW1lbnQEc2l6ZQhwb3NpdGlvbgR0ZXh0BVVEaW0yA25ldwRFelVpEUZpbmRGaXJzdEFuY2VzdG9yBVJvYWN0AAQHAwEAAAcAAAEDBAMCCPsDAABvBAAAUgYCALwEBI0BAAAAnwQDAJ8DAAGCAAEAAgMBAwIADgMBGAAAAAAAAAABDwAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMEABQAARgAAAAAAAEVAAAAAA0BAQAAADX7AQAATQEBMQAAAABvAgEAnwECA6QDAwAAACBApAUGAAAAUEBNBQUkBwAAAE0EBWwEAAAAnwMCAvsEAABNBATkCAAAAPsFAABNBQXKCQAAAFIGAwDiBw4ApAgRAABA8IBvCRIAjAoAAIwLAACMDB4AnwgFAjAIBw8KAAAApAgRAABA8IBvCRMAjAoAAG8LEgCMDAAAnwgFAjAIB9sLAAAAMAEH1QwAAADZCAAAEgACADAIB24NAAAAnwUDAlIGAACfBAMC2QUBABICAAASAAQAggUCABQDBQMGAwcEAAAgQAMIAwkEAABQQAMKAwsDDAMNAw4DDwMDBQQKCwwNAxADEQQAQPCAAgAAAAAAAOA/AgAAAAAAANA/AgABBQABGAAAAAAAAgAAAAAAAAAAAQAAAQAAAAABAAAAAAAAAAABAAAAAAAAAAABAAEAAAD8CPcLAAAABgAAAAADAAABAgARowAAAKQAAQAAAABAbwICALwAAHwDAAAAnwADAqQBBQAAAEBATQIAJAYAAABNAgIhBwAAAJ8BAgLAAggAEgABAIICAgAJAwkEAAAAQAMSAxMDBwQAAEBAAwoDFAYCAQIBAAEYAAEAAAAAAAEAAAAAAAACAAABAAAAAANqW7l9eNkBDxyJIM+7ZdnLGkOuCVif03w=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:54
-- Luau version 6, Types version 3
-- Time taken: 0.001328 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_createBinding_result1, any_createBinding_result2_upvr = Roact_upvr.createBinding("hello, world!")
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.TextButton), {
        size = UDim2.new(0.5, 0, 0, 30);
        position = UDim2.new(0.25, 0, 0.5, 0);
        text = any_createBinding_result1;
        onClick = function(arg1_2, arg2, arg3) -- Line 14, Named "onClick"
            --[[ Upvalues[1]:
                [1]: any_createBinding_result2_upvr (readonly)
            ]]
            any_createBinding_result2_upvr("click %d":format(arg3))
        end;
    }), arg1)
    return function() -- Line 20
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end