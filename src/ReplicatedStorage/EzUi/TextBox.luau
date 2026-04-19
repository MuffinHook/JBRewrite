-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMkB1RleHRCb3gFcHJvcHMKYm9yZGVyU2l6ZQ9Cb3JkZXJTaXplUGl4ZWwLYm9yZGVyQ29sb3IMQm9yZGVyQ29sb3IzFmJhY2tncm91bmRUcmFuc3BhcmVuY3kWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQ9iYWNrZ3JvdW5kQ29sb3IQQmFja2dyb3VuZENvbG9yMwR0ZXh0BFRleHQJdGV4dENvbG9yClRleHRDb2xvcjMEc2l6ZQRTaXplCHBvc2l0aW9uCFBvc2l0aW9uC2xheW91dE9yZGVyC0xheW91dE9yZGVyBUV2ZW50CUZvY3VzTG9zdAtvbkZvY3VzTG9zdAZyZW5kZXIGc2NyaXB0BEV6VWkRRmluZEZpcnN0QW5jZXN0b3IHcmVxdWlyZQZQYXJlbnQFUm9hY3QNY3JlYXRlRWxlbWVudAlDb21wb25lbnQGZXh0ZW5kBkNvbG9yMwNuZXcMZGVmYXVsdFByb3BzAAIGAQIAAABG+wEAAG8CAAD/AwUAAAAAAE0EAAcBAAAATQQEaQIAAAAwBAOOAwAAAE0EAAcBAAAATQQEiwQAAAAwBAM0BQAAAE0EAAcBAAAATQQEGgYAAAAwBAM6BwAAAE0EAAcBAAAATQQEDggAAAAwBAOfCQAAAE0EAAcBAAAATQQE1QoAAAAwBAP1CwAAAE0EAAcBAAAATQQEvwwAAAAwBANzDQAAAE0EAAcBAAAATQQEDw4AAAAwBAMvDwAAAE0EAAcBAAAATQQE2xAAAAAwBAM7EQAAAE0EAAcBAAAATQQEIBIAAAAwBAMAEwAAAPsEAQBNBAQ2FAAAAE0EBLgVAAAATQUABwEAAABNBQUDFgAAAGoFAwSfAQMAggEAABcDAQMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXABAYARgAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAAAAAPYAEQAAAAAJAAABAgA9owAAAKQAAQAAAABAbwICALwAAHwDAAAAnwADAqQBBQAAAEBATQIAJAYAAABNAgIhBwAAAJ8BAgJNAgHKCAAAAE0DAYgJAAAAbwUKALwDA5wLAAAAnwMDAuIEEQCkBRQAAEwggYwGAQCMBwEAjAgBAJ8FBAIwBQQODAAAAKQFFAAATCCBjAYAAIwHAACMCAAAnwUEAjAFBL8NAAAAjAUAADAFBGkOAAAApAUUAABMIIGMBgAAjAcAAIwIAACfBQQCMAUEiw8AAACMBQAAMAUEGhAAAAAwBAOSFQAAAMAEFgASAAIAEgABADAEA4AXAAAAggMCABgDGQQAAABAAxoDGwMcBAAAQEADHQMeAx8DIAMBAyEDCQMNAwMDBQMHBQUMDQ4PEAMiAyMEAEwggQMkBgADGAEAAQABGAABAAAAAAABAAAAAAAAAQACAAAAAAACAQAAAAAAAAABAAAAAAAAAAEAAAEAAAAAAAAAAQAA+wAIAAAAAA4BAAAAAAFsKS2q9xxjzFse6sJWS++PHDE63l7tR6s=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:53
-- Luau version 6, Types version 3
-- Time taken: 0.001808 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("TextBox")
any_extend_result1.defaultProps = {
    backgroundColor = Color3.new(1, 1, 1);
    textColor = Color3.new(0, 0, 0);
    borderSize = 0;
    borderColor = Color3.new(0, 0, 0);
    backgroundTransparency = 0;
}
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 16
    --[[ Upvalues[2]:
        [1]: createElement_upvr (readonly)
        [2]: Roact_upvr (readonly)
    ]]
    return createElement_upvr("TextBox", {
        BorderSizePixel = arg1.props.borderSize;
        BorderColor3 = arg1.props.borderColor;
        BackgroundTransparency = arg1.props.backgroundTransparency;
        BackgroundColor3 = arg1.props.backgroundColor;
        Text = arg1.props.text;
        TextColor3 = arg1.props.textColor;
        Size = arg1.props.size;
        Position = arg1.props.position;
        LayoutOrder = arg1.props.layoutOrder;
        [Roact_upvr.Event.FocusLost] = arg1.props.onFocusLost;
    })
end
return any_extend_result1