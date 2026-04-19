-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMiBGluaXQFcHJpbnQRY2xpY2tlZCBjb250cmFjdHMHb25DbGljawRuYW1lB2ltYWdlSWQKVGVhbVN3aXRjaAVjb3VudAlDb250cmFjdHMGR2FyYWdlBlNlYXNvbg1jcmVhdGVFbGVtZW50B2J1dHRvbnMEc2l6ZQthbmNob3JQb2ludAhwb3NpdGlvbgVVRGltMgNuZXcHVmVjdG9yMgZyZW5kZXILd2lsbFVubW91bnQHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlDVNpZGViYXJIb2xkZXIGc2NyaXB0BlBhcmVudAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QABwEBAAAAAAGCAAEAAAAHAQEYAAcAAAAABAEAAAAABqQBAQAAAABAbwICAFIDAACfAQMBggABAAMDAgQAAABAAwMAEgQBGAAAAAAAARMAAAAACgECAAAASP8BAAAEAAAA4gICAG8DAwAwAwJaAAAAAG8DBAAwAwK2AQAAAOIDBwBvBAgAMAQDWgAAAABvBAkAMAQDtgEAAACMBAMAMAQDGgUAAADABAoAMAQDbgYAAADiBAIAbwULADAFBFoAAAAAbwUMADAFBLYBAAAA4gUCAG8GDQAwBgVaAAAAAG8GCQAwBgW2AQAAAMUBAgUBAAAA+wIAAE0CAsoOAAAA+wMBAOIEEwAwAQTzDwAAAKQFFgAAVECBbwYXAIwHAACMCAEAjAkAAJ8FBQIwBQQPEAAAAKQFGQAAVICBjAYAAIwHAQCfBQMCMAUECBEAAACkBRYAAFRAgYwGAACMBwAAbwgaAIwJAACfBQUCMAUE2xIAAACfAgMAggIAABsDBQMGBQIAAQMHAgAAsFCrTPJBAwgDBAUEAAEFBgMJAgAA0L7c2PZBBgEDCgIAAOAmq0zyQQMLAwwDDQMOAw8DEAUEDxAREgMRAxIEAFRAgQKamZmZmZnJPwMTBABUgIECAAAAAAAA4D8BAQgUARgAAAEBAAABAAACAQAAAQAAAQAAAQAABAEAAAEAAAIBAAABAAAAAAMAAAAAAQABAAAAAAAAAAABAAAAAAAAAQAAAAAAAAAA/AAJAAAAAAEBAAAAAAGCAAEAAAAmFQEYACYAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDFgApAAEYAAAAAAABKgAAAAAGAQEAAAAp+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBApAQHAAAAYEBNBAQkCAAAAE0DBGgFAAAAnwICAsADCQAwAwETCgAAANkDAQASAgAAEgACADADAYALAAAAwAMMADADATQNAAAA+wMAAE0DA+QOAAAA+wQAAE0EBMoPAAAAUgUBAJ8EAgJSBQAAnwMDAtkEAwASAgAAEgADAIIEAgAQAxcDGAMZAxoEAAAwQAMbAxwEAABgQAMdBgADAQMUBgMDFQMeAwwEAAIDBAQAARgAAAAAAAAAAQAAAAAAAAAAAQAAAQAAAAAeAAACAAAAAAAAAAAAAQAAAAUAAAAAAwAAAQIAD6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAsACBwASAAEAggICAAgDHwQAAABAAyADIQMaBAAAQEADIgYFAQUBAAEYAAAAAAAAAAEAAAAAAgAAAQAAAAAGQIayiairsFawKz6RtXOK3TCepf1yQtiI

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:49
-- Luau version 6, Types version 3
-- Time taken: 0.003037 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local SidebarHolder_upvr = require(script.Parent.SidebarHolder)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: SidebarHolder_upvr (readonly)
        ]]
        return Roact_upvr.createElement(SidebarHolder_upvr, {
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
            size = UDim2.new(0.2, 0, 1, 0);
            anchorPoint = Vector2.new(0, 1);
            position = UDim2.new(0, 0, 0.5, 0);
        })
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 38
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 41
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end