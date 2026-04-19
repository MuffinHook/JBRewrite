-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaBGluaXQFRnJhbWUFVURpbTIDbmV3BFNpemUPQm9yZGVyU2l6ZVBpeGVsBXByb3BzFmJhY2tncm91bmRUcmFuc3BhcmVuY3kWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQ9iYWNrZ3JvdW5kQ29sb3IQQmFja2dyb3VuZENvbG9yMwtsYXlvdXRPcmRlcgtMYXlvdXRPcmRlcgNSZWYIQ2hpbGRyZW4GcmVuZGVyBnNjcmlwdARFelVpEUZpbmRGaXJzdEFuY2VzdG9yB3JlcXVpcmUGUGFyZW50BVJvYWN0DWNyZWF0ZUVsZW1lbnQNUHVyZUNvbXBvbmVudAdUYWJQYWdlBmV4dGVuZAADAQEAAAAAAYIAAQAAAAgBARgACAAAAAAJAQIAAAA0+wEAAG8CAAD/AwQAAAAAAKQEAwAACBCAjAUBAIwGAACMBwEAjAgAAJ8EBQIwBAMvBAAAAIwEAAAwBAOOBQAAAE0EAAcGAAAATQQEGgcAAAAwBAM6CAAAAE0EAAcGAAAATQQEDgkAAAAwBAOfCgAAAE0EAAcGAAAATQQEIAsAAAAwBAMADAAAAPsEAQBNBATdDQAAAE0GAAcGAAAA+wcBAE0HB90NAAAAhwUGB2oFAwRNBQAHBgAAAPsGAQBNBgbODgAAAIcEBQafAQQAggEAAA8DAgMDAwQEAAgQgAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8ACRABGAAAAAABAAAAAAAAAAABAAABAAAAAAABAAAAAAABAAAAAAABAAAAAAAAAAAAAQAAAAAA+QAKAAAAAAYAAAECAB+jAAAApAABAAAAAEBvAgIAvAAAfAMAAACfAAMCpAEFAAAAQEBNAgAkBgAAAE0CAiEHAAAAnwECAk0CAcoIAAAATQMB+AkAAABvBQoAvAMDnAsAAACfAwMCwAQMADAEAxMNAAAAwAQOABIAAgASAAEAMAQDgA8AAACCAwIAEAMRBAAAAEADEgMTAxQEAABAQAMVAxYDFwMYAxkDGgYAAwEGAQMQAgABAQABGAABAAAAAAABAAAAAAAAAQACAAAAAAACAAABAAAAAAsBAAAAAAJPrVN8iGOWwCTPC/uo2YNMP7VECH1pOX0=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:52
-- Luau version 6, Types version 3
-- Time taken: 0.001745 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TabPage")
function any_extend_result1.init(arg1) -- Line 8
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 9
    --[[ Upvalues[2]:
        [1]: createElement_upvr (readonly)
        [2]: Roact_upvr (readonly)
    ]]
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BorderSizePixel = 0;
        BackgroundTransparency = arg1.props.backgroundTransparency;
        BackgroundColor3 = arg1.props.backgroundColor;
        LayoutOrder = arg1.props.layoutOrder;
        [Roact_upvr.Ref] = arg1.props[Roact_upvr.Ref];
    }, arg1.props[Roact_upvr.Children])
end
return any_extend_result1