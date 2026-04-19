-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPHlN0YXJ0IGEgYmFuayByb2JiZXJ5ICVkIHRpbWVzIQdHZXRHb2FsBmZvcm1hdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQhTZXR0aW5ncwhSZXNvdXJjZQhFbnVtVGVhbQhDcmltaW5hbAZ0ZWFtSWQHbWVzc2FnZQRnb2FsCXJld2FyZEV4cAACBQEAAAAHAAABAwEEAghvAQAAvAMAFQEAAACfAwIAvAEBjQIAAACfAQAAggEAAAMDAQMCAwMABgABGAAAAAAAAAAABwAAAAAEAAABAgAgowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAYgcAAABNAgPKBgAAAJ8BAgL/AgMAAAAAAE0DAUwIAAAATQMDdQkAAAAwAwJvCgAAAMADCwAwAwKYDAAAAIwDAgAwAwIKDQAAAIwDIwAwAwIDDgAAAIICAgAPAwQEAAAAQAMFAwYDBwQAAEBAAwgDCQMKAwsDDAYAAw0DDgMPAQABAAEYAAAAAAAAAAEAAAAAAAACAAEAAAAAAAEAAAMAAAEAAAEBAAAAAAG7ZEm0o4uVKN9KUDs/4f1ry3xewImgI7U=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:39
-- Luau version 6, Types version 3
-- Time taken: 0.000882 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Start a bank robbery %d times!":format(arg1:GetGoal())
    end;
    goal = 2;
    rewardExp = 35;
}