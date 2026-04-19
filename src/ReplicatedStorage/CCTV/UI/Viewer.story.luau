-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUB3VubW91bnQHcmVxdWlyZQZWaWV3ZXIGc2NyaXB0BlBhcmVudAVtb3VudA1jcmVhdGVFbGVtZW50BHNpemUIcG9zaXRpb24IZGlzdGFuY2ULYXNwZWN0UmF0aW8JY2FtZXJhVGFnC2ZpZWxkT2ZWaWV3BVVEaW0yA25ldwpDQ1RWQ2FtZXJhBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAADAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDAQARAAEYAAAAAAABEgAAAAALAQEAAAA2pAEBAAAAAECkAwQAAAAwQE0DAyQFAAAATQIDBgIAAACfAQIC+wIAAE0CAuQGAAAA+wMAAE0DA8oHAAAAUgQBAOIFDgCkBhEAAEDwgG8HEgCMCAAAbwkSAIwKAACfBgUCMAYFDwgAAACkBhEAAEDwgG8HEwCMCAAAbwkTAIwKAACfBgUCMAYF2wkAAACMBmAAMAYFdQoAAABvBhQAMAYFiQsAAABvBhUAMAYFSAwAAACMBkYAMAYFgQ0AAACfAwMCUgQAAJ8CAwLZAwAAEgIAABIAAgCCAwIAFgMCBAAAAEADAwMEBAAAMEADBQMGAwcDCAMJAwoDCwMMAw0FBggJCgsMDQMOAw8EAEDwgAKamZmZmZnpPwIAAAAAAADgPwIcx3Ecx3H8PwMQAQAEAAEYAAAAAAAAAAAAAQAAAQAAAAABAAAAAAAAAAABAAAAAAAAAAABAAABAAABAAABAAD6CPcLAAAABQAAAAADAAABAgAPowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICwAIHABIAAQCCAgIACAMRBAAAAEADEgMTAwIEAABAQAMUBgEBAQEAARgAAAAAAAAAAQAAAAACAAABAAAAAAI4UautNh9XPl3eFVZmR9pJSEm82QqVwaw=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:58
-- Luau version 6, Types version 3
-- Time taken: 0.001095 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Viewer), {
        size = UDim2.new(0.8, 0, 0.8, 0);
        position = UDim2.new(0.5, 0, 0.5, 0);
        distance = 96;
        aspectRatio = 1.7777777777777777;
        cameraTag = "CCTVCamera";
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