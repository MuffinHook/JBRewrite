-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUBGluaXQNY3JlYXRlRWxlbWVudARzaXplBVVEaW0yA25ldwZyZW5kZXILd2lsbFVubW91bnQHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlCVRyYWRlQ2hhdAZzY3JpcHQGUGFyZW50BW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAAGAQEAAAAAAYIAAQAAAAcBARgABwAAAAAJAQIAAAAQ+wEAAE0BAcoAAAAA+wIBAOIDAgCkBAUAABAwgIwFAQCMBgAAjAcBAIwIAACfBAUCMAQDDwEAAACfAQMAggEAAAYDAgMDBQEBAwQDBQQAEDCAAAgGARgAAAAAAAEAAAAAAAAAAP8ACQAAAAABAQAAAAABggABAAAADQcBGAANAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAwgAEAABGAAAAAAAAREAAAAABgEBAAAAKfsBAABNAQGIAAAAAG8DAQC8AQGcAgAAAJ8BAwKkAgQAAAAwQKQEBwAAAGBATQQEJAgAAABNAwQKBQAAAJ8CAgLAAwkAMAMBEwoAAADZAwEAEgIAABIAAgAwAwGACwAAAMADDAAwAwE0DQAAAPsDAABNAwPkDgAAAPsEAABNBATKDwAAAFIFAQCfBAICUgUAAJ8DAwLZBAMAEgIAABIAAwCCBAIAEAMJAwoDCwMMBAAAMEADDQMOBAAAYEADDwYAAwEDBgYCAwcDEAMCBAABAgMEAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAEAAAAABQAAAgAAAAAAAAAAAAEAAAAFAAAAAAMAAAECAA+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAhBgAAAJ8BAgLAAgcAEgABAIICAgAIAxEEAAAAQAMSAxMDDAQAAEBAAxQGBAEEAQABGAAAAAAAAAABAAAAAAIAAAEAAAAABa2f0xyJ0H1M7AVKfuf81HTdh8Ron1u5HQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:40
-- Luau version 6, Types version 3
-- Time taken: 0.001545 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local TradeChat_upvr = require(script.Parent.TradeChat)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: TradeChat_upvr (readonly)
        ]]
        return Roact_upvr.createElement(TradeChat_upvr, {
            size = UDim2.new(1, 0, 1, 0);
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 13
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 16
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end