-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMhA25ldwRtYWlkBGluaXQFVURpbTIFcHJvcHMJcGN0Q2xvc2VkA21hcAVGcmFtZQRTaXplFkJhY2tncm91bmRUcmFuc3BhcmVuY3kDVG9wBkJvdHRvbRBCYWNrZ3JvdW5kQ29sb3IzC0FuY2hvclBvaW50CFBvc2l0aW9uD0JvcmRlclNpemVQaXhlbAZDb2xvcjMHVmVjdG9yMgZyZW5kZXIIZGlkTW91bnQKRG9DbGVhbmluZwt3aWxsVW5tb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQETWFpZAVSb2FjdA1jcmVhdGVFbGVtZW50DVB1cmVDb21wb25lbnQHRXllbGlkcwZleHRlbmQABgIBAQAAAAf7AQAATQEB7wAAAACfAQECMAEAFgEAAACCAAEAAgMBAwIABwMBGAAAAAAAAAEIAAAAAAYBAAAAAAikAQIAAAQAgIwCAQCMAwAAPgQAA4wFAACfAQUAggEAAAQDBAMBBAAEAIACAAAAAAAAAEAACwABGAAAAAAAAAAADAAAAAAOAQEAAABgTQEABwAAAABNAQG1AQAAAMADAgC8AQGQAwAAAJ8BAwL7AgAAbwMEAOIEBwCkBQoAACSAgIwGAQCMBwAAjAgBAIwJAACfBQUCMAUELwUAAACMBQEAMAUEOgYAAADiBQ0A+wYAAG8HBADiCBIApAkUAAAkMIGMCgAAjAsAAIwMAACfCQQCMAkInw4AAACkCRYAACRQgW8KFwCMCwAAnwkDAjAJCOgPAAAApAkKAAAkgIBvChcAjAsAAIwMAACMDQAAnwkFAjAJCDsQAAAAMAEILwUAAACMCQAAMAkIjhEAAACfBgMCMAYFmAsAAAD7BgAAbwcEAOIIEgCkCRQAACQwgYwKAACMCwAAjAwAAJ8JBAIwCQifDgAAAKQJFgAAJFCBbwoXAIwLAQCfCQMCMAkI6A8AAACkCQoAACSAgG8KFwCMCwAAjAwBAIwNAACfCQUCMAkIOxAAAAAwAQgvBQAAAIwJAAAwCQiOEQAAAJ8GAwIwBgUTDAAAAJ8CBACCAgAAGAMFAwYGAQMHAwgDCQMKBQIFBgMEAwEEACSAgAMLAwwFAgsMAw0DDgMPAxAFBQ4PEAURAxEEACQwgQMSBAAkUIECAAAAAAAA4D8BAQoTARgAAAAAAAAAAAMAAAEAAAAAAAAAAAEAAAEBAAABAAAAAAAAAAEAAAAAAAABAAAAAAAAAAABAAEAAPsAAAcAAAEAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAEAAQAA+wAA9QALAAAAAAEBAAAAAAGCAAEAAAAiFAEYACIAAAAAAwEAAAAABk0BABYAAAAAvAEBUQEAAACfAQIBggABAAIDAgMVACMWARgAAAAAAAEkAAAAAAcAAAECACqjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAnYHAAAAnwECAqQCBQAAAEBATQMAIQgAAACfAgICTQMCygkAAABNBAL4CgAAAG8GCwC8BAScDAAAAJ8EAwLABQ0AEgABADAFBBMOAAAAwAUPABIAAwAwBQSAEAAAAMAFEQAwBQRqEgAAAMAFEwAwBQQ0FAAAAIIEAgAVAxcEAAAAQAMYAxkDGgQAAEBAAxsDHAMdAx4DHwMgAyEGAAMDBgIDEwYDAxQGBAMWBAACAwQBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAEAAgAAAAAAAQAAAAMAAAAYAAABAAADAQAAAAAFTpSa8TftmBlUvDRTFDhl1D6MjYV8UPDw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:01
-- Luau version 6, Types version 3
-- Time taken: 0.003267 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Eyelids")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 7
    --[[ Upvalues[1]:
        [1]: Maid_upvr (readonly)
    ]]
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 10
    --[[ Upvalues[1]:
        [1]: createElement_upvr (readonly)
    ]]
    local any_map_result1 = arg1.props.pctClosed:map(function(arg1_2) -- Line 11
        return UDim2.new(1, 0, arg1_2 / 2, 0)
    end)
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BackgroundTransparency = 1;
    }, {
        Top = createElement_upvr("Frame", {
            BackgroundColor3 = Color3.new(0, 0, 0);
            AnchorPoint = Vector2.new(0.5, 0);
            Position = UDim2.new(0.5, 0, 0, 0);
            Size = any_map_result1;
            BorderSizePixel = 0;
        });
        Bottom = createElement_upvr("Frame", {
            BackgroundColor3 = Color3.new(0, 0, 0);
            AnchorPoint = Vector2.new(0.5, 1);
            Position = UDim2.new(0.5, 0, 1, 0);
            Size = any_map_result1;
            BorderSizePixel = 0;
        });
    })
end
function any_extend_result1.didMount(arg1) -- Line 34
end
function any_extend_result1.willUnmount(arg1) -- Line 35
    arg1.maid:DoCleaning()
end
return any_extend_result1