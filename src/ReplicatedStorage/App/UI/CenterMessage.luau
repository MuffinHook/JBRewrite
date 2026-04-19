-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMmBGluaXQFRnJhbWUWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQRTaXplCFBvc2l0aW9uC0FuY2hvclBvaW50B1Zpc2libGUFVURpbTIDbmV3B1ZlY3RvcjIFcHJvcHMEdGV4dANtYXALQXNwZWN0UmF0aW8EVGltZRdVSUFzcGVjdFJhdGlvQ29uc3RyYWludAlUZXh0TGFiZWwERm9udApUZXh0U2NhbGVkClRleHRDb2xvcjMQVGV4dFN0cm9rZUNvbG9yMxZUZXh0U3Ryb2tlVHJhbnNwYXJlbmN5BFRleHQERW51bQtMdWNraWVzdEd1eQZDb2xvcjMHZnJvbVJHQgZyZW5kZXILd2lsbFVubW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9hY3QNY3JlYXRlRWxlbWVudA1QdXJlQ29tcG9uZW50DUNlbnRlck1lc3NhZ2UGZXh0ZW5kAAUBAQAAAAABggABAAAABgEBGAAGAAAAAAQBAAAAAAccAgAAjAMAALcDAgACAAAAqQEAAakBAQCCAQIAAAANAAEYAAAAAAAAAA4AAAAADQEBAAAAcPsBAABvAgAA4gMGAIwEAQAwBAM6AQAAAKQECQAAIHCAbwUKAIwGAACMBwEAjAgAAJ8EBQIwBAMvAgAAAKQECQAAIHCAbwULAIwGAABvBwwAjAgAAJ8EBQIwBAM7AwAAAKQEDgAAINCAbwULAG8GCwCfBAMCMAQD6AQAAABNBAAHDwAAAE0EBNUQAAAAwAYRALwEBJASAAAAnwQDAjAEA4AFAAAA4gQVAPsFAABvBhYA4gcXAIwIAgAwCAdpEwAAAJ8FAwIwBQRpEwAAAPsFAABvBhgA4gcfAIwIAQAwCAc6AQAAAKQICQAAIHCAjAkBAIwKAACMCwEAjAwAAJ8IBQIwCAcvAgAAAKQICQAAIHCAjAkAAIwKAABvCyAAjAwAAJ8IBQIwCAc7AwAAAKQIIwAiZBDCMAgHORkAAACpCAEAMAgH3hoAAACkCCYAAJRAgowJ/ACMCigAjAsvAJ8IBAIwCAdzGwAAAKQIJgAAlECCjAnKAIwKAACMCwAAnwgEAjAIB6QcAAAAbwgLADAIB0cdAAAATQgABw8AAABNCAjVEAAAADAIB/UeAAAAnwUDAjAFBEoUAAAAnwEEAIIBAAAnAwIDAwMEAwUDBgMHBQUBAgMEBQMIAwkEACBwgAKamZmZmZnJPwIAAAAAAADgPwKamZmZmZnZPwMKBAAg0IADCwMMBgEDDQMOAw8FAhMUAxAFARMDEQMSAxMDFAMVAxYDFwUJAQIDGRobHB0eApqZmZmZmbm/AxgDGQQiZBDCAxoDGwQAlECCAQEHHAEYAAAAAQAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAADAQAAAQAA/wAAAwAAAQAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAAEAAAEAAAAAAAAAAQAAAAAAAAABAAABAAAAAAD3AAD0AAgAAAAAAQEAAAAAAYIAAQAAACEdARgAIQAAAAAGAAABAgAfowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICTQIBygcAAABNAwH4CAAAAG8FCQC8AwOcCgAAAJ8DAwLABAsAMAQDEwwAAADABA0AEgACADAEA4AOAAAAwAQPADAEAzQQAAAAggMCABEDHgQAAABAAx8DIAMhBAAAQEADIgMjAyQDJQMmBgADAQYCAxwGAwMdAwACAwEAARgAAAAAAAAAAQAAAAABAAIAAAAAAAEAAAEAAAAaAAABAQAAAAAEyE/ukgJHjpV5/kso2lJEPrhX+eb6i4ST

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:42
-- Luau version 6, Types version 3
-- Time taken: 0.002856 seconds

local Roact = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact.PureComponent:extend("CenterMessage")
function any_extend_result1.init(arg1) -- Line 6
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 7
    --[[ Upvalues[1]:
        [1]: createElement_upvr (readonly)
    ]]
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.2, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0.4, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Visible = arg1.props.text:map(function(arg1_2) -- Line 13
            local var6
            if 0 >= #arg1_2 then
                var6 = false
            else
                var6 = true
            end
            return var6
        end);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 2;
        });
        Time = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0, 0, -0.1, 0);
            Font = Enum.Font.LuckiestGuy;
            TextScaled = true;
            TextColor3 = Color3.fromRGB(252, 40, 47);
            TextStrokeColor3 = Color3.fromRGB(202, 0, 0);
            TextStrokeTransparency = 0.5;
            Text = arg1.props.text;
        });
    })
end
function any_extend_result1.willUnmount(arg1) -- Line 33
end
return any_extend_result1