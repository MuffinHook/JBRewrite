-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMnBmlwYWlycwVwcm9wcwdlbnRyaWVzBHJhbmsEbmFtZQZ1c2VySWQHbWVzc2FnZQVGcmFtZRZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5BFNpemUFVURpbTIDbmV3BW1lcmdlCkxpc3RMYXlvdXQMVUlMaXN0TGF5b3V0E0hvcml6b250YWxBbGlnbm1lbnQRVmVydGljYWxBbGlnbm1lbnQJU29ydE9yZGVyDUZpbGxEaXJlY3Rpb24ERW51bQZDZW50ZXIDVG9wC0xheW91dE9yZGVyCFZlcnRpY2FsBnJlbmRlcgRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQRFelVpCkRpY3Rpb25hcnkFUm9hY3QNY3JlYXRlRWxlbWVudApCb2FyZEVudHJ5BnNjcmlwdAZQYXJlbnQNUHVyZUNvbXBvbmVudAVCb2FyZAZleHRlbmQAAgsBAwAAAEz/AQAAAAAAAKQCAQAAAABATQMABwIAAABNAwM3AwAAAJ8CAgRRAhMA+wcAAPsIAQDiCQgAMAUJvwQAAABNCgZaBQAAADAKCVoFAAAATQoGhgYAAAAwCgmGBgAAAE0KBpgHAAAAMAoJmAcAAACfBwMCagcBBW4C7P8CAACA+wIAAG8DCQDiBAwAjAUBADAFBDoKAAAApAUPAAA40ICMBgEAjAcAAIwIAQCMCQAAnwUFAjAFBC8LAAAA+wUCAE0FBR8QAAAA4gYSAPsHAABvCBMA4gkYAKQKGwAaUJDBMAoJYhQAAACkCh0AHFSQwTAKCXgVAAAApAofAB5YkMEwCgm5FgAAAKQKIQAgXJDBMAoJURcAAACfBwMCMAcGLhEAAABSBwEAnwUDAJ8CAACCAgAAIgMBBAAAAEADAgMDAwQDBQMGAwcFBAQFBgcDCAMJAwoFAgoLAwsDDAQAONCAAw0DDgUBEQMPAxADEQMSAxMFBBQVFhcDFAMVBBpQkMEDFgQcVJDBAxcEHliQwQMYBCBckMEACRkBGAAAAQAAAAAAAAABAAABAAEAAAABAAAAAQAAAPwA/wAIAQEBAAABAAAAAAAAAAACAAAAAQAAAQAAAAEAAAABAAAAAQAAAPwAAAb5+gAKAAAAAAgAAAECACujAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAtBgAAAE0CAqkHAAAAnwECAqQCBQAAAEBATQMAIQgAAACfAgICTQMCygkAAACkBAUAAABAQKQGDAAAALBATQYGJA0AAABNBQZjCgAAAJ8EAgJNBQL4DgAAAG8HDwC8BQWcEAAAAJ8FAwLABhEAEgADABIABAASAAEAMAYFgBIAAACCBQIAEwMaBAAAAEADGwMcAx0EAABAQAMeAx8DIAMhAyIDIwQAALBAAyQDJQMmAycGAAMZAQABAAEYAAAAAAAAAAEAAAAAAAABAAAAAAEAAgAAAAAAAAAAAgAAAAAAAQAAAAAAGgEAAAAAAaTPJ81/SSA5nk14G7jaGojU1zC5lgtNzA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:18
-- Luau version 6, Types version 3
-- Time taken: 0.002615 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Board")
local createElement_upvr = Roact.createElement
local BoardEntry_upvr = require(script.Parent.BoardEntry)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 9
    --[[ Upvalues[3]:
        [1]: createElement_upvr (readonly)
        [2]: BoardEntry_upvr (readonly)
        [3]: Dictionary_upvr (readonly)
    ]]
    local module = {}
    for i, v in ipairs(arg1.props.entries) do
        module[i] = createElement_upvr(BoardEntry_upvr, {
            rank = i;
            name = v.name;
            userId = v.userId;
            message = v.message;
        })
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
    }, Dictionary_upvr.merge({
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            VerticalAlignment = Enum.VerticalAlignment.Top;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Vertical;
        });
    }, module))
end
return any_extend_result1