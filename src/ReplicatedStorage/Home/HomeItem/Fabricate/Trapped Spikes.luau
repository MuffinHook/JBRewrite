-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaBUV2ZW50BGluaXQIZG9vck5hbWUKc3Bpa2VzTmFtZQ1yZWZlcmVuY2VOYW1lCnJlZ2lvbk5hbWUIb2Zmc2V0Q2YMc3Bpa2VTaXplTWluDHNwaWtlU2l6ZU1heAxkYW1hZ2VBbW91bnQHYXVkaW9JZA5kb29yQ2xvc2VEZWxheQhGYWtlRG9vcgZTcGlrZXMFTWV0YWwGUmVnaW9uBkNGcmFtZQNuZXcFc2V0dXAEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudBBUcmFwcGVkVHJhcFV0aWxzAAMCAQEAAAAETQEANgAAAADeAQAAggABAAEDAQAGAgEYAAAAAQcAAAAADwECAAAANeIBCgBvAgsAMAIB/gAAAABvAgwAMAIBsgEAAABvAg0AMAIB1wIAAABvAg4AMAIBewMAAACkAhEAAEDwgG8DEgBvBBMAbwUUAIwGAQCMBwAAjAgAAIwJAACMCgEAjAsAAIwMAACMDQAAjA4BAJ8CDQIwAgFeBAAAAG8CFQAwAgG3BQAAAIwCBQAwAgEIBgAAAIwCJAAwAgFaBwAAAG8CFgAwAgFxCAAAAIwCAQAwAgHTCQAAAPsCAABNAgL5FwAAAFIDAABSBAEA+wUBAJ8CBAGCAAEAGAMDAwQDBQMGAwcDCAMJAwoDCwMMBQoAAQIDBAUGBwgJAw0DDgMPAxADEQMSBABA8IACAPZXAAAAZ78Cem8MAcDB8r8CoY92///P1j8C9ihcj8L19D8CAACQsCq9+UEDEwAJEwEYAAEAAAEAAAEAAAEAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAQAAAQAAAQAAAQAAAgAAAAAAAAEKAAAAAAUAAAECAB6jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQICUgkAAACfAQICxgIAAP8DAgAAAAAA2QQAABIBAv8wBAMTCgAAANkEAQASAAEAEgEC/zAEA/kLAAAAwQIAAIIDAgAMAxQEAAAAQAMVAxYDFwQAAEBAAxgEAABgQAMZAxoDAgMTAgABAQABGAAAAAAAAAABAAAAAAAAAAACAQABAAAAAwAAAAAPAAEAAAAAAl0g0DPRlcEAp9XLTtTTP58tOMdHb+S6Mg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:03
-- Luau version 6, Types version 3
-- Time taken: 0.001271 seconds

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
        referenceName = "Metal";
        regionName = "Region";
        offsetCf = CFrame.new(-0.00280761719, -1.17230225, 0.356445312, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        spikeSizeMin = 1.31;
        spikeSizeMax = 5;
        damageAmount = 36;
        audioId = 6909242121;
        doorCloseDelay = 1;
    }, var1_upvw)
end
return module