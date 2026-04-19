-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBmFzc2VydAhJbnN0YW5jZQNJc0ELdmFsaWRhdGVPYmoYQVJNSU5HX1RFQU1fSURfQVRUUl9OQU1FDEdldEF0dHJpYnV0ZQ9nZXRBcm1pbmdUZWFtSWQMU2V0QXR0cmlidXRlD3NldEFybWluZ1RlYW1JZAdyZXF1aXJlBnNjcmlwdAZQYXJlbnQLVmF1bHRDb25zdHMABAUBAAAAABFHAAIAAAAAgKkCAAGpAgEAuwECAqQBAQAAAABAnwECAW8EAgC8AgD+AwAAAJ8CAwBMAQACpAEBAAAAAECfAQABggABAAQDAQQAAABAAwIDAwADBAEYAAAAAAAAAAABAAAAAAAAAAEEAAAAAAUBAQAAABdHAAIAAAAAgKkCAAGpAgEAuwECAqQBAQAAAABAnwECAW8EAgC8AgD+AwAAAJ8CAwBMAQACpAEBAAAAAECfAQAB+wMAAE0DA8UEAAAAvAEAEgUAAACfAQMAggEAAAYDAQQAAABAAwIDAwMFAwYACQcBGAAAAAAAAAAAAQAAAAAAAAAGAAAAAAAABAAAAAAGAgEAAAAYRwACAAAAAICpAwABqQMBALsBAwKkAgEAAAAAQJ8CAgFvBQIAvAMA/gMAAACfAwMATAEAAqQCAQAAAABAnwIAAfsEAABNBATFBAAAAFIFAQC8AgAuBQAAAJ8CBAGCAAEABgMBBAAAAEADAgMDAwUDCAANCQEYAAAAAAAAAAABAAAAAAAAAAoAAAAAAAABBAAAAAAEAAABAgAWowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAdEFAAAAnwACAsABBgD/AgIAAAAAAMADBwASAAAAMAMCPggAAADAAwkAEgAAADADAioKAAAAggICAAsDCgQAAABAAwsEAAAgQAMMAw0GAAYBAwcGAgMJAwABAgEAARgAAAAAAAAAAAAAAgQAAgAAAAQAAAAEAQAAAAADEkI4jKkxlKfB0wzgAa8NGmJaL/gghlKN

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:09
-- Luau version 6, Types version 3
-- Time taken: 0.002385 seconds

local VaultConsts_upvr = require(script.Parent.VaultConsts)
local function _(arg1) -- Line 3, Named "validateObj"
    if arg1 == nil then
    else
    end
    assert(true)
    assert(arg1:IsA("Instance"))
end
return {
    getArmingTeamId = function(arg1) -- Line 9, Named "getArmingTeamId"
        --[[ Upvalues[1]:
            [1]: VaultConsts_upvr (readonly)
        ]]
        if arg1 == nil then
        else
        end
        assert(true)
        assert(arg1:IsA("Instance"))
        return arg1:GetAttribute(VaultConsts_upvr.ARMING_TEAM_ID_ATTR_NAME)
    end;
    setArmingTeamId = function(arg1, arg2) -- Line 13, Named "setArmingTeamId"
        --[[ Upvalues[1]:
            [1]: VaultConsts_upvr (readonly)
        ]]
        if arg1 == nil then
        else
        end
        assert(true)
        assert(arg1:IsA("Instance"))
        arg1:SetAttribute(VaultConsts_upvr.ARMING_TEAM_ID_ATTR_NAME, arg2)
    end;
}