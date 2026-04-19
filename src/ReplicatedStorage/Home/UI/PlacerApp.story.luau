-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXBGluaXQNY3JlYXRlRWxlbWVudA1TdG9yZVByb3ZpZGVyBXN0b3JlC2FzcGVjdFJhdGlvFHZlcnRpY2FsUGFkZGluZ1JhdGlvCXNob3dQbGFjZQZyZW5kZXIHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlCVBsYWNlckFwcARIb21lAlVJCWhvbWVTdG9yZQVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QKUm9hY3RSb2R1eAAFAQEAAAAAAYIAAQAAAAkBARgACQAAAAAJAQQAAAAf+wEAAE0BAcoAAAAA+wIBAE0CAroBAAAA4gMDAPsEAgAwBAN+AgAAAP8EAAABAAAA+wUAAE0FBcoAAAAA+wYDAOIHBwCMCAUAMAgHiQQAAABvCAgAMAgHxgUAAACpCAEAMAgHCgYAAACfBQMAxQQFAAEAAACfAQQAggEAAAkDAgMDAwQFAQIDBQMGAwcFAwQFBgKamZmZmZk5QAALCAEYAAAAAAAAAAEAAAEAAQAAAAABAAABAAABAAD9AAD9AA0AAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDCQAZAAEYAAAAAAABGgAAAAAHAQMAAAAx+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBA+wQBAE0EBGoGAAAATQQEXAcAAABNAwTLBQAAAJ8CAgKkAwQAAAAwQPsEAQBNBARqBgAAAE0EBIIIAAAAnwMCAsAECQAwBAETCgAAANkEAQASAgAAEgICABIAAwASAAIAMAQBgAsAAAD7BAAATQQE5AwAAAD7BQAATQUFyg0AAABSBgEAnwUCAlIGAACfBAMC2QUCABICAAASAAQAggUCAA4DCgMLAwwDDQQAADBAAw4DDwMQAxEGAAMBAwgDEgMCAwABAgUAARgAAAAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAQAAAgAAAAAAAA0AAAAAAAAAAAABAAAABgAAAAAEAAABAgAWowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICpAIFAAAAQEBNAwAtBwAAAJ8CAgLAAwgAEgABABIAAAASAAIAggMCAAkDEwQAAABAAxQDFQMNBAAAQEADFgMXBgMBAwEAARgAAAAAAAAAAQAAAAABAAAAAAIAAAAAAQAAAAAETDIp+b6WrC9mBeTxiqDLdDwqPo1+9kP4

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:27
-- Luau version 6, Types version 3
-- Time taken: 0.001770 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RoactRodux_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
    end
    local homeStore_upvr = require(ReplicatedStorage_upvr.Home.homeStore)
    local PlacerApp_upvr = require(ReplicatedStorage_upvr.Home.UI.PlacerApp)
    function any_extend_result1.render(arg1_3) -- Line 11
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: homeStore_upvr (readonly)
            [4]: PlacerApp_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = homeStore_upvr;
        }, {Roact_upvr.createElement(PlacerApp_upvr, {
            aspectRatio = 5;
            verticalPaddingRatio = 25.6;
            showPlace = true;
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 25
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end