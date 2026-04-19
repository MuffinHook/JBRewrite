-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMrClRleHRCdXR0b24FcHJvcHMLYW5jaG9yUG9pbnQLQW5jaG9yUG9pbnQKYm9yZGVyU2l6ZQ9Cb3JkZXJTaXplUGl4ZWwLYm9yZGVyQ29sb3IMQm9yZGVyQ29sb3IzD2JhY2tncm91bmRDb2xvchBCYWNrZ3JvdW5kQ29sb3IzBHRleHQEVGV4dAl0ZXh0Q29sb3IKVGV4dENvbG9yMwRzaXplBFNpemUERW51bQRGb250DlNvdXJjZVNhbnNCb2xkClRleHRTY2FsZWQIcG9zaXRpb24IUG9zaXRpb24LbGF5b3V0T3JkZXILTGF5b3V0T3JkZXIHdmlzaWJsZQdWaXNpYmxlBUV2ZW50CUFjdGl2YXRlZAdvbkNsaWNrCENoaWxkcmVuBnJlbmRlcgZzY3JpcHQERXpVaRFGaW5kRmlyc3RBbmNlc3RvcgdyZXF1aXJlBlBhcmVudAVSb2FjdA1jcmVhdGVFbGVtZW50CUNvbXBvbmVudAZleHRlbmQGQ29sb3IzA25ldwxkZWZhdWx0UHJvcHMAAgcBAgAAAFn7AQAAbwIAAP8DBQAAAAAATQQABwEAAABNBAQIAgAAADAEA+gDAAAATQQABwEAAABNBARpBAAAADAEA44FAAAATQQABwEAAABNBASLBgAAADAEAzQHAAAATQQABwEAAABNBAQOCAAAADAEA58JAAAATQQABwEAAABNBATVCgAAADAEA/ULAAAATQQABwEAAABNBAS/DAAAADAEA3MNAAAATQQABwEAAABNBAQPDgAAADAEAy8PAAAApAQTABJEAMEwBAM5EQAAAKkEAQAwBAPeFAAAAE0EAAcBAAAATQQE2xUAAAAwBAM7FgAAAE0EAAcBAAAATQQEIBcAAAAwBAMAGAAAAE0EAAcBAAAATQQEoBkAAAAwBAOAGgAAAPsEAQBNBAQ2GwAAAE0EBB4cAAAATQUABwEAAABNBQVuHQAAAGoFAwRNBQAHAQAAAPsGAQBNBgbOHgAAAIcEBQafAQQAggEAAB8DAQMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwQSRADBAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgAPHwEYAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAAABAAABAAAAAAABAAAAAAABAAAAAAABAAAAAAAAAAAAAQAAAAAA8gAQAAAAAAkAAAECADqjAAAApAABAAAAAEBvAgIAvAAAfAMAAACfAAMCpAEFAAAAQEBNAgAkBgAAAE0CAiEHAAAAnwECAk0CAcoIAAAATQMBiAkAAABvBQoAvAMDnAsAAACfAwMC4gQQAKQFEwAASBCBjAYBAIwHAQCMCAEAnwUEAjAFBA4MAAAApAUTAABIEIGMBgAAjAcAAIwIAACfBQQCMAUEvw0AAACMBQAAMAUEaQ4AAACkBRMAAEgQgYwGAACMBwAAjAgAAJ8FBAIwBQSLDwAAADAEA5IUAAAAwAQVABIAAgASAAEAMAQDgBYAAACCAwIAFwMgBAAAAEADIQMiAyMEAABAQAMkAyUDJgMnAwEDKAMJAw0DBQMHBQQMDQ4PAykDKgQASBCBAysGAAMfAQABAAEYAAEAAAAAAAEAAAAAAAABAAIAAAAAAAIBAAAAAAAAAAEAAAAAAAAAAQAAAQAAAAAAAAD8AAcAAAAAEQEAAAAAATZY+hUoZKrN1ftuFg0wNXVGQO1hBJyQFA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:54
-- Luau version 6, Types version 3
-- Time taken: 0.002128 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("TextButton")
any_extend_result1.defaultProps = {
    backgroundColor = Color3.new(1, 1, 1);
    textColor = Color3.new(0, 0, 0);
    borderSize = 0;
    borderColor = Color3.new(0, 0, 0);
}
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 15
    --[[ Upvalues[2]:
        [1]: createElement_upvr (readonly)
        [2]: Roact_upvr (readonly)
    ]]
    return createElement_upvr("TextButton", {
        AnchorPoint = arg1.props.anchorPoint;
        BorderSizePixel = arg1.props.borderSize;
        BorderColor3 = arg1.props.borderColor;
        BackgroundColor3 = arg1.props.backgroundColor;
        Text = arg1.props.text;
        TextColor3 = arg1.props.textColor;
        Size = arg1.props.size;
        Font = Enum.Font.SourceSansBold;
        TextScaled = true;
        Position = arg1.props.position;
        LayoutOrder = arg1.props.layoutOrder;
        Visible = arg1.props.visible;
        [Roact_upvr.Event.Activated] = arg1.props.onClick;
    }, arg1.props[Roact_upvr.Children])
end
return any_extend_result1