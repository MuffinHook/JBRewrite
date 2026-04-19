-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPFlJvYiB0aGUgVG9tYiAlZCB0aW1lcyEHR2V0R29hbAZmb3JtYXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUIU2V0dGluZ3MIUmVzb3VyY2UIRW51bVRlYW0IQ3JpbWluYWwGdGVhbUlkB21lc3NhZ2UEZ29hbAlyZXdhcmRFeHAAAgUBAAAABwAAAQMBBAIIbwEAALwDABUBAAAAnwMCALwBAY0CAAAAnwEAAIIBAAADAwEDAgMDAAYAARgAAAAAAAAAAAcAAAAABAAAAQIAIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAGIHAAAATQIDygYAAACfAQIC/wIDAAAAAABNAwFMCAAAAE0DA3UJAAAAMAMCbwoAAADAAwsAMAMCmAwAAACMAwQAMAMCCg0AAACMAzwAMAMCAw4AAACCAgIADwMEBAAAAEADBQMGAwcEAABAQAMIAwkDCgMLAwwGAAMNAw4DDwEAAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAAABAAADAAABAAABAQAAAAABL0z+U84xkOkgPi1BYleCZV9U6ScdiJRS

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:39
-- Luau version 6, Types version 3
-- Time taken: 0.000685 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Rob the Tomb %d times!":format(arg1:GetGoal())
    end;
    goal = 4;
    rewardExp = 60;
}