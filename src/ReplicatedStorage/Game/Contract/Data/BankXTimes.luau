-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRFlJvYiB0aGUgQmFuayAlZCB0aW1lcy4HR2V0R29hbAZmb3JtYXQEbWF0aAZyYW5kb20EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUIU2V0dGluZ3MIUmVzb3VyY2UIRW51bVRlYW0IQ3JpbWluYWwGdGVhbUlkB21lc3NhZ2UEZ29hbAlyZXdhcmRFeHAAAwUBAAAABwAAAQMBBAIIbwEAALwDABUBAAAAnwMCALwBAY0CAAAAnwEAAIIBAAADAwEDAgMDAAYAARgAAAAAAAAAAAcAAAAAAwAAAAAABqQAAgAABACAjAEDAIwCBACfAAMAggAAAAMDBAMFBAAEAIAACQABGAAAAAAAAAoAAAAABAAAAQIAIKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAGIHAAAATQIDygYAAACfAQIC/wIDAAAAAABNAwFMCAAAAE0DA3UJAAAAMAMCbwoAAADAAwsAMAMCmAwAAADAAw0AMAMCCg4AAACMAzwAMAMCAw8AAACCAgIAEAMGBAAAAEADBwMIAwkEAABAQAMKAwsDDAMNAw4GAAMPBgEDEAMRAgABAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAAABAAADAAADAAABAQAAAAACi7eQEliYsILpIgnEuZWlUPuvh2a5c/oT

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:25
-- Luau version 6, Types version 3
-- Time taken: 0.001098 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Rob the Bank %d times.":format(arg1:GetGoal())
    end;
    goal = function() -- Line 9
        return math.random(3, 4)
    end;
    rewardExp = 60;
}