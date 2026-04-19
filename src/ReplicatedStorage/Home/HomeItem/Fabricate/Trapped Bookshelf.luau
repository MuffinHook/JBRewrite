-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaBUV2ZW50BGluaXQIZG9vck5hbWUKc3Bpa2VzTmFtZQ1yZWZlcmVuY2VOYW1lCnJlZ2lvbk5hbWUIb2Zmc2V0Q2YMc3Bpa2VTaXplTWluDHNwaWtlU2l6ZU1heAxkYW1hZ2VBbW91bnQHYXVkaW9JZA5kb29yQ2xvc2VEZWxheQhGYWtlRG9vcgZTcGlrZXMIU2hlbHZpbmcGUmVnaW9uBkNGcmFtZQNuZXcFc2V0dXAEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudBBUcmFwcGVkVHJhcFV0aWxzAAMCAQEAAAAETQEANgAAAADeAQAAggABAAEDAQAGAgEYAAAAAQcAAAAADwECAAAANeIBCgBvAgsAMAIB/gAAAABvAgwAMAIBsgEAAABvAg0AMAIB1wIAAABvAg4AMAIBewMAAACkAhEAAEDwgG8DEgBvBBMAbwUUAIwGAQCMBwAAjAgAAIwJAACMCgEAjAsAAIwMAACMDQAAjA4BAJ8CDQIwAgFeBAAAAG8CFQAwAgG3BQAAAG8CFgAwAgEIBgAAAIwCJAAwAgFaBwAAAG8CFwAwAgFxCAAAAIwCAQAwAgHTCQAAAPsCAABNAgL5GAAAAFIDAABSBAEA+wUBAJ8CBAGCAAEAGQMDAwQDBQMGAwcDCAMJAwoDCwMMBQoAAQIDBAUGBwgJAw0DDgMPAxADEQMSBABA8IACumIuAAANtz8CQX1eAAARwj8Cy6FFtvP96D8Cy6FFtvP9+D8CiUFg5dAiGkACAACQsCq9+UEDEwAJEwEYAAEAAAEAAAEAAAEAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAQAAAQAAAQAAAQAAAgAAAAAAAAEKAAAAAAUAAAECAB6jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQICUgkAAACfAQICxgIAAP8DAgAAAAAA2QQAABIBAv8wBAMTCgAAANkEAQASAAEAEgEC/zAEA/kLAAAAwQIAAIIDAgAMAxQEAAAAQAMVAxYDFwQAAEBAAxgEAABgQAMZAxoDAgMTAgABAQABGAAAAAAAAAABAAAAAAAAAAACAQABAAAAAwAAAAAPAAEAAAAAAjaSK8fR0CxxWm3R7QTJHphGijyzBFZBxg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:03
-- Luau version 6, Types version 3
-- Time taken: 0.001164 seconds

local var1_upvw
local module = {
    init = function(arg1) -- Line 6, Named "init"
        --[[ Upvalues[1]:
            [1]: var1_upvw (read and write)
        ]]
        var1_upvw = arg1.Event
    end;
}
local TrappedTrapUtils_upvr = require(script.Parent.TrappedTrapUtils)
function module.setup(arg1) -- Line 9
    --[[ Upvalues[2]:
        [1]: TrappedTrapUtils_upvr (readonly)
        [2]: var1_upvw (read and write)
    ]]
    TrappedTrapUtils_upvr.setup(arg1, {
        doorName = "FakeDoor";
        spikesName = "Spikes";
        referenceName = "Shelving";
        regionName = "Region";
        offsetCf = CFrame.new(0.0900421143, 0.141143799, 0.781, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        spikeSizeMin = 1.562;
        spikeSizeMax = 6.534;
        damageAmount = 36;
        audioId = 6909242121;
        doorCloseDelay = 1;
    }, var1_upvw)
end
return module