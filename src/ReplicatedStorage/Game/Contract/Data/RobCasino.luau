-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPHVJvYiB0aGUgQ3Jvd24gSmV3ZWwgJWQgdGltZXMhB0dldEdvYWwGZm9ybWF0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlCEVudW1UZWFtCENyaW1pbmFsBnRlYW1JZAdtZXNzYWdlBGdvYWwJcmV3YXJkRXhwAAIFAQAAAAcAAAEDAQQCCG8BAAC8AwAVAQAAAJ8DAgC8AQGNAgAAAJ8BAACCAQAAAwMBAwIDAwAGAAEYAAAAAAAAAAAHAAAAAAQAAAECACCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAwBiBwAAAE0CA8oGAAAAnwECAv8CAwAAAAAATQMBTAgAAABNAwN1CQAAADADAm8KAAAAwAMLADADApgMAAAAjAMDADADAgoNAAAAjAM3ADADAgMOAAAAggICAA8DBAQAAABAAwUDBgMHBAAAQEADCAMJAwoDCwMMBgADDQMOAw8BAAEAARgAAAAAAAAAAQAAAAAAAAIAAQAAAAAAAQAAAwAAAQAAAQEAAAAAAYPmJpcMyf5lV2RP95D3m43z/jHjsSJMlg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:36
-- Luau version 6, Types version 3
-- Time taken: 0.000661 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Rob the Crown Jewel %d times!":format(arg1:GetGoal())
    end;
    goal = 3;
    rewardExp = 55;
}