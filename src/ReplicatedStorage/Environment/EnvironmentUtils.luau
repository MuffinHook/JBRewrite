-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSFVRJTUVfT0ZfREFZX0FUVFJfTkFNRQxTZXRBdHRyaWJ1dGUMc2V0VGltZU9mRGF5DEdldEF0dHJpYnV0ZQxnZXRUaW1lT2ZEYXkZR2V0QXR0cmlidXRlQ2hhbmdlZFNpZ25hbBlnZXRUaW1lT2ZEYXlDaGFuZ2VkU2lnbmFsF1BSRUNJUElUQVRJT05fQVRUUl9OQU1FEHNldFByZWNpcGl0YXRpb24QZ2V0UHJlY2lwaXRhdGlvbh1nZXRQcmVjaXBpdGF0aW9uQ2hhbmdlZFNpZ25hbARnYW1lCExpZ2h0aW5nCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQtFbnZpcm9ubWVudBFFbnZpcm9ubWVudENvbnN0cwAHBQECAAAACvsBAAD7AwEATQMDwwAAAABSBAAAvAEBLgEAAACfAQQBqQEBAIIBAgACAwEDAgAHAwEYAAAAAAAAAAABAAgAAAAAAwACAAAACPsAAAD7AgEATQICwwAAAAC8AAASAQAAAJ8AAwCCAAAAAgMBAwQACwUBGAAAAAAAAAAADAAAAAADAAIAAAAI+wAAAPsCAQBNAgLDAAAAALwAABYBAAAAnwADAIIAAAACAwEDBgAOBwEYAAAAAAAAAAAPAAAAAAUBAgAAAAr7AQAA+wMBAE0DA2cAAAAAUgQAALwBAS4BAAAAnwEEAakBAQCCAQIAAgMIAwIAEQkBGAAAAAAAAAAAAQASAAAAAAMAAgAAAAj7AAAA+wIBAE0CAmcAAAAAvAAAEgEAAACfAAMAggAAAAIDCAMEABUKARgAAAAAAAAAABYAAAAAAwACAAAACPsAAAD7AgEATQICZwAAAAC8AAAWAQAAAJ8AAwCCAAAAAgMIAwYAGAsBGAAAAAAAAAAAGQAAAAAFAAABAgA1owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCBgAAAFBATQMB+wcAAABNAwNTCAAAAJ8CAgL/AwQAAAAAAMAECQASAAAAEgACADAEA9cKAAAAwAQLABIAAAASAAIAMAQD4wwAAADABA0AEgAAABIAAgAwBAODDgAAAMAEDwASAAAAEgACADAEA9oQAAAAwAQRABIAAAASAAIAMAQDxhIAAADABBMAEgAAABIAAgAwBAP5FAAAAIIDAgAVAwwEAAAAQAMNAw4DDwMQBAAAUEADEQMSBgADAwYBAwUGAgMHBgMDCQYEAwoGBQMLBgABAgMEBQEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAIAAgAAAAAEAAAAAAMAAAAAAwAAAAAEAAAAAAMAAAAAAwEAAAAABs9z4qXB6bJYZUQJBuf7cwS/a/XR/beIpA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:34
-- Luau version 6, Types version 3
-- Time taken: 0.001761 seconds

local Lighting_upvr = game:GetService("Lighting")
local EnvironmentConsts_upvr = require(game:GetService("ReplicatedStorage").Environment.EnvironmentConsts)
return {
    setTimeOfDay = function(arg1) -- Line 7, Named "setTimeOfDay"
        --[[ Upvalues[2]:
            [1]: Lighting_upvr (readonly)
            [2]: EnvironmentConsts_upvr (readonly)
        ]]
        Lighting_upvr:SetAttribute(EnvironmentConsts_upvr.TIME_OF_DAY_ATTR_NAME, arg1)
        return true
    end;
    getTimeOfDay = function() -- Line 11, Named "getTimeOfDay"
        --[[ Upvalues[2]:
            [1]: Lighting_upvr (readonly)
            [2]: EnvironmentConsts_upvr (readonly)
        ]]
        return Lighting_upvr:GetAttribute(EnvironmentConsts_upvr.TIME_OF_DAY_ATTR_NAME)
    end;
    getTimeOfDayChangedSignal = function() -- Line 14, Named "getTimeOfDayChangedSignal"
        --[[ Upvalues[2]:
            [1]: Lighting_upvr (readonly)
            [2]: EnvironmentConsts_upvr (readonly)
        ]]
        return Lighting_upvr:GetAttributeChangedSignal(EnvironmentConsts_upvr.TIME_OF_DAY_ATTR_NAME)
    end;
    setPrecipitation = function(arg1) -- Line 17, Named "setPrecipitation"
        --[[ Upvalues[2]:
            [1]: Lighting_upvr (readonly)
            [2]: EnvironmentConsts_upvr (readonly)
        ]]
        Lighting_upvr:SetAttribute(EnvironmentConsts_upvr.PRECIPITATION_ATTR_NAME, arg1)
        return true
    end;
    getPrecipitation = function() -- Line 21, Named "getPrecipitation"
        --[[ Upvalues[2]:
            [1]: Lighting_upvr (readonly)
            [2]: EnvironmentConsts_upvr (readonly)
        ]]
        return Lighting_upvr:GetAttribute(EnvironmentConsts_upvr.PRECIPITATION_ATTR_NAME)
    end;
    getPrecipitationChangedSignal = function() -- Line 24, Named "getPrecipitationChangedSignal"
        --[[ Upvalues[2]:
            [1]: Lighting_upvr (readonly)
            [2]: EnvironmentConsts_upvr (readonly)
        ]]
        return Lighting_upvr:GetAttributeChangedSignal(EnvironmentConsts_upvr.PRECIPITATION_ATTR_NAME)
    end;
}