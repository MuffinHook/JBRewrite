-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdBGluaXQUb3RoZXJUcmFkZVNlcnZlckluZm8FVURpbTIJZnJvbVNjYWxlBHNpemUUdmVydGljYWxQYWRkaW5nUmF0aW8LYXNwZWN0UmF0aW8NY3JlYXRlRWxlbWVudAZBc3BlY3QXVUlBc3BlY3RSYXRpb0NvbnN0cmFpbnQLQXNwZWN0UmF0aW8GcmVuZGVyC3dpbGxVbm1vdW50B3VubW91bnQJQ29tcG9uZW50A0FwcAZleHRlbmQHcmVxdWlyZRRPdGhlclRyYWRlU2VydmVySXRlbQZzY3JpcHQGUGFyZW50BW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAVUcmFkZQRUZXN0Fk90aGVyVHJhZGVTZXJ2ZXJVSURhdGEABgEBAAAAAAGCAAEAAAAIAQEYAAgAAAAACgEDAAAAJPsCAABNAgLIAAAAABMBAgCkAgMAAAgQgG8DBABvBAUAnwIDAjACAQ8GAAAAjAKAADACAcYHAAAAbwIIADACAYkJAAAA+wIBAE0CAsoKAAAA+wMCAFIEAQDiBQwA+wYBAE0GBsoKAAAAbwcNAOIIDwCMCQgAMAkIaQ4AAACfBgMCMAYFLwsAAACfAgQAggIAABADAgMDAwQEAAgQgAKamZmZmZnpPwKamZmZmZm5PwMFAwYCHMdxHMdx/D8DBwMIAwkFAQsDCgMLBQEOAAkMARgAAAAAAQAAAAAAAAEAAAEAAAEAAAAAAAEAAAAAAQAA/wAA/wAKAAAAAAEBAAAAAAGCAAEAAAAUDQEYABQAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDDgAXAAEYAAAAAAABGAAAAAAGAQIAAAAq+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBApAQHAAAAYEBNBAQkCAAAAE0DBBQFAAAAnwICAsADCQAwAwETCgAAANkDAQASAgEAEgIAABIAAgAwAwGACwAAAMADDAAwAwE0DQAAAPsDAABNAwPkDgAAAPsEAABNBATKDwAAAFIFAQCfBAICUgUAAJ8DAwLZBAMAEgIAABIAAwCCBAIAEAMPAxADEQMSBAAAMEADEwMUBAAAYEADFQYAAwEDDAYCAw0DFgMIBAABAgMFAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAEAAAAAAAsAAAIAAAAAAAAAAAABAAAABgAAAAAEAAABAgAZowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICpAIFAAAAQEBNAwC7BwAAAE0DA3wIAAAATQMD5gkAAACfAgICwAMKABIAAQASAAIAggMCAAsDFwQAAABAAxgDGQMSBAAAQEADGgMbAxwDHQYEAQQBAAEYAAAAAAAAAAEAAAAAAQAAAAAAAAAAAgAAAAEAAAAABe/E5ZNgju4P4O8OFVphaf2f3PLn3QCPkg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:30
-- Luau version 6, Types version 3
-- Time taken: 0.002781 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local OtherTradeServerUIData_upvr = require(ReplicatedStorage.Trade.Test.OtherTradeServerUIData)
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: OtherTradeServerUIData_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
    end
    local OtherTradeServerItem_upvr = require(script.Parent.OtherTradeServerItem)
    function any_extend_result1.render(arg1_3) -- Line 9
        --[[ Upvalues[3]:
            [1]: OtherTradeServerUIData_upvr (copied, readonly)
            [2]: Roact_upvr (copied, readonly)
            [3]: OtherTradeServerItem_upvr (readonly)
        ]]
        local _1 = OtherTradeServerUIData_upvr.otherTradeServerInfo[1]
        _1.size = UDim2.fromScale(0.8, 0.1)
        _1.verticalPaddingRatio = 128
        _1.aspectRatio = 1.7777777777777777
        return Roact_upvr.createElement(OtherTradeServerItem_upvr, _1, {
            Aspect = Roact_upvr.createElement("UIAspectRatioConstraint", {
                AspectRatio = 8;
            });
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 20
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 23
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end