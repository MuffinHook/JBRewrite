-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMmBGluaXQKSW1hZ2VMYWJlbAhQb3NpdGlvbg9Cb3JkZXJTaXplUGl4ZWwQQmFja2dyb3VuZENvbG9yMxZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5BUltYWdlBFNpemUFcHJvcHMIcG9zaXRpb24GQ29sb3IzA25ldy5yYnh0aHVtYjovL3R5cGU9QXZhdGFySGVhZFNob3Qmdz0xNTAmaD0xNTAmaWQ9BnVzZXJJZAh0b3N0cmluZwRzaXplCFVJQ29ybmVyCFVJU3Ryb2tlDVVJQXNwZWN0UmF0aW8MQ29ybmVyUmFkaXVzBFVEaW0IaXNGcmllbmQJVGhpY2tuZXNzBUNvbG9yB2Zyb21IZXgGNWNjNzZkF1VJQXNwZWN0UmF0aW9Db25zdHJhaW50C0FzcGVjdFJhdGlvBnJlbmRlcgRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2FjdA1jcmVhdGVFbGVtZW50DVB1cmVDb21wb25lbnQGQXZhdGFyBmV4dGVuZAADAQEAAAAAAYIAAQAAAAYBARgABgAAAAALAQEAAABW+wEAAG8CAADiAwcATQQABwgAAABNBATbCQAAADAEAzsBAAAAjAQAADAEA44CAAAApAQMAAAsoIBvBQ0AbwYNAG8HDQCfBAQCMAQDnwMAAACMBAAAMAQDOgQAAABvBQ4ATQcABwgAAABNBweGDwAAALs/BwKkBhEAAAAAQZ8GAgJzBAUGMAQDqQUAAABNBAAHCAAAAE0EBA8SAAAAMAQDLwYAAADiBBYA+wUAAG8GEwDiBxgApAgaAAAskIGMCQEAjAoAAJ8IAwIwCAdPFwAAAJ8FAwIwBQT0EwAAAE0FAAcIAAAATQUFQBsAAAAOBQ0A+wUAAG8GFADiBx4AjAgBADAIBxgcAAAApAggAAB8oIBvCSEAnwgCAjAIB6QdAAAAnwUDAjAFBG0UAAAA+wUAAG8GIgDiByQAjAgBADAIB2kjAAAAnwUDAjAFBIAVAAAAnwEEAIIBAAAlAwIDAwMEAwUDBgMHAwgFBgECAwQFBgMJAwoDCwMMBAAsoIACZmZmZmZm5j8DDQMOAw8EAAAAQQMQAxEDEgMTBQMTFBUDFAUBFwMVBAAskIEDFgMXAxgFAhwdAxkEAHyggAMaAxsDHAUBIwAHHQEYAAAAAQAAAAAAAQAAAQAAAAAAAAABAAABAAAAAAAAAAAAAAADAAAAAAABAQAAAQAAAAAAAP8AAAMAAAAAAAAAAQAAAQAAAAAA/gAABAAAAQAA/wAA7wAJAAAAAAYAAAECAByjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAhBgAAAJ8BAgJNAgHKBwAAAE0DAfgIAAAAbwUJALwDA5wKAAAAnwMDAsAECwAwBAMTDAAAAMAEDQASAAIAMAQDgA4AAACCAwIADwMeBAAAAEADHwMgAyEEAABAQAMiAyMDJAMlAyYGAAMBBgEDHQIAAQEAARgAAAAAAAAAAQAAAAABAAIAAAAAAAEAAAEAAAAZAQAAAAACyh+sXG+1MXiumRAFTOy6VboHuyj428Zd

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:29
-- Luau version 6, Types version 3
-- Time taken: 0.001923 seconds

local Roact = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact.PureComponent:extend("Avatar")
function any_extend_result1.init(arg1) -- Line 6
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 7
    --[[ Upvalues[1]:
        [1]: createElement_upvr (readonly)
    ]]
    local module = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
    }
    local isFriend = arg1.props.isFriend
    if isFriend then
        isFriend = createElement_upvr
        isFriend = isFriend("UIStroke", {
            Thickness = 1;
            Color = Color3.fromHex("5cc76d");
        })
    end
    module.UIStroke = isFriend
    module.UIAspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = 1;
    })
    return createElement_upvr("ImageLabel", {
        Position = arg1.props.position;
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0.7, 0.7, 0.7);
        BackgroundTransparency = 0;
        Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id="..tostring(arg1.props.userId);
        Size = arg1.props.size;
    }, module)
end
return any_extend_result1