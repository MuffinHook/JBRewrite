-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPElRhemUgJWQgY3JpbWluYWxzLgdHZXRHb2FsBmZvcm1hdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQhTZXR0aW5ncwhSZXNvdXJjZQhFbnVtVGVhbQZQb2xpY2UGdGVhbUlkB21lc3NhZ2UEZ29hbAlyZXdhcmRFeHAAAgUBAAAABwAAAQMBBAIIbwEAALwDABUBAAAAnwMCALwBAY0CAAAAnwEAAIIBAAADAwEDAgMDAAYAARgAAAAAAAAAAAcAAAAABAAAAQIAIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAGIHAAAATQIDygYAAACfAQIC/wIDAAAAAABNAwFMCAAAAE0DA7IJAAAAMAMCbwoAAADAAwsAMAMCmAwAAACMAwYAMAMCCg0AAACMAx4AMAMCAw4AAACCAgIADwMEBAAAAEADBQMGAwcEAABAQAMIAwkDCgMLAwwGAAMNAw4DDwEAAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAAABAAADAAABAAABAQAAAAABymID+8qz11t8vvnKgRNv57p6FI/4pmn6

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:41
-- Luau version 6, Types version 3
-- Time taken: 0.000661 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Taze %d criminals.":format(arg1:GetGoal())
    end;
    goal = 6;
    rewardExp = 30;
}