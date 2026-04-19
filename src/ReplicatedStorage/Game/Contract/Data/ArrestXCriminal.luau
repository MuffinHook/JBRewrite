-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRFEFycmVzdCAlZCBjcmltaW5hbHMuB0dldEdvYWwGZm9ybWF0BG1hdGgGcmFuZG9tBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlCEVudW1UZWFtBlBvbGljZQZ0ZWFtSWQHbWVzc2FnZQRnb2FsCXJld2FyZEV4cAADBQEAAAAHAAABAwEEAghvAQAAvAMAFQEAAACfAwIAvAEBjQIAAACfAQAAggEAAAMDAQMCAwMABgABGAAAAAAAAAAABwAAAAADAAAAAAAGpAACAAAEAICMAQwAjAIPAJ8AAwCCAAAAAwMEAwUEAAQAgAAJAAEYAAAAAAAACgAAAAAEAAABAgAgowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAYgcAAABNAgPKBgAAAJ8BAgL/AgMAAAAAAE0DAUwIAAAATQMDsgkAAAAwAwJvCgAAAMADCwAwAwKYDAAAAMADDQAwAwIKDgAAAIwDMgAwAwIDDwAAAIICAgAQAwYEAAAAQAMHAwgDCQQAAEBAAwoDCwMMAw0DDgYAAw8GAQMQAxECAAEBAAEYAAAAAAAAAAEAAAAAAAACAAEAAAAAAAEAAAMAAAMAAAEBAAAAAAJ7Q/0zeJ7VkPs1Ipej5H+MC1vqR0mHlzI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:24
-- Luau version 6, Types version 3
-- Time taken: 0.001114 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Arrest %d criminals.":format(arg1:GetGoal())
    end;
    goal = function() -- Line 9
        return math.random(12, 15)
    end;
    rewardExp = 50;
}