-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPB3VubW91bnQHcmVxdWlyZQxMaWNlbnNlUGxhdGUGc2NyaXB0BlBhcmVudAVtb3VudA1jcmVhdGVFbGVtZW50BHNpemUIcG9zaXRpb24FVURpbTIDbmV3BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAADAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDAQANAAEYAAAAAAABDgAAAAALAQEAAAAqpAEBAAAAAECkAwQAAAAwQE0DAyQFAAAATQIDNAIAAACfAQIC+wIAAE0CAuQGAAAA+wMAAE0DA8oHAAAAUgQBAOIFCgCkBg0AADCwgG8HDgCMCAAAbwkOAIwKAACfBgUCMAYFDwgAAACkBg0AADCwgG8HDwCMCAAAbwkPAIwKAACfBgUCMAYF2wkAAACfAwMCUgQAAJ8CAwLZAwAAEgIAABIAAgCCAwIAEAMCBAAAAEADAwMEBAAAMEADBQMGAwcDCAMJBQIICQMKAwsEADCwgAIAAAAAAADgPwIAAAAAAADQPwEABAABGAAAAAAAAAAAAAEAAAEAAAAAAQAAAAAAAAAAAQAAAAAAAAAA/gT7BwAAAAUAAAAAAwAAAQIAD6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAsACBwASAAEAggICAAgDDAQAAABAAw0DDgMCBAAAQEADDwYBAQEBAAEYAAAAAAAAAAEAAAAAAgAAAQAAAAAC+ehPdNIFcyCv0B8p8bQaBonwWADLLCV1

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:46:08
-- Luau version 6, Types version 3
-- Time taken: 0.001056 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.LicensePlate), {
        size = UDim2.new(0.5, 0, 0.5, 0);
        position = UDim2.new(0.25, 0, 0.25, 0);
    }), arg1)
    return function() -- Line 13
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end