-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPIFVzZSByb2FkIHNwaWtlcyB0byBwb3AgJWQgdGlyZXMuB0dldEdvYWwGZm9ybWF0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlCEVudW1UZWFtBlBvbGljZQZ0ZWFtSWQHbWVzc2FnZQRnb2FsCXJld2FyZEV4cAACBQEAAAAHAAABAwEEAghvAQAAvAMAFQEAAACfAwIAvAEBjQIAAACfAQAAggEAAAMDAQMCAwMABgABGAAAAAAAAAAABwAAAAAEAAABAgAgowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAYgcAAABNAgPKBgAAAJ8BAgL/AgMAAAAAAE0DAUwIAAAATQMDsgkAAAAwAwJvCgAAAMADCwAwAwKYDAAAAIwDAwAwAwIKDQAAAIwDMgAwAwIDDgAAAIICAgAPAwQEAAAAQAMFAwYDBwQAAEBAAwgDCQMKAwsDDAYAAw0DDgMPAQABAAEYAAAAAAAAAAEAAAAAAAACAAEAAAAAAAEAAAMAAAEAAAEBAAAAAAEHTvPGp353v/tI6/CQEaaWd1bksjWKmcc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:36
-- Luau version 6, Types version 3
-- Time taken: 0.000707 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Use road spikes to pop %d tires.":format(arg1:GetGoal())
    end;
    goal = 3;
    rewardExp = 50;
}