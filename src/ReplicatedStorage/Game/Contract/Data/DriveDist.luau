-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPFkRyaXZlIG9yIGZseSAlZCBtaWxlcy4HR2V0R29hbAZmb3JtYXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUIU2V0dGluZ3MIUmVzb3VyY2UIRW51bVRlYW0IQ3JpbWluYWwGdGVhbUlkB21lc3NhZ2UEZ29hbAlyZXdhcmRFeHAAAgUBAAAABwAAAQMBBAIIbwEAALwDABUBAAAAnwMCALwBAY0CAAAAnwEAAIIBAAADAwEDAgMDAAYAARgAAAAAAAAAAAcAAAAABAAAAQIAIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAGIHAAAATQIDygYAAACfAQIC/wIDAAAAAABNAwFMCAAAAE0DA3UJAAAAMAMCbwoAAADAAwsAMAMCmAwAAACMAxkAMAMCCg0AAACMAx4AMAMCAw4AAACCAgIADwMEBAAAAEADBQMGAwcEAABAQAMIAwkDCgMLAwwGAAMNAw4DDwEAAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAAABAAADAAABAAABAQAAAAABAGrrPgbocheDyf4Ue135fXBy/EoyroE/

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:29
-- Luau version 6, Types version 3
-- Time taken: 0.000846 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Drive or fly %d miles.":format(arg1:GetGoal())
    end;
    goal = 25;
    rewardExp = 30;
}