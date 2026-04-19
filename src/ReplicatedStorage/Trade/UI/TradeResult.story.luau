-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdBHR5cGUFdmFsdWUOc2V0VHJhZGVSZXN1bHQHc3VjY2VzcwV0aXRsZQRib2R5BUhlbGxvBVdvcmxkCGRpc3BhdGNoBGluaXQNY3JlYXRlRWxlbWVudA1TdG9yZVByb3ZpZGVyBXN0b3JlBnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmULVHJhZGVSZXN1bHQGc2NyaXB0BlBhcmVudAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QKUm9hY3RSb2R1eAAGBgEBAAAAFfsBAADiAwIAbwQDADAEA3EAAAAA4gQHAKkFAQAwBQT6BAAAAG8FCAAwBQSaBQAAAG8FCQAwBQRHBgAAADAEA8wBAAAAvAEBTAoAAACfAQMBggABAAsDAQMCBQIAAQMDAwQDBQMGBQMEBQYDBwMIAwkACQoBGAAAAQAAAQEAAAEAAAEAAP0A/gAACAoAAAAACAEEAAAAF/sBAABNAQHKAAAAAPsCAQBNAgK6AQAAAOIDAwD7BAIAMAQDfgIAAAD/BAAAAQAAAPsFAABNBQXKAAAAAPsGAwD/BwAAAAAAAJ8FAwDFBAUAAQAAAJ8BBACCAQAABAMLAwwDDQUBAgATDgEYAAAAAAAAAAEAAAEAAQAAAAAAAAAA/QAUAAAAAAEBAAAAAAGCAAEAAAAaDwEYABoAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDEAAdAAEYAAAAAAABHgAAAAAHAQMAAAA0+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBA+wMBAE0DA8EBAAAATQMDfgUAAACfAgICpAMEAAAAMECkBQgAAABwQE0FBSQJAAAATQQFOQYAAACfAwIC2QQAABIAAgAwBAETCgAAANkEAQASAgAAEgICABIAAgASAAMAMAQBgAsAAADABAwAMAQBNA0AAAD7BAAATQQE5A4AAAD7BQAATQUFyg8AAABSBgEAnwUCAlIGAACfBAMC2QUDABICAAASAAQAggUCABADEQMSAxMDFAQAADBAAw0DFQMWBAAAcEADFwMKAw4GAgMPAxgDCwQAAQIDBQABGAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAAEAAAAKAAAAAAAABwAAAgAAAAAAAAAAAAEAAAAGAAAAAAQAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAhBgAAAJ8BAgKkAgUAAABAQE0DAC0HAAAAnwICAsADCAASAAEAEgAAABIAAgCCAwIACQMZBAAAAEADGgMbAxQEAABAQAMcAx0GBAEEAQABGAAAAAAAAAABAAAAAAEAAAAAAgAAAAABAAAAAAWx0s1U5VXS87QMgkpa6aaOwcraIIMWp1U=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:47
-- Luau version 6, Types version 3
-- Time taken: 0.001904 seconds

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
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    function any_extend_result1.init(arg1_2) -- Line 9
        --[[ Upvalues[1]:
            [1]: store_upvr (readonly)
        ]]
        store_upvr:dispatch({
            type = "setTradeResult";
            value = {
                success = true;
                title = "Hello";
                body = "World";
            };
        })
    end
    local TradeResult_upvr = require(script.Parent.TradeResult)
    function any_extend_result1.render(arg1_3) -- Line 19
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: store_upvr (readonly)
            [4]: TradeResult_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(TradeResult_upvr, {})})
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 26
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 29
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end