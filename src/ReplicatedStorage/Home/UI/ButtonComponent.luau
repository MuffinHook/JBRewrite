-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMyDGNvcm5lclJhZGl1cwpUZXh0QnV0dG9uD2JhY2tncm91bmRDb2xvchBCYWNrZ3JvdW5kQ29sb3IzBHNpemUEU2l6ZQhwb3NpdGlvbghQb3NpdGlvbgthbmNob3JQb2ludAtBbmNob3JQb2ludAAEVGV4dApTZWxlY3RhYmxlBUV2ZW50CUFjdGl2YXRlZAdvbkNsaWNrBkNvcm5lcgVUaXRsZQhVSUNvcm5lcgxDb3JuZXJSYWRpdXMJVGV4dExhYmVsFkJhY2tncm91bmRUcmFuc3BhcmVuY3kERm9udApMaW5lSGVpZ2h0ClRleHRTY2FsZWQOVGV4dFhBbGlnbm1lbnQOVGV4dFlBbGlnbm1lbnQKVGV4dENvbG9yMwVVRGltMglmcm9tU2NhbGUFdGl0bGUERW51bQdCYW5nZXJzBkNlbnRlcgpzYXR1cmF0ZUJ5BlN0cm9rZQhVSVN0cm9rZQVDb2xvcglUaGlja25lc3MGQ29sb3IzA25ldw9idXR0b25Db21wb25lbnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9hY3QDU3RkCkNvbG9yVXRpbHMNY3JlYXRlRWxlbWVudAACEQEDAAAAck0BAG8AAAAA+wIAAG8DAQD/BAQAAAAAAE0FAA4CAAAAMAUEnwMAAABNBQAPBAAAADAFBC8FAAAATQUA2wYAAAAwBQQ7BwAAAE0FAAgIAAAAMAUE6AkAAABvBQoAMAUE9QsAAACpBQEAMAUEJAwAAAD7BQEATQUFNg0AAABNBQUeDgAAAE0GAG4PAAAAagYEBeIFEgBSBgEADgYGAPsGAABvBxMA4ggVADABCE8UAAAAnwYDAjAGBWoQAAAA+wYAAG8HFgDiCB4AjAkBADAJCDoXAAAApAkhAACA8IGMCgEAjAsBAJ8JAwIwCQgvBQAAAE0JAJoiAAAAMAkI9QsAAACkCSUAJGAwwjAJCDkYAAAAjAkBADAJCIIZAAAAqQkBADAJCN4aAAAApAknACZsMMIwCQh7GwAAAKQJKAAmcDDCMAkIHRwAAAD7CQIATQkJ3ikAAABNCgAOAgAAAG8LKgCfCQMCMAkIcx0AAADiCSwA+woAAG8LLQDiDDAApA0zAADIEIOMDgAAjA8AAIwQAACfDQQCMA0MpC4AAACMDQEAMA0MGC8AAACfCgMCMAoJpSsAAACfBgQCMAYFuhEAAACfAgQAggIAADQDAQMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAMRAxIFAhARAxMDFAUBFAMVAxYDFwMYAxkDGgMbAxwFCRcFCxgZGhscHQMdAx4EAIDwgQMfAyADIQQkYDDCAyIEJmwwwgQmcDDCAyMCZmZmZmZm5r8DJAUBKwMlAyYDJwUCLi8DKAMpBADIEIMABioBGAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAABAAABAAAAAAAAAAEBAAAAAAEA/wAAAwAAAQAAAQAAAAAAAAEAAAABAAAAAQAAAQAAAQAAAAEAAAABAAAAAAAAAAABAQAAAQAAAAAAAAACAAD9AAD1AAD0AAcAAAAABQAAAQIAGqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAqQCBQAAAEBATQMAoQcAAABNAwMzCAAAAJ8CAgJNAwHKCQAAAMAECgASAAMAEgABABIAAgCCBAIACwMrBAAAAEADLAMtAy4EAABAQAMvAzADMQMyBgABAAEAARgAAAAAAAAAAQAAAAABAAAAAAAAAQACAAAAIgEAAAAAAWn1AyNYzJYOyhkzM+yndV0Z7RRXWzFpIg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:23
-- Luau version 6, Types version 3
-- Time taken: 0.002328 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
return function(arg1) -- Line 6, Named "buttonComponent"
    --[[ Upvalues[3]:
        [1]: createElement_upvr (readonly)
        [2]: Roact_upvr (readonly)
        [3]: ColorUtils_upvr (readonly)
    ]]
    local cornerRadius = arg1.cornerRadius
    local module = {}
    local var8 = cornerRadius
    if var8 then
        var8 = createElement_upvr
        var8 = var8("UICorner", {
            CornerRadius = cornerRadius;
        })
    end
    module.Corner = var8
    module.Title = createElement_upvr("TextLabel", {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
        Text = arg1.title;
        Font = Enum.Font.Bangers;
        LineHeight = 1;
        TextScaled = true;
        TextXAlignment = Enum.TextXAlignment.Center;
        TextYAlignment = Enum.TextYAlignment.Center;
        TextColor3 = ColorUtils_upvr.saturateBy(arg1.backgroundColor, -0.7);
    }, {
        Stroke = createElement_upvr("UIStroke", {
            Color = Color3.new(0, 0, 0);
            Thickness = 1;
        });
    })
    return createElement_upvr("TextButton", {
        BackgroundColor3 = arg1.backgroundColor;
        Size = arg1.size;
        Position = arg1.position;
        AnchorPoint = arg1.anchorPoint;
        Text = "";
        Selectable = true;
        [Roact_upvr.Event.Activated] = arg1.onClick;
    }, module)
end