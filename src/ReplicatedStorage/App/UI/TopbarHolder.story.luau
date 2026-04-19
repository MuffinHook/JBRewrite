-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcBGluaXQFcHJpbnQRY2xpY2tlZCBjb250cmFjdHMHb25DbGljawRuYW1lB2ltYWdlSWQKVGVhbVN3aXRjaAVjb3VudAlDb250cmFjdHMGR2FyYWdlBlNlYXNvbg1jcmVhdGVFbGVtZW50B2J1dHRvbnMGcmVuZGVyC3dpbGxVbm1vdW50B3VubW91bnQJQ29tcG9uZW50A0FwcAZleHRlbmQHcmVxdWlyZQxUb3BiYXJIb2xkZXIGc2NyaXB0BlBhcmVudAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QABwEBAAAAAAGCAAEAAAAHAQEYAAcAAAAABAEAAAAABqQBAQAAAABAbwICAFIDAACfAQMBggABAAMDAgQAAABAAwMAEgQBGAAAAAAAARMAAAAABwECAAAAL/8BAAAEAAAA4gICAG8DAwAwAwJaAAAAAG8DBAAwAwK2AQAAAOIDBwBvBAgAMAQDWgAAAABvBAkAMAQDtgEAAACMBAMAMAQDGgUAAADABAoAMAQDbgYAAADiBAIAbwULADAFBFoAAAAAbwUMADAFBLYBAAAA4gUCAG8GDQAwBgVaAAAAAG8GCQAwBgW2AQAAAMUBAgUBAAAA+wIAAE0CAsoOAAAA+wMBAOIEEAAwAQTzDwAAAJ8CAwCCAgAAEQMFAwYFAgABAwcCAACwUKtM8kEDCAMEBQQAAQUGAwkCAADQvtzY9kEGAQMKAgAA4CarTPJBAwsDDAMNBQEPAQEIDgEYAAABAQAAAQAAAgEAAAEAAAEAAAEAAAQBAAABAAACAQAAAQAAAAADAAAAAAEA/wAJAAAAAAEBAAAAAAGCAAEAAAAjDwEYACMAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDEAAmAAEYAAAAAAABJwAAAAAGAQEAAAAp+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBApAQHAAAAYEBNBAQkCAAAAE0DBGMFAAAAnwICAsADCQAwAwETCgAAANkDAQASAgAAEgACADADAYALAAAAwAMMADADATQNAAAA+wMAAE0DA+QOAAAA+wQAAE0EBMoPAAAAUgUBAJ8EAgJSBQAAnwMDAtkEAwASAgAAEgADAIIEAgAQAxEDEgMTAxQEAAAwQAMVAxYEAABgQAMXBgADAQMOBgMDDwMYAwwEAAIDBAQAARgAAAAAAAAAAQAAAAAAAAAAAQAAAQAAAAAbAAACAAAAAAAAAAAAAQAAAAUAAAAAAwAAAQIAD6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAsACBwASAAEAggICAAgDGQQAAABAAxoDGwMUBAAAQEADHAYFAQUBAAEYAAAAAAAAAAEAAAAAAgAAAQAAAAAGMpHeO5/DOpv9hi8zapL2b0KJyU8AVbQ6

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:50
-- Luau version 6, Types version 3
-- Time taken: 0.002310 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local TopbarHolder_upvr = require(script.Parent.TopbarHolder)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: TopbarHolder_upvr (readonly)
        ]]
        return Roact_upvr.createElement(TopbarHolder_upvr, {
            buttons = {{
                name = "TeamSwitch";
                imageId = 4912231691;
            }, {
                name = "Contracts";
                imageId = 6132976621;
                count = 3;
                onClick = function(arg1_4) -- Line 18, Named "onClick"
                    print("clicked contracts", arg1_4)
                end;
            }, {
                name = "Garage";
                imageId = 4912231022;
            }, {
                name = "Season";
                imageId = 6132976621;
            }};
        })
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 35
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 38
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end