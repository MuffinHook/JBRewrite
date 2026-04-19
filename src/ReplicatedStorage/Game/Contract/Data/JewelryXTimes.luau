-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPHlJvYiB0aGUgSmV3ZWxyeSBTdG9yZSAlZCB0aW1lcwdHZXRHb2FsBmZvcm1hdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQhTZXR0aW5ncwhSZXNvdXJjZQhFbnVtVGVhbQhDcmltaW5hbAZ0ZWFtSWQHbWVzc2FnZQRnb2FsCXJld2FyZEV4cAACBQEAAAAHAAABAwEEAghvAQAAvAMAFQEAAACfAwIAvAEBjQIAAACfAQAAggEAAAMDAQMCAwMABgABGAAAAAAAAAAABwAAAAAEAAABAgAgowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAYgcAAABNAgPKBgAAAJ8BAgL/AgMAAAAAAE0DAUwIAAAATQMDdQkAAAAwAwJvCgAAAMADCwAwAwKYDAAAAIwDBQAwAwIKDQAAAIwDMgAwAwIDDgAAAIICAgAPAwQEAAAAQAMFAwYDBwQAAEBAAwgDCQMKAwsDDAYAAw0DDgMPAQABAAEYAAAAAAAAAAEAAAAAAAACAAEAAAAAAAEAAAMAAAEAAAEBAAAAAAHOyYzvjFSSQ2K5OSTcTXifvtGbm/wN5u4=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:31
-- Luau version 6, Types version 3
-- Time taken: 0.000687 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Rob the Jewelry Store %d times":format(arg1:GetGoal())
    end;
    goal = 5;
    rewardExp = 50;
}