-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPF1JvYiB0aGUgVHJhaW4gJWQgdGltZXMuB0dldEdvYWwGZm9ybWF0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlCEVudW1UZWFtCENyaW1pbmFsBnRlYW1JZAdtZXNzYWdlBGdvYWwJcmV3YXJkRXhwAAIFAQAAAAcAAAEDAQQCCG8BAAC8AwAVAQAAAJ8DAgC8AQGNAgAAAJ8BAACCAQAAAwMBAwIDAwAHAAEYAAAAAAAAAAAIAAAAAAQAAAECACCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAwBiBwAAAE0CA8oGAAAAnwECAv8CAwAAAAAATQMBTAgAAABNAwN1CQAAADADAm8KAAAAwAMLADADApgMAAAAjAMGADADAgoNAAAAjAMyADADAgMOAAAAggICAA8DBAQAAABAAwUDBgMHBAAAQEADCAMJAwoDCwMMBgADDQMOAw8BAAEAARgAAAAAAAAAAQAAAAAAAAIAAQAAAAAAAgAAAwAAAQAAAQEAAAAAAVj2EIbUIw7E3ld9hglVOoMo7gfyajJ6hw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:23
-- Luau version 6, Types version 3
-- Time taken: 0.000689 seconds

return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 7
        return "Rob the Train %d times.":format(arg1:GetGoal())
    end;
    goal = 6;
    rewardExp = 50;
}