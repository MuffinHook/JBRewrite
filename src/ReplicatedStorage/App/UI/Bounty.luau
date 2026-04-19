-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMqBUZyYW1lFkJhY2tncm91bmRUcmFuc3BhcmVuY3kEU2l6ZQtMYXlvdXRPcmRlcgdWaXNpYmxlBXByb3BzBHNpemUMZGlzcGxheU9yZGVyB2VuYWJsZWQLQXNwZWN0UmF0aW8FTGFiZWwXVUlBc3BlY3RSYXRpb0NvbnN0cmFpbnQJVGV4dExhYmVsBEZvbnQEVGV4dApUZXh0Q29sb3IzEFRleHRTdHJva2VDb2xvcjMWVGV4dFN0cm9rZVRyYW5zcGFyZW5jeQhQb3NpdGlvbgpUZXh0U2NhbGVkBEVudW0LTHVja2llc3RHdXkKQm91bnR5OiAlcwhDdXJyZW5jeQZhbW91bnQGZm9ybWF0BkNvbG9yMwNuZXcFVURpbTIGcmVuZGVyBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvYWN0DWNyZWF0ZUVsZW1lbnQGRm9ybWF0Bk1vZHVsZQ1QdXJlQ29tcG9uZW50BkJvdW50eQZleHRlbmQMZGVmYXVsdFByb3BzAAINAQIAAAcAAAEDCDUCZ/sBAABvAgAA4gMFAIwEAQAwBAM6AQAAAE0EAAcGAAAATQQEDwcAAAAwBAMvAgAAAE0EAAcGAAAATQQE6wgAAAAwBAMAAwAAAE0EAAcGAAAATQQEkAkAAAAwBAOABAAAAOIEDAD7BQAAbwYNAOIHDgCMCAgAMAgHaQoAAACfBQMCMAUEaQoAAAD7BQAAbwYPAOIHFwCMCAEAMAgHOgEAAACkCBoAGUCAwTAIBzkQAAAAbwgbAPsKAQBNCgoJHAAAAE0LAAcGAAAATQsLCx0AAACfCgIAvAgIjR4AAACfCAACMAgH9REAAACkCCEAAIDwgW8JIgCMCgAAjAsAAJ8IBAIwCAdzEgAAAKQIIQAAgPCBbwkjAIwKAACMCwAAnwgEAjAIB6QTAAAAbwgkADAIB0cUAAAApAgmAACAUIKMCQEAjAoAAIwLAQCMDAAAnwgFAjAIBy8CAAAApAgmAACAUIKMCQAAjAoAAG8LJwCMDAAAnwgFAjAIBzsVAAAAqQgBADAIB94WAAAAnwUDAjAFBMMLAAAAnwEEAIIBAAAoAwEDAgMDAwQDBQUEAQIDBAMGAwcDCAMJAwoDCwUCCgsDDAUBCgMNAw4DDwMQAxEDEgMTAxQFCQEQERITFAIVFgMVAxYEGUCAwQMXAxgDGQMaAxsDHAQAgPCBApqZmZmZmek/AjMzMzMzM9M/AgAAAAAAAOA/Ax0EAIBQggIzMzMzMzPDPwALHgEYAAAAAQAAAQAAAAAAAQAAAAAAAQAAAAAAAQEAAAEAAP8AAAMAAAEAAAEAAAABAAAAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAAABAAAAAAAAAAABAAAAAAAAAAABAAD3AAD3AAwAAAAACwAAAQIALaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAk0CAcoHAAAApAMFAAAAQEBNBQBACQAAAE0EBa0IAAAAnwMCAk0EAfgKAAAAbwYLALwEBJwMAAAAnwQDAuIFDgCkBhEAAEDwgIwHAQCMCAAAjAkBAIwKAACfBgUCMAYFDw0AAAAwBQSSEgAAAMAFEwASAAIAEgADADAFBIAUAAAAggQCABUDHwQAAABAAyADIQMiBAAAQEADIwMkAyUDJgMnAygDKQMHBQENAx0DHAQAQPCAAyoGAAMeAQABAAEYAAAAAAAAAAEAAAAAAQACAAAAAAAAAgAAAAAAAQEAAAAAAAAAAP8AAwAAAAAXAQAAAAABPQ8uo0PJft3f3Fg/JVaeLk0XOdcPy0Si

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:41
-- Luau version 6, Types version 3
-- Time taken: 0.002403 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Bounty")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
}
local createElement_upvr = Roact.createElement
local Format_upvr = require(ReplicatedStorage.Module.Format)
function any_extend_result1.render(arg1) -- Line 11
    --[[ Upvalues[2]:
        [1]: createElement_upvr (readonly)
        [2]: Format_upvr (readonly)
    ]]
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        LayoutOrder = arg1.props.displayOrder;
        Visible = arg1.props.enabled;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 8;
        });
        Label = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Font = Enum.Font.LuckiestGuy;
            Text = "Bounty: %s":format(Format_upvr.Currency(arg1.props.amount));
            TextColor3 = Color3.new(0.8, 0, 0);
            TextStrokeColor3 = Color3.new(0.3, 0, 0);
            TextStrokeTransparency = 0.5;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0, 0, 0.15, 0);
            TextScaled = true;
        });
    })
end
return any_extend_result1