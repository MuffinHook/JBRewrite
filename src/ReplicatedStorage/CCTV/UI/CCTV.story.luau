-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWB3VubW91bnQHcmVxdWlyZQRDQ1RWBnNjcmlwdAZQYXJlbnQFbW91bnQNY3JlYXRlRWxlbWVudARzaXplCHBvc2l0aW9uCGRpc3RhbmNlC2FzcGVjdFJhdGlvDGNhbWVyYUNGcmFtZQtmaWVsZE9mVmlldwVVRGltMgNuZXcJd29ya3NwYWNlDUN1cnJlbnRDYW1lcmEGQ0ZyYW1lBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAADAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDAQARAAEYAAAAAAABEgAAAAALAQEAAAA7pAEBAAAAAECkAwQAAAAwQE0DAyQFAAAATQIDjwIAAACfAQIC+wIAAE0CAuQGAAAA+wMAAE0DA8oHAAAAUgQBAOIFDgCkBhEAAEDwgG8HEgCMCAAAbwkSAIwKAACfBgUCMAYFDwgAAACkBhEAAEDwgG8HEgCMCAAAbwkSAIwKAACfBgUCMAYF2wkAAACMBmAAMAYFdQoAAABvBhMAMAYFiQsAAACkBhUAAABAQU0GBkgWAAAATQYGhRcAAAAwBgXBDAAAAIwGRgAwBgWBDQAAAJ8DAwJSBAAAnwIDAtkDAAASAgAAEgACAIIDAgAYAwIEAAAAQAMDAwQEAAAwQAMFAwYDBwMIAwkDCgMLAwwDDQUGCAkKCwwNAw4DDwQAQPCAAgAAAAAAAOA/AhzHcRzHcfw/AxAEAABAQQMRAxIBAAQAARgAAAAAAAAAAAABAAABAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAEAAAEAAAEAAAAAAAAAAQAA+gj3CwAAAAUAAAAAAwAAAQIAD6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAsACBwASAAEAggICAAgDEwQAAABAAxQDFQMCBAAAQEADFgYBAQEBAAEYAAAAAAAAAAEAAAAAAgAAAQAAAAACMnZcF+R+Rjr58zSTY3w5wUJuS2MAsjYW

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:56
-- Luau version 6, Types version 3
-- Time taken: 0.001363 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.CCTV), {
        size = UDim2.new(0.5, 0, 0.5, 0);
        position = UDim2.new(0.5, 0, 0.5, 0);
        distance = 96;
        aspectRatio = 1.7777777777777777;
        cameraCFrame = workspace.CurrentCamera.CFrame;
        fieldOfView = 70;
    }), arg1)
    return function() -- Line 17
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end