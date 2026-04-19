-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRFEtub2NrIG92ZXIgJWQgaXRlbXMuB0dldEdvYWwGZm9ybWF0BG1hdGgGcmFuZG9tBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlCEVudW1UZWFtCENyaW1pbmFsBnRlYW1JZAdtZXNzYWdlBGdvYWwJcmV3YXJkRXhwAAMFAQAAAAcAAAEDAQQCCG8BAAC8AwAVAQAAAJ8DAgC8AQGNAgAAAJ8BAACCAQAAAwMBAwIDAwAGAAEYAAAAAAAAAAAHAAAAAAUAAAAAAAiMAZABpAICAAAEAICMAwAAjAQKAJ8CAwJDAAECggACAAMDBAMFBAAEAIAACQABGAAAAAAAAAAACgAAAAAEAAABAgAgowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAYgcAAABNAgPKBgAAAJ8BAgL/AgMAAAAAAE0DAUwIAAAATQMDdQkAAAAwAwJvCgAAAMADCwAwAwKYDAAAAMADDQAwAwIKDgAAAIwDLQAwAwIDDwAAAIICAgAQAwYEAAAAQAMHAwgDCQQAAEBAAwoDCwMMAw0DDgYAAw8GAQMQAxECAAEBAAEYAAAAAAAAAAEAAAAAAAACAAEAAAAAAAEAAAMAAAMAAAEBAAAAAAKDQLM0gbHx0zncpveEXbXe81ikQLGE2TU=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:42
-- Luau version 6, Types version 3
-- Time taken: 0.000866 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Knock over %d items.":format(arg1:GetGoal())
    end;
    goal = function() -- Line 9
        return 400 + math.random(0, 10)
    end;
    rewardExp = 45;
}