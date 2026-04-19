-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfBHR5cGUGdXNlcklkC2Rpc3BsYXlOYW1lBXJlYWR5DnVwZGF0ZVRyYWRlck1lBWJhZGNjCGRpc3BhdGNoEHVwZGF0ZVRyYWRlclRoZW0JYXNpbW8zMDg5BXZhbHVlDnNldFRyYWRlQWN0aXZlBGluaXQNY3JlYXRlRWxlbWVudA1TdG9yZVByb3ZpZGVyBXN0b3JlBnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUFVHJhZGUGc2NyaXB0BlBhcmVudAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QKUm9hY3RSb2R1eAAGBQEBAAAALvsBAADiAwQAbwQFADAEA3EAAAAAbwQGADAEA4YBAAAAbwQHADAEA3cCAAAAqQQBADAEA88DAAAAvAEBTAgAAACfAQMB+wEAAOIDBABvBAkAMAQDcQAAAABvBAoAMAQDhgEAAABvBAsAMAQDdwIAAACpBAAAMAQDzwMAAAC8AQFMCAAAAJ8BAwH7AQAA4gMNAG8EDgAwBANxAAAAAKkEAQAwBAPMDAAAALwBAUwIAAAAnwEDAYIAAQAPAwEDAgMDAwQFBAABAgMDBQIAAAAAluY+QQMGAwcDCAIAAACAa6ZFQQMJAwoFAgAMAwsACQwBGAAAAQAAAQAAAQAAAQAA/AAABgABAAABAAABAAABAAD8AAAGAAEAAAEAAP4AAAQKAAAAAAgBBAAAABf7AQAATQEBygAAAAD7AgEATQICugEAAADiAwMA+wQCADAEA34CAAAA/wQAAAEAAAD7BQAATQUFygAAAAD7BgMA/wcAAAAAAACfBQMAxQQFAAEAAACfAQQAggEAAAQDDQMOAw8FAQIAGxABGAAAAAAAAAABAAABAAEAAAAAAAAAAP0AHAAAAAABAQAAAAABggABAAAAIhEBGAAiAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAxIAJQABGAAAAAAAASYAAAAABwEDAAAANPsBAABNAQGIAAAAAG8DAQC8AQGcAgAAAJ8BAwKkAgQAAAAwQPsDAQBNAwPBAQAAAE0DA34FAAAAnwICAqQDBAAAADBApAUIAAAAcEBNBQUkCQAAAE0EBbsGAAAAnwMCAtkEAAASAAIAMAQBEwoAAADZBAEAEgIAABICAgASAAIAEgADADAEAYALAAAAwAQMADAEATQNAAAA+wQAAE0EBOQOAAAA+wUAAE0FBcoPAAAAUgYBAJ8FAgJSBgAAnwQDAtkFAwASAgAAEgAEAIIFAgAQAxMDFAMVAxYEAAAwQAMPAxcDGAQAAHBAAxkDDAMQBgIDEQMaAw0EAAECAwUAARgAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAABAAAAEgAAAAAAAAcAAAIAAAAAAAAAAAABAAAABgAAAAAEAAABAgAWowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICpAIFAAAAQEBNAwAtBwAAAJ8CAgLAAwgAEgABABIAAAASAAIAggMCAAkDGwQAAABAAxwDHQMWBAAAQEADHgMfBgQBBAEAARgAAAAAAAAAAQAAAAABAAAAAAIAAAAAAQAAAAAFtGvYwGQdh2mVFQ+5MetvD8Rzz7SGr7LB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:35
-- Luau version 6, Types version 3
-- Time taken: 0.002049 seconds

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
            type = "updateTraderMe";
            userId = 2025110;
            displayName = "badcc";
            ready = true;
        })
        store_upvr:dispatch({
            type = "updateTraderThem";
            userId = 2837719;
            displayName = "asimo3089";
            ready = false;
        })
        store_upvr:dispatch({
            type = "setTradeActive";
            value = true;
        })
    end
    local Trade_upvr = require(script.Parent.Trade)
    function any_extend_result1.render(arg1_3) -- Line 27
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: store_upvr (readonly)
            [4]: Trade_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(Trade_upvr, {})})
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 34
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 37
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end