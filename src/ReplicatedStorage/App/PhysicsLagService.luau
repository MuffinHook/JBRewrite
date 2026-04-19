-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMGHGdldEVzdGltYXRlZFBoeXNpY3NTdGVwc011bHQEZ2FtZQpSdW5TZXJ2aWNlCkdldFNlcnZpY2UHU3RlcHBlZAdDb25uZWN0AAMGAgEAAAAH+wIAAPsFAAAmBAEFWwMEAEMCAgPeAgAAggABAAECmpmZmZmZuT8ABwABGAAAAAAAAAEIAAAAAAIAAQAAAAP7AQAAPgABAIIAAgABAhEREREREZE/AAwBARgAAAANAAAAAAUAAAECABejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCbwEEAE0CANkFAAAA2QQAABIBAf+8AgLHBgAAAJ8CAwH/AgEAAAAAANkDAQASAQH/MAMCIwcAAADBAQAAggICAAgDAgQAAABAAwMDBAIRERERERGRPwMFAwYDAQIAAQEAARgAAAAAAAAABQEAAAAAAAAEAAEAAAADAAEAAAAAAj8a1z1rTipOM7Jc2Ue36mlPAsBJDd69PA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:25
-- Luau version 6, Types version 3
-- Time taken: 0.000806 seconds

local var1_upvw = (1/60)
game:GetService("RunService").Stepped:Connect(function(arg1, arg2) -- Line 7
    --[[ Upvalues[1]:
        [1]: var1_upvw (read and write)
    ]]
    var1_upvw += (arg2 - var1_upvw) * 0.1
end)
return {
    getEstimatedPhysicsStepsMult = function() -- Line 12, Named "getEstimatedPhysicsStepsMult"
        --[[ Upvalues[1]:
            [1]: var1_upvw (read and write)
        ]]
        return var1_upvw / (1/60)
    end;
}