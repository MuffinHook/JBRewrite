-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQB3VubW91bnQNY3JlYXRlQmluZGluZwdyZXF1aXJlBFBsb3QGc2NyaXB0BlBhcmVudAVtb3VudA1jcmVhdGVFbGVtZW50BHNpemUIcG9zaXRpb24Gd2luZG93BVVEaW0yA25ldwRFelVpEUZpbmRGaXJzdEFuY2VzdG9yBVJvYWN0AAMCAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMBABEAARgAAAAAAAESAAAAAA0BAQAAADn7AQAATQEBMQAAAACMAgAAnwECA6QDAgAAABBApAUFAAAAQEBNBQUkBgAAAE0EBZADAAAAnwMCAvsEAABNBATkBwAAAPsFAABNBQXKCAAAAFIGAwDiBwwApAgPAAA40IBvCRAAjAoAAG8LEACMDAAAnwgFAjAIBw8JAAAApAgPAAA40IBvCREAjAoAAG8LEQCMDAAAnwgFAjAIB9sKAAAA/wgAAAQAAACMCQAAjAoAAIwLZACMDGQAxQgJBQEAAAAwCAcFCwAAAJ8FAwJSBgAAnwQDAtkFAAASAgAAEgAEAIIFAgASAwIDAwQAABBAAwQDBQQAAEBAAwYDBwMIAwkDCgMLBQMJCgsDDAMNBAA40IACAAAAAAAA4D8CAAAAAAAA0D8BAAUAARgAAAAAAAIAAAAAAAAAAAEAAAEAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAP0F+ggAAAAGAAAAAAMAAAECABGjAAAApAABAAAAAEBvAgIAvAAAfAMAAACfAAMCpAEFAAAAQEBNAgAkBgAAAE0CAiEHAAAAnwECAsACCAASAAEAggICAAkDBQQAAABAAw4DDwMDBAAAQEADBgMQBgEBAQEAARgAAQAAAAAAAQAAAAAAAAIAAAEAAAAAAitTFZT/dXZzHBT1ytdmypVbSwLgGZd/lQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:46
-- Luau version 6, Types version 3
-- Time taken: 0.001765 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_createBinding_result1, _ = Roact_upvr.createBinding(0)
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Plot), {
        size = UDim2.new(0.5, 0, 0.5, 0);
        position = UDim2.new(0.25, 0, 0.25, 0);
        window = {0, 0, 100, 100};
    }), arg1)
    return function() -- Line 17
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end