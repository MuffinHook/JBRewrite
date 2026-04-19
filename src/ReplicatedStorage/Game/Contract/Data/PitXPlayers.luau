-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRJFBpdCBtYW5ldXZlciAlZCBkaWZmZXJlbnQgY3JpbWluYWxzLgdHZXRHb2FsBmZvcm1hdARtYXRoBnJhbmRvbQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQhTZXR0aW5ncwhSZXNvdXJjZQhFbnVtVGVhbQZQb2xpY2UGdGVhbUlkB21lc3NhZ2UEZ29hbAlyZXdhcmRFeHAAAwUBAAAABwAAAQMBBAIIbwEAALwDABUBAAAAnwMCALwBAY0CAAAAnwEAAIIBAAADAwEDAgMDAAYAARgAAAAAAAAAAAcAAAAAAwAAAAAABqQAAgAABACAjAEFAIwCBwCfAAMAggAAAAMDBAMFBAAEAIAACQABGAAAAAAAAAoAAAAABAAAAQIAIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAGIHAAAATQIDygYAAACfAQIC/wIDAAAAAABNAwFMCAAAAE0DA7IJAAAAMAMCbwoAAADAAwsAMAMCmAwAAADAAw0AMAMCCg4AAACMAygAMAMCAw8AAACCAgIAEAMGBAAAAEADBwMIAwkEAABAQAMKAwsDDAMNAw4GAAMPBgEDEAMRAgABAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAAABAAADAAADAAABAQAAAAACMFfdUTVjP67KnXqer/JAukBPyiUCk7dQ

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:33
-- Luau version 6, Types version 3
-- Time taken: 0.000895 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Pit maneuver %d different criminals.":format(arg1:GetGoal())
    end;
    goal = function() -- Line 9
        return math.random(5, 7)
    end;
    rewardExp = 40;
}