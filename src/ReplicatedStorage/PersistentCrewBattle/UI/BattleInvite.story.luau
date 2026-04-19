-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBGluaXQNY3JlYXRlRWxlbWVudBdiYXR0bGVOdW1QbGF5ZXJzUGVyVGVhbQZyYW5rZWQGcmVuZGVyC3dpbGxVbm1vdW50B3VubW91bnQJQ29tcG9uZW50A0FwcAZleHRlbmQHcmVxdWlyZQxCYXR0bGVJbnZpdGUGc2NyaXB0BlBhcmVudAVtb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UFUm9hY3QABgEBAAAAAAGCAAEAAAAHAQEYAAcAAAAABQECAAAADfsBAABNAQHKAAAAAPsCAQDiAwMAjAQDADAEA3MBAAAAqQQBADAEA/ICAAAAnwEDAIIBAAAEAwIDAwMEBQIBAgAIBQEYAAAAAAABAAABAAD+AAkAAAAAAQEAAAAAAYIAAQAAABEGARgAEQAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMHABQAARgAAAAAAAEVAAAAAAYBAQAAACn7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQMEjQUAAACfAgICwAMJADADARMKAAAA2QMBABICAAASAAIAMAMBgAsAAADAAwwAMAMBNA0AAAD7AwAATQMD5A4AAAD7BAAATQQEyg8AAABSBQEAnwQCAlIFAACfAwMC2QQDABICAAASAAMAggQCABADCAMJAwoDCwQAADBAAwwDDQQAAGBAAw4GAAMBAwUGAgMGAw8DAgQAAQIDBAABGAAAAAAAAAABAAAAAAAAAAABAAABAAAAAAkAAAIAAAAAAAAAAAABAAAABQAAAAADAAABAgAPowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICwAIHABIAAQCCAgIACAMQBAAAAEADEQMSAwsEAABAQAMTBgQBBAEAARgAAAAAAAAAAQAAAAACAAABAAAAAAVpL/gzEJhZFIw7iw7FetzwGTfvR1vrkjI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:58
-- Luau version 6, Types version 3
-- Time taken: 0.001596 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local BattleInvite_upvr = require(script.Parent.BattleInvite)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: BattleInvite_upvr (readonly)
        ]]
        return Roact_upvr.createElement(BattleInvite_upvr, {
            battleNumPlayersPerTeam = 3;
            ranked = true;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 17
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 20
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end