-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPIVN1cnZpdmUgJWQgbWludXRlcyB3aXRob3V0IGR5aW5nLgdHZXRHb2FsBmZvcm1hdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQhTZXR0aW5ncwhSZXNvdXJjZQhFbnVtVGVhbQZQb2xpY2UGdGVhbUlkB21lc3NhZ2UEZ29hbAlyZXdhcmRFeHAAAgUBAAAABwAAAQMBBAIIbwEAALwDABUBAAAAnwMCALwBAY0CAAAAnwEAAIIBAAADAwEDAgMDAAYAARgAAAAAAAAAAAcAAAAABAAAAQIAIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAGIHAAAATQIDygYAAACfAQIC/wIDAAAAAABNAwFMCAAAAE0DA7IJAAAAMAMCbwoAAADAAwsAMAMCmAwAAACMAwcAMAMCCg0AAACMAxkAMAMCAw4AAACCAgIADwMEBAAAAEADBQMGAwcEAABAQAMIAwkDCgMLAwwGAAMNAw4DDwEAAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAAABAAADAAABAAABAQAAAAABgRwQMZLvWiUTw4g3BqqKNPEEB0Wz2How

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:33
-- Luau version 6, Types version 3
-- Time taken: 0.000894 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Survive %d minutes without dying.":format(arg1:GetGoal())
    end;
    goal = 7;
    rewardExp = 25;
}