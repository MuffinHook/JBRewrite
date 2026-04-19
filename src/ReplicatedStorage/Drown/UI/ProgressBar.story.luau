-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRBGluaXQNY3JlYXRlRWxlbWVudAZyZW5kZXILd2lsbFVubW91bnQHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQZzY3JpcHQGUGFyZW50C1Byb2dyZXNzQmFyBVJvYWN0AAYBAQAAAAABggABAAAABwEBGAAHAAAAAAQBAgAAAAj7AQAATQEBygAAAAD7AgEA/wMAAAAAAACfAQMAggEAAAEDAgAIAwEYAAAAAAAAAAAJAAAAAAEBAAAAAAGCAAEAAAALBAEYAAsAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDBQAOAAEYAAAAAAABDwAAAAAFAQIAAAAg+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAsACAwAwAgETBAAAAMACBQASAgAAEgIBADACAYAGAAAAwAIHADACATQIAAAA+wIAAE0CAuQJAAAA+wMAAE0DA8oKAAAAUgQBAJ8DAgJSBAAAnwIDAtkDAwASAgAAEgACAIIDAgALAwYDBwMIBgADAQYBAwMGAgMEAwkDAgQAAQIDBQABGAAAAAAAAAABAAABAAAAAAMAAAIAAAAAAAAAAAABAAAABgAAAAAEAAABAgAZowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBApAIHAAAAYEBNAgIkCAAAAE0CAmYJAAAAnwECAqQCBQAAAEBATQMAIQoAAACfAgICwAMLABIAAgASAAEAggMCAAwDCgQAAABAAwsDDAMNBAAAQEADDgQAAGBAAw8DEAMRBgQBBAEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAACAAAAAQAAAAAFmygK2CfCQwO8s0k4h2McdOswHayp7GDZ

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:31
-- Luau version 6, Types version 3
-- Time taken: 0.001352 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local ProgressBar_upvr = require(script.Parent.ProgressBar)
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: ProgressBar_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: ProgressBar_upvr (copied, readonly)
        ]]
        return Roact_upvr.createElement(ProgressBar_upvr, {})
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 11
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 14
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end