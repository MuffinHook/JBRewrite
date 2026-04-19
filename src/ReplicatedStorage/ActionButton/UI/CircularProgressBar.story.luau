-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVDWNyZWF0ZUJpbmRpbmcIcHJvZ3Jlc3MOdXBkYXRlUHJvZ3Jlc3MEaW5pdA1jcmVhdGVFbGVtZW50D3Byb2dyZXNzQmluZGluZwZyZW5kZXILd2lsbFVubW91bnQHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQZzY3JpcHQGUGFyZW50E0NpcmN1bGFyUHJvZ3Jlc3NCYXIFUm9hY3QABgMBAQAAAA77AQAATQEBMQAAAABvAgEAnwECAzABAAQCAAAAMAIALgMAAABNAQAuAwAAAG8CBACfAQIBggABAAUDAQIzMzMzMzPTPwMCAwMCmpmZmZmZuT8ABwQBGAAAAAAAAAAAAAEAAAABCAAAAAAFAQIAAAAL+wEAAE0BAcoAAAAA+wIBAOIDAgBNBAAEAwAAADAEA3wBAAAAnwEDAIIBAAAEAwUDBgUBAQMCAAsHARgAAAAAAAEAAAD/AAwAAAAAAQEAAAAAAYIAAQAAABAIARgAEAAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMJABMAARgAAAAAAAEUAAAAAAUBAgAAACH7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCwAIDABICAAAwAgETBAAAAMACBQASAgAAEgIBADACAYAGAAAAwAIHADACATQIAAAA+wIAAE0CAuQJAAAA+wMAAE0DA8oKAAAAUgQBAJ8DAgJSBAAAnwIDAtkDAwASAgAAEgACAIIDAgALAwoDCwMMBgADBAYBAwcGAgMIAw0DBQQAAQIDBQABGAAAAAAAAAABAAAABAAAAAAFAAACAAAAAAAAAAAAAQAAAAYAAAAABAAAAQIAGaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQKQCBwAAAGBATQICJAgAAABNAgLZCQAAAJ8BAgKkAgUAAABAQE0DACEKAAAAnwICAsADCwASAAIAEgABAIIDAgAMAw4EAAAAQAMPAxADEQQAAEBAAxIEAABgQAMTAxQDFQYEAQQBAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAgAAAAEAAAAABU6HtbPGEERhHL/kOX+5Ups+n6LHfEPfsg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:57
-- Luau version 6, Types version 3
-- Time taken: 0.002321 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local CircularProgressBar_upvr = require(script.Parent.CircularProgressBar)
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: CircularProgressBar_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
        --[[ Upvalues[1]:
            [1]: Roact_upvr (copied, readonly)
        ]]
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0.3)
        arg1_2.progress = any_createBinding_result1
        arg1_2.updateProgress = any_createBinding_result2
        arg1_2.updateProgress(0.1)
    end
    function any_extend_result1.render(arg1_3) -- Line 11
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: CircularProgressBar_upvr (copied, readonly)
        ]]
        return Roact_upvr.createElement(CircularProgressBar_upvr, {
            progressBinding = arg1_3.progress;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 16
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 19
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end