-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQBE5hbWUQSHVtYW5vaWRSb290UGFydAR3YXJuGUh1bWFub2lkUm9vdFBhcnQgZXhwZWN0ZWQeUk9PVF9QQVJUX0hJVF9SQURJVVNfQVRUUl9OQU1FDEdldEF0dHJpYnV0ZRxERUZBVUxUX1JPT1RfUEFSVF9ISVRfUkFESVVTFGdldFJvb3RQYXJ0SGl0UmFkaXVzDFNldEF0dHJpYnV0ZRRzZXRSb290UGFydEhpdFJhZGl1cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQZDb21iYXQMQ29tYmF0Q29uc3RzAAMEAQEAAAYDAAAFAQcUTQEAugAAAADwAQUAAQAAAKQBAwAAACBAbwIEAJ8BAgH7AwAATQMDvQUAAAC8AQASBgAAAJ8BAwJSAgEAKwIDAPsCAABNAgLKBwAAAIICAgAIAwEDAgMDBAAAIEADBAMFAwYDBwAECAEYAAAAAAEAAAACAAAAAAABAAAAAAAFAAAAAAYCAQAABwQAAAUCBwIQTQIAugAAAADwAgUAAQAAAKQCAwAAACBAbwMEAJ8CAgH7BAAATQQEvQUAAABSBQEAvAIALgYAAACfAgQBggABAAcDAQMCAwMEAAAgQAMEAwUDCQALCgEYAAAAAAEAAAACAAAAAAAAAQwAAAAABAAAAQIAGaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAEIGAAAATQICjwcAAACfAQIC/wICAAAAAADAAwgAEgABADADAj8JAAAAwAMKABIAAQAwAwIzCwAAAIICAgAMAwsEAAAAQAMMAw0DDgQAAEBAAw8DEAYAAwgGAQMKAgABAQABGAAAAAAAAAABAAAAAAAAAQABAAAABwAAAAYBAAAAAAJlmFtxoDSV9tEFs0nUJgFnFYBMBVdcMXA=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:16
-- Luau version 6, Types version 3
-- Time taken: 0.001729 seconds

local CombatConsts_upvr = require(game:GetService("ReplicatedStorage").Combat.CombatConsts)
return {
    getRootPartHitRadius = function(arg1) -- Line 4, Named "getRootPartHitRadius"
        --[[ Upvalues[1]:
            [1]: CombatConsts_upvr (readonly)
        ]]
        if arg1.Name ~= "HumanoidRootPart" then
            warn("HumanoidRootPart expected")
        end
        local attribute = arg1:GetAttribute(CombatConsts_upvr.ROOT_PART_HIT_RADIUS_ATTR_NAME)
        if not attribute then
            attribute = CombatConsts_upvr
            attribute = attribute.DEFAULT_ROOT_PART_HIT_RADIUS
        end
        return attribute
    end;
    setRootPartHitRadius = function(arg1, arg2) -- Line 11, Named "setRootPartHitRadius"
        --[[ Upvalues[1]:
            [1]: CombatConsts_upvr (readonly)
        ]]
        if arg1.Name ~= "HumanoidRootPart" then
            warn("HumanoidRootPart expected")
        end
        arg1:SetAttribute(CombatConsts_upvr.ROOT_PART_HIT_RADIUS_ATTR_NAME, arg2)
    end;
}