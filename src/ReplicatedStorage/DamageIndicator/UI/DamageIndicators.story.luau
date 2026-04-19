-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVB3VubW91bnQHcmVxdWlyZQZzY3JpcHQGUGFyZW50FkRhbWFnZUluZGljYXRvclNlcnZpY2UDYWRkDXdvcmxkUG9zaXRpb24IbGlmZXRpbWUFY29sb3IIc3RyZW5ndGgGQ29sb3IzA25ldxBEYW1hZ2VJbmRpY2F0b3JzBW1vdW50DWNyZWF0ZUVsZW1lbnQEc2l6ZQVVRGltMgRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QAAwIABAAAAA77AAAADgACAPsAAACfAAEB+wABAA4AAgD7AAEAnwABAfsAAgBNAAASAAAAAPsBAwCfAAIBggABAAEDAQAXAAEYAAABAAIAAQACAAAAAAEYAAAAAA4BAQAAAE2kAQEAAAAAQKQCAwAAACBATQICJAQAAABNAgIkBAAAAE0CAuMFAAAAnwECAk0CAb8GAAAA4gMJAG8ECgAwBAOABwAAAIwEHgAwBAPrCAAAAJ8CAgJNAwG/BgAAAOIEDQBvBQ4AMAUEgAcAAACkBREAAEDwgIwGAQCMBwEAjAgAAJ8FBAIwBQRECwAAAG8FEgAwBQT2DAAAAIwFHgAwBQTrCAAAAJ8DAgKkBAEAAAAAQKQFAwAAACBATQUFJAQAAABNBQU1EwAAAJ8EAgL7BQAATQUF5BQAAAD7BgAATQYGyhUAAABSBwQA4ggXAKQJGQAAQICBbwoaAIwLAABvDBoAjA0AAJ8JBQIwCQgPFgAAAJ8GAwJSBwAAnwUDAtkGAAASAAIAEgADABICAAASAAUAggYCABsDAgQAAABAAwMEAAAgQAMEAwUDBgMHAwgFAgcIBwAAAAAAAAAAAAAAAAAAAAADCQMKBQQHCwwIBwAAyEIAAAAAAADIQgAAAAADCwMMBABA8IACmpmZmZmZuT8DDQMOAw8DEAUBFgMRBABAgIECZmZmZmZm7j8BAAQAARgAAAAAAAAAAAAAAAEAAAEAAAEAAP4EAAABAAABAAAAAAAAAAEAAAEAAPwGAAAAAAAAAAABAAABAAAAAAEAAAAAAAAAAP8D/AYAAAAAAAUAAAAAAwAAAQIAD6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAsACBwASAAEAggICAAgDEgQAAABAAxMDFAMCBAAAQEADFQYBAQEBAAEYAAAAAAAAAAEAAAAAAgAAAQAAAAACcJ4dJ3iIH0ZCBv6LYAfUaQCGClNCWncm

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:21
-- Luau version 6, Types version 3
-- Time taken: 0.001411 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local DamageIndicatorService = require(script.Parent.Parent.DamageIndicatorService)
    local any_add_result1_upvr = DamageIndicatorService.add({
        worldPosition = Vector3.new(0, 0, 0);
        lifetime = 30;
    })
    local any_add_result1_upvr_2 = DamageIndicatorService.add({
        worldPosition = Vector3.new(100, 0, 100);
        color = Color3.new(1, 1, 0);
        strength = 0.1;
        lifetime = 30;
    })
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.DamageIndicators), {
        size = UDim2.new(0.95, 0, 0.95, 0);
    }), arg1)
    return function() -- Line 23
        --[[ Upvalues[4]:
            [1]: any_add_result1_upvr (readonly)
            [2]: any_add_result1_upvr_2 (readonly)
            [3]: Roact_upvr (copied, readonly)
            [4]: any_mount_result1_upvr (readonly)
        ]]
        if any_add_result1_upvr then
            any_add_result1_upvr()
        end
        if any_add_result1_upvr_2 then
            any_add_result1_upvr_2()
        end
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end