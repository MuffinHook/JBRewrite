-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYDWNyZWF0ZUVsZW1lbnQFcHJvYnMGQ29tbW9uBFJhcmUJVWx0cmFSYXJlBEVwaWMJTGVnZW5kYXJ5BnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUQQnJpZWZjYXNlRGlzcGxheQZzY3JpcHQGUGFyZW50BW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdA1SZXdhcmRTcGlubmVyCkVudW1SYXJpdHkABQcBAwAAACT7AQAATQEBygAAAAD7AgEA4gMCAP8EBAAAAAAA+wUCAE0FBXMDAAAAjAZLAGoGBAX7BQIATQUFpwQAAACMBhQAagYEBfsFAgBNBQXhBQAAAIwGBQBqBgQF+wUCAE0FBbwGAAAAjAYAAGoGBAX7BQIATQUFuQcAAACMBgAAagYEBTAEA/wBAAAAnwEDAIIBAAAIAwEDAgUBAQMDAwQDBQMGAwcACAgBGAAAAAAAAQABAAAAAAEAAAAAAQAAAAABAAAAAAEAAAAA+wD/AAkAAAAAAQEAAAAAAYIAAQAAABMJARgAEwAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMKABYAARgAAAAAAAEXAAAAAAYBAgAAACf7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQMEQAUAAACfAgIC2QMAABICAAASAAIAEgIBADADAYAJAAAAwAMKADADATQLAAAA+wMAAE0DA+QMAAAA+wQAAE0EBMoNAAAAUgUBAJ8EAgJSBQAAnwMDAtkEAgASAgAAEgADAIIEAgAOAwsDDAMNAw4EAAAwQAMPAxAEAABgQAMRAwgGAQMJAxIDAQMAAQIFAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAsAAAIAAAAAAAAAAAABAAAABgAAAAAEAAABAgAXowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICpAIFAAAAQEBNAwC3BwAAAE0DA0oIAAAAnwICAsADCQASAAEAEgACAIIDAgAKAxMEAAAAQAMUAxUDDgQAAEBAAxYDFwMYBgMBAwEAARgAAAAAAAAAAQAAAAABAAAAAAAAAgAAAAEAAAAABI3tHPD9ooMIMIMvFYl9pOL99QuEvyl28Q==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:11
-- Luau version 6, Types version 3
-- Time taken: 0.002024 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local EnumRarity_upvr = require(ReplicatedStorage.RewardSpinner.EnumRarity)
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: EnumRarity_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local BriefcaseDisplay_upvr = require(script.Parent.BriefcaseDisplay)
    function any_extend_result1.render(arg1_2) -- Line 8
        --[[ Upvalues[3]:
            [1]: Roact_upvr (copied, readonly)
            [2]: BriefcaseDisplay_upvr (readonly)
            [3]: EnumRarity_upvr (copied, readonly)
        ]]
        return Roact_upvr.createElement(BriefcaseDisplay_upvr, {
            probs = {
                [EnumRarity_upvr.Common] = 75;
                [EnumRarity_upvr.Rare] = 20;
                [EnumRarity_upvr.UltraRare] = 5;
                [EnumRarity_upvr.Epic] = 0;
                [EnumRarity_upvr.Legendary] = 0;
            };
        })
    end
    function any_extend_result1.willUnmount(arg1_3) -- Line 19
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 22
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end